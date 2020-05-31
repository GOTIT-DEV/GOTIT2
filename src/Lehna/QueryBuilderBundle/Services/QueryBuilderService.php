<?php

namespace Lehna\QueryBuilderBundle\Services;

use Doctrine\Common\Persistence\ManagerRegistry;
use Doctrine\Persistence\Mapping\ClassMetadata;
use Doctrine\Bundle\DoctrineBundle\Mapping\DisconnectedMetadataFactory;
use Psr\Container\ContainerInterface;
use Symfony\Component\Config\Definition\Exception\Exception;

/**
 * Service QueryBuilderService
 */
class QueryBuilderService
{
  private $doctrineManagerRegistry;
  private $metadataManager;
  private $container;

  public function __construct(ManagerRegistry $manager, ContainerInterface $container)
  {
    $this->container = $container;
    $this->doctrineManagerRegistry = $manager;
    $this->metadataManager =
      new DisconnectedMetadataFactory($this->doctrineManagerRegistry);
  }

  public function make_qbuilder_config()
  {
    $coreBundle = $this->container->get("kernel")->getBundle("BbeesE3sBundle");
    $metadata = $this->metadataManager
      ->getBundleMetadata($coreBundle)
      ->getMetadata();
    return $this->parse_entities_metadata($metadata);
  }

  private function parse_entity_name($entity)
  {
    $entity = explode('\\', $entity);
    return array_pop($entity);
  }

  public function parse_entities_metadata($metadata_array)
  {
    $res = [];
    $relations = [];
    foreach ($metadata_array as $m) {
      $entity = $this->parse_entity_name($m->getName());
      $res[$entity] = $this->parse_metadata($m);
      $relations[$entity] = [];
      foreach ($m->getAssociationMappings() as $field => $mapping) {
        if (array_key_exists("joinColumns", $mapping)) {
          $target = $this->parse_entity_name($mapping['targetEntity']);
          $relations[$entity][$target] = $this->parse_associated($mapping);
        }
      }
    }
    foreach ($relations as $sourceEntity => $targets) {
      foreach ($targets as $targetEntity => $data) {
        $relations[$targetEntity][$sourceEntity] = [
          "entity" => $sourceEntity,
          "from" => $data["to"],
          "to" => $data["from"]
        ];
      }
    }
    foreach ($res as $entity => $data) {
      $res[$entity]["relations"] = $relations[$entity];
    }
    return $res;
  }

  private function parse_associated($mapping)
  {
    return [
      "entity" => $this->parse_entity_name($mapping["targetEntity"]),
      "from" => $mapping["fieldName"],
      "to" => "id"
    ];
  }

  private function parse_metadata(ClassMetadata $metadata)
  {
    $make_filter = function ($field) {
      return [
        "id" => $field['fieldName'],
        "label" => $field['fieldName'],
        "type" => $this->convert_field_type($field['type'])
      ];
    };
    $entity = $metadata->getName();
    $filters = array_values(array_map($make_filter, $metadata->fieldMappings));
    return [
      "class" => $entity,
      "filters" => $filters,
      "human_readable_name" => $this->parse_entity_name($entity),
      "table" => $metadata->table["name"]
    ];
  }
  
  private function convert_field_type($type){
    if (strpos($type, "int") != false){
      $type = "integer";
    }
    elseif ($type == "float"){
      $type = "double";
    }
    elseif ($type == "text"){
      $type = "string";
    }
    elseif (strpos($type, "bool") != false){
      $type= "boolean";
    }
    // $valid_types = ["string", "integer", "double", "date", "time", "datetime", "boolean"];
    // assert(in_array($type, $valid_types));
    return $type;
  }

  /** 
   * Get the selected fields of the query to create a table for the results. 
   * 
   * Receives : the array containing the info for the query. 
   * Returns : the array with the itial tables and the adjacent tables as keys and the corresponding fields as values.  
   */
  public function getSelectFields($data)
  {
    $initialTable = $data["initial"]["initialTable"];
    $initialFields = $data["initial"]["initialFields"];
    $resultsTab = [$initialTable => $initialFields];
    if (array_key_exists("joins", $data)) {
      $joins = $data["joins"];
      foreach ($joins as $j) {
        if (count($j) == 7) {
          $adjTable = $j["adjacent_table"];
          $joinsFields = $j["fields"];
          $resultsTab[$adjTable] = $joinsFields;
        }
      }
    }

    return $resultsTab;
  }

  
  /**
   * Get the level of the first block of constraints for the querybuilder. 
   * 
   * Receives : the current level in the array, the current state of the query, the first block of the querybuilder, the first chosen table and the 
   *            condition to apply on the constraints.
   * Returns : the query with the constraints added in it.  
   * Warning : doesn't work properly when clicking ond the 'add-group' on the form.    
   */
  public function constraintsOfLevel($level, $query, $initial, $firstTable, $condition)
  {

    if (strlen($level == 1)) { // If we are on the first level, we can use the 'simple' function to get the constraints. 
      $query = $this->getFirstConstraints($firstConstraints, $initial, $query, $firstTable, $condition);
    } elseif (strlen($level > 1)) { // If we are on a deeper level : 
      foreach ($level as $r) {
        if (count($r) == 6) { // If there are no more constraints after we use the 'simple' function. 
          $query = $this->getFirstConstraints($r, $initial, $query, $firstTable, $condition);
        } elseif (count($r) == 2) { // If there are multiple constraints, we use this function on itself. 
          $query = $this->constraintsOfLevel($r["rules"], $query, $initial, $firstTable, $r["condition"]);
        }
      }
    }

    return $query;
  }


   /**
   * Get the full first block of querybuilder.
   * 
   * Receives : the full array containing the info in the form, the first block of querybuilder and the current state of the query.
   * Returns : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints.
   * Warning : by default, all fields are checked for the first table, please keep at least one box checked.   
   */
  public function getFirstBlock($data, $initial, $query)
  {

    $firstTable = $initial["initialTable"];
    $query = $query->from('BbeesE3sBundle:' . $firstTable, $firstTable);
    $firstFields = $initial["initialFields"];

    foreach ($firstFields as $value) {
      $query = $query->addSelect($firstTable . "." . $value);
    };

    if ($initial["constraintsTable1"] != "") {
      $condition = $initial["constraintsTable1"]["condition"];
      $firstConstraints = $initial["constraintsTable1"]["rules"];
      $query = $this->constraintsOfLevel($firstConstraints, $query, $initial, $firstTable, $condition);
    }

    return $query;
  }


  /**
   * Get the first constraints (simple function that is used on each constraint). 
   * 
   * Receives : the array containing the constraints in the form, the inital block of querybuilder, the current state of the query,
   *            the first chosen table and the condition to apply on the constraints. 
   * Returns : the query with the 'WHERE' constraints added. 
   */
  public function getFirstConstraints($firstConstraints, $initial, $query, $firstTable, $condition)
  {

    $firstField = $firstConstraints["field"];
    $firstOperator = $firstConstraints["operator"];
    $firstValue = $firstConstraints["value"];
    $ft = $firstTable . "." . $firstField;
    if ((preg_match('#^date#', $firstField) === 1)) {
      $firstValue = \DateTime::createFromFormat("Y-m-d", $firstValue)->format("Y-m-d");
      $firstValue = "'" . $firstValue . "'";
    }
    if ($firstOperator == "equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " = " ." '" . $firstValue . "'");
      } else {
        $query = $query->andWhere($ft . " = " ." '" . $firstValue . "'");
      }
    } elseif ($firstOperator == "not_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . "!=" . " '" . $firstValue . "'");
      } else {
        $query = $query->andWhere($ft . "!=" . " '" . $firstValue . "'");
      }
    } elseif ($firstOperator == "less") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . "<" . $firstValue);
      } else {
        $query = $query->andWhere($ft . "<" . $firstValue);
      }
    } elseif ($firstOperator == "less_or_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . "<=" . $firstValue);
      } else {
        $query = $query->andWhere($ft . "<=" . $firstValue);
      }
    } elseif ($firstOperator == "greater") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . ">" . $firstValue);
      } else {
        $query = $query->andWhere($ft . ">" . $firstValue);
      }
    } elseif ($firstOperator == "greater_or_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . ">=" . $firstValue);
      } else {
        $query = $query->andWhere($ft . ">=" . $firstValue);
      }
    } elseif ($firstOperator == "begins_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " LIKE" . " '" . $firstValue . "%'");
      } else {
        $query = $query->andWhere($ft . " LIKE" . " '" . $firstValue . "%'");
      }
    } elseif ($firstOperator == "not_begins_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " NOT LIKE" . " '" . $firstValue . "%'");
      } else {
        $query = $query->andWhere($ft . " NOT LIKE" . " '" . $firstValue . "%'");
      }
    } elseif ($firstOperator == "is_null") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " " . $firstValue . " IS NULL");
      } else {
        $query = $query->andWhere($ft . " " . $firstValue . " IS NULL");
      }
    } elseif ($firstOperator == "is_not_null") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " " . $firstValue . " IS NOT NULL");
      } else {
        $query = $query->andWhere($ft . " " . $firstValue . " IS NOT NULL");
      }
    } elseif ($firstOperator == "between") {
      $lowVal = $firstValue[0];
      $highVal = $firstValue[1];
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " BETWEEN " . $lowVal . " AND " . $highVal);
      } else {
        $query = $query->andWhere($ft . " BETWEEN " . $lowVal . " AND " . $highVal);
      }
    } elseif ($firstOperator == "not_between") {
      $lowVal = $firstValue[0];
      $highVal = $firstValue[1];
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " NOT BETWEEN " . $lowVal . " AND " . $highVal);
      } else {
        $query = $query->andWhere($ft . " NOT BETWEEN " . $lowVal . " AND " . $highVal);
      }
    } elseif ($firstOperator == "ends_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " LIKE" . " '%" . $firstValue . "'");
      } else {
        $query = $query->andWhere($ft . " LIKE" . " '%" . $firstValue . "'");
      }
    } elseif ($firstOperator == "not_ends_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " NOT LIKE" . " '%" . $firstValue . "'");
      } else {
        $query = $query->andWhere($ft . " NOT LIKE" . " '%" . $firstValue . "'");
      }
    } elseif ($firstOperator == "contains") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " LIKE" . " '%" . $firstValue . "%'");
      } else {
        $query = $query->andWhere($ft . " LIKE" . " '%" . $firstValue . "%'");
      }
    } elseif ($firstOperator == "not_contains") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " NOT LIKE" . " '%" . $firstValue . "%'");
      } else {
        $query = $query->andWhere($ft . " NOT LIKE" . " '%" . $firstValue . "%'");
      }
    } elseif ($firstOperator == "is_empty") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " " . $firstValue . "= ''");
      } else {
        $query = $query->andWhere($ft . " " . $firstValue . "= ''");
      }
    } elseif ($firstOperator == "is_not_empty") {
      if ($condition == "OR") {
        $query = $query->orWhere($ft . " " . $firstValue . "!=''");
      } else {
        $query = $query->andWhere($ft . " " . $firstValue . "!=''");
      }
    } else {
      try {
        throw new Exception('Impossible operation; try another operator');
      } catch (\Exception $e) {
        var_dump($e->getMessage());
      }
    }

    return $query;
  }


  /**
   * Get the current level in the JOIN blocks (recursive function).
   * 
   * Receives : the current level in the array of constraints, the current state of the query, a block containing a JOIN, 
   *            the adjacent table of one of the former tables and the condition to apply on the constraints.
   * Returns : the query with the constraints added in it.  
   * Warning : doesn't work properly when clicking ond the 'add-group' on the form. 
   */
  public function newConstraintsOfLevel($level, $query, $joins, $adjTable, $newCondition)
  {

    if (strlen($level == 1)) { // If we are on the first level, we can use the 'simple' function to get the constraints. 
      $query = $this->getNewConstraints($newConstraints, $joins, $query, $adjTable, $newCondition);
    } elseif (strlen($level > 1)) { // If we are on a deeper level :
      foreach ($level as $r) {
        if (count($r) == 6) { // If there are no more constraints after we use the 'simple' function.
          $query = $this->getNewConstraints($r, $joins, $query, $adjTable, $newCondition);
        } elseif (count($r) == 2) { // If there are multiple constraints, we use this function on itself.
          $query = $this->newConstraintsOfLevel($r["rules"], $query, $joins, $adjTable, $r["condition"]);
        }
      }
    }

    return $query;
  }


  /**
   * Get the info contained in each block of JOIN. 
   * 
   * Receives : the array containing the joins in the form and the current state of the query. 
   * Returns : the query with the JOIN(s) added. 
   * Warning : by default, no fields are selected, the user is free to return no field for a JOIN. 
   */
  public function getJoinsBlocks($joins, $query, $initial)
  {

    foreach ($joins as $j) {
      $joinDqlParts = $query->getDQLParts()['join'];
      $fromDqlParts = $query->getDQLParts()['from'][0];
      $aliasATAlreadyExists = false;
      $aliasFTAlreadyExists = false;
      $aliasAT = 1;
      $aliasFT = 1;
      foreach ($joinDqlParts as $joinsDql) {
        foreach ($joinsDql as $joinDql) {
          if ($joinDql->getAlias() === $j["adjacent_table"]) {
            $aliasATAlreadyExists = true;
          }
        }
      }
      if ($fromDqlParts->getAlias() === $j["formerTable"]) {
        $aliasFTAlreadyExists = true;
      }
      if ($aliasATAlreadyExists === true or $j["adjacent_table"] == $initial["initialTable"]) {
        $adjTableAlias = $j["adjacent_table"] . $aliasAT;
        $formerTable = $j["formerTable"] . $aliasFT;
        $adjTable = $j["adjacent_table"];
        $aliasFT += 1;
        $aliasAT += 1;
      } else {
        $adjTableAlias = $j["adjacent_table"];
        $adjTable = $j["adjacent_table"];
        $formerTable = $j["formerTable"];
      }
      if ($aliasFTAlreadyExists === true and $j["formerTable"] != $initial["initialTable"]) {
        $formerTable = $j["formerTable"] . $aliasFT;
        $aliasFT += 1;
      } else $formerTable = $j["formerTable"]; 
      $jointype = $j["join"];
      $srcField = $j["sourceField"];
      $tgtField = $j["targetField"];
      if (count($j) == 7) { // If the user chooses to return some fields.
        $newFields = $j["fields"];
        foreach ($newFields as $newValue) {
          $query = $query->addSelect($adjTable . "." . $newValue);
        };
      }
      $query = $this->makeJoin($joins, $query, $formerTable, $jointype, $adjTable, $adjTableAlias, $srcField, $tgtField);
      if ($j["constraints"] != "") { // If the user chooses to apply constraints on some fields in the JOIN part. 
        $newConstraints = $j["constraints"]["rules"];
        $newCondition = $j["constraints"]["condition"];
        $query = $this->newConstraintsOfLevel($newConstraints, $query, $joins, $adjTable, $newCondition);
      }
    }

    return $query;
  }


  /**
   * Get the type of JOIN and makes the appropriate query.
   * 
   * Receives : the array containing the JOIN info, the current state of the query, the chosen former table, the JOIN type, 
   *            the source and the target fields. 
   * Returns : the query with JOIN added. 
   * Warning : the right, cross and full joins were added, but they are not supported by the QueryBuilder yet. Please keep them commented. 
   */
  public function makeJoin($joins, $query, $formerTable, $jointype, $adjTable, $adjTableAlias, $srcField, $tgtField)
  {
    if ($jointype == "Inner Join") {
      $query = $query->innerJoin('BbeesE3sBundle:' . $adjTable, $adjTableAlias, 'WITH', $formerTable . '.' . $srcField . " = " . $adjTableAlias . '.' . $tgtField);
    } elseif ($jointype == "Left Join") {
      $query = $query->leftJoin('BbeesE3sBundle:' . $adjTable, $adjTableAlias, 'WITH', $formerTable . '.' . $srcField . " = " . $adjTableAlias . '.' . $tgtField);
    } /* elseif ($jointype == "right join") {
            $query = $query->rightJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        } elseif ($jointype == "cross join") {
            $query = $query->crossJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        } elseif ($jointype == "full join") {
            $query = $query->fullJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        } */

    return $query;
  }


   /**
   * Get the new constraints contained in each JOIN block. 
   * 
   * Receives : the array containing the constraints in the form, a JOIN block, the current state of the query,
   *            the current adjacent and the condition to apply on the constraints. 
   * Returns : the query with the 'WHERE' constraints added. 
   */
  public function getNewConstraints($newConstraints, $joins, $query, $adjTable, $newCondition)
  {
    $newField = $newConstraints["field"];
    $newOperator = $newConstraints["operator"];
    $newValue = $newConstraints["value"];
    $nft = $adjTable . "." . $newField;
    if ((preg_match('#^date#', $newField) === 1)) {
      $newValue = \DateTime::createFromFormat("Y-m-d", $newValue)->format("Y-m-d");
      $newValue = "'" . $newValue . "'";
    }
    if ($newOperator == "equal") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " = " . " '" . $newValue . "'");
      } else {
        $query = $query->andWhere($nft . " = " . " '" . $newValue . "'");
      }
    } elseif ($newOperator == "not_equal") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . "!=" . " '" . $newValue . "'");
      } else {
        $query = $query->andWhere($nft . "!=" . " '" . $newValue . "'");
      }
    } elseif ($newOperator == "less") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . "<" . $newValue);
      } else {
        $query = $query->andWhere($nft . "<" . $newValue);
      }
    } elseif ($newOperator == "less_or_equal") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . "<=" . $newValue);
      } else {
        $query = $query->andWhere($nft . "<=" . $newValue);
      }
    } elseif ($newOperator == "greater") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . ">" . $newValue);
      } else {
        $query = $query->andWhere($nft . ">" . $newValue);
      }
    } elseif ($newOperator == "greater_or_equal") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . ">=" . $newValue);
      } else {
        $query = $query->andWhere($nft . ">=" . $newValue);
      }
    } elseif ($newOperator == "begins_with") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " LIKE" . " '" . $newValue . "%'");
      } else {
        $query = $query->andWhere($nft . " LIKE" . " '" . $newValue . "%'");
      }
    } elseif ($newOperator == "not_begins_with") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " NOT LIKE" . " '" . $newValue . "%'");
      } else {
        $query = $query->andWhere($nft . " NOT LIKE" . " '" . $newValue . "%'");
      }
    } elseif ($newOperator == "is_null") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " " . $newValue . " IS NULL");
      } else {
        $query = $query->andWhere($nft . " " . $newValue . " IS NULL");
      }
    } elseif ($newOperator == "is_not_null") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " " . $newValue . " IS NOT NULL");
      } else {
        $query = $query->andWhere($nft . " " . $newValue . " IS NOT NULL");
      }
    } elseif ($newOperator == "between") {
      $newLowVal = $newValue[0];
      $newHighVal = $newValue[1];
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " BETWEEN " . $newLowVal . " AND " . $newHighVal);
      } else {
        $query = $query->andWhere($nft . " BETWEEN " . $newLowVal . " AND " . $newHighVal);
      }
    } elseif ($newOperator == "not_between") {
      $newLowVal = $newValue[0];
      $newHighVal = $newValue[1];
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " NOT BETWEEN " . $newLowVal . " AND " . $newHighVal);
      } else {
        $query = $query->andWhere($nft . " NOT BETWEEN " . $newLowVal . " AND " . $newHighVal);
      }
    } elseif ($newOperator == "ends_with") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " LIKE" . " '%" . $newValue . "'");
      } else {
        $query = $query->andWhere($nft . " LIKE" . " '%" . $newValue . "'");
      }
    } elseif ($newOperator == "not_ends_with") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " NOT LIKE" . " '%" . $newValue . "'");
      } else {
        $query = $query->andWhere($nft . " NOT LIKE" . " '%" . $newValue . "'");
      }
    } elseif ($newOperator == "contains") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " LIKE" . " '%" . $newValue . "%'");
      } else {
        $query = $query->andWhere($nft . " LIKE" . " '%" . $newValue . "%'");
      }
    } elseif ($newOperator == "not_contains") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " NOT LIKE" . " '%" . $newValue . "%'");
      } else {
        $query = $query->andWhere($nft . " NOT LIKE" . " '%" . $newValue . "%'");
      }
    } elseif ($newOperator == "is_empty") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " " . $newValue . "= ''");
      } else {
        $query = $query->andWhere($nft . " " . $newValue . "= ''");
      }
    } elseif ($newOperator == "is_not_empty") {
      if ($newCondition == "OR") {
        $query = $query->orWhere($nft . " " . $newValue . "!=''");
      } else {
        $query = $query->andWhere($nft . " " . $newValue . "!=''");
      }
    } else {
      try {
        throw new Exception('Impossible operation; try another operator');
      } catch (\Exception $e) {
        var_dump($e->getMessage());
      }
    }

    return $query;
  }
}
