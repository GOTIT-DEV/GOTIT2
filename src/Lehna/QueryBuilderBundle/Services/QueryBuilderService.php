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
          if (array_key_exists($target, $relations[$entity])) {
            $relations[$entity][$target][] = $this->parse_associated($mapping);
          } else {
            $relations[$entity][$target] = [$this->parse_associated($mapping)];
          }
        }
      }
    }

    foreach ($relations as $sourceEntity => $targets) {
      foreach ($targets as $targetEntity => $data) {
        $reverse_relation = function ($d) use ($sourceEntity) {
          return [
            "entity" => $sourceEntity,
            "from" => $d["to"],
            "to" => $d["from"]
          ];
        };
        $relations[$targetEntity][$sourceEntity] = array_map(
          $reverse_relation,
          $data
        );
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

  private function convert_field_type($type)
  {
    if (strpos($type, "int") != false) {
      $type = "integer";
    } elseif ($type == "float") {
      $type = "double";
    } elseif ($type == "text") {
      $type = "string";
    } elseif (strpos($type, "bool") != false) {
      $type = "boolean";
    }
    // $valid_types = ["string", "integer", "double", "date", "time", "datetime", "boolean"];
    // assert(in_array($type, $valid_types));
    return $type;
  }


  /************************************************
   * BUILDING QUERY UTILITIES
   ************************************************/

  /** 
   * Get the selected fields of the query to create a tamplate table for the results. 
   * 
   * @param mixed $data the array containing the info for the query. 
   * @return array the array with the initial tables and the adjacent tables as keys and the corresponding fields as values.  
   */
  public function getSelectFields($data)
  {
    $initialTableAlias = $data["initial"]["initialAlias"];
    $initialFields = $data["initial"]["initialFields"];
    $resultsTab = [$initialTableAlias => $initialFields]; // Init the array with the first fields
    if (array_key_exists("joins", $data)) { // If there are join blocks in the query
      $joins = $data["joins"];
      foreach ($joins as $j) {
        if (count($j) == 9) {
          $alias = $j["alias"];
          $joinsFields = $j["fields"];
          $resultsTab[$alias] = $joinsFields; // Adding the selected fields for each join block
        }
      }
    }

    return $resultsTab;
  }


  /**
   * Get the current level in the block of constraints for the querybuilder. 
   * 
   * @param mixed $level, $query, $data, $table, $condition : the current level in the array, the current state of the query, all info, 
   *              the current table and the condition to apply on the constraints.
   * @return mixed $query : the query with the constraints added to it. 
   * 
   * Warning : doesn't work properly when clicking ond the 'add-group' on the form.    
   */
  private function constraintsOfLevel($level, $query, $data, $table, $alias, $condition)
  {

    if (strlen($level == 1)) { // If we are on the first level, we can use the 'simple' function to get the constraints. 
      $query = $this->getConstraints($constraints, $data, $query, $alias, $condition);
    } elseif (strlen($level > 1)) { // If we are on a deeper level : 
      foreach ($level as $r) {
        if (count($r) == 6) { // If there are no more constraints after, we use the 'simple' function. 
          $query = $this->getConstraints($r, $data, $query, $alias, $condition);
        } elseif (count($r) == 2) { // If there are multiple constraints, we call this function on itself. 
          $query = $this->constraintsOfLevel($r["rules"], $query, $data, $table, $alias, $r["condition"]);
        }
      }
    }

    return $query;
  }


  /**
   * Get the full first block of querybuilder.
   * 
   * @param mixed $data, $initial, $query : the full array containing the info in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, all fields are checked for the first table, please keep at least one field selected.   
   */
  public function getFirstBlock($initial, $query)
  {
    $firstTable = $initial["initialTable"];
    $initAlias = $initial["initialAlias"];
    $query = $query->from('BbeesE3sBundle:' . $firstTable, $initAlias); // Adding the initial table to the query
    $firstFields = $initial["initialFields"];
    foreach ($firstFields as $value) {
      $query = $query->addSelect($initAlias . "." . $value . " AS " . $initAlias . "_" . $value); // Adding every field selected for the initial table
    };
    if ($initial["constraintsTable1"] != "") {
      $condition = $initial["constraintsTable1"]["condition"];
      $constraints = $initial["constraintsTable1"]["rules"];
      $query = $this->constraintsOfLevel($constraints, $query, $initial, $firstTable, $initAlias, $condition); // Adding the constraints to the query
    }

    return $query;
  }


  /**
   * Get the info contained in each block of JOIN. 
   * 
   * @param mixed $joins, query : the info contained on each block in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, no fields are checked for the chsoen adjacent table, the user is free to keep it that way or choose some fields to return.   
   */
  public function getJoinsBlocks($joins, $query)
  {
    foreach ($joins as $j) {
      $formerTableAlias = $j["formerTableAlias"];
      $jointype = $j["join"];
      $adjTable = $j["adjacent_table"];
      $joinAlias = $j["alias"];
      $srcField = $j["sourceField"];
      $tgtField = $j["targetField"];
      if (count($j) == 9) { // If the user chooses to return some fields.
        $newFields = $j["fields"];
        foreach ($newFields as $newValue) {
          $query = $query->addSelect($joinAlias . "." . $newValue . " AS " . $joinAlias . "_" . $newValue);;
        };
      }
      $query = $this->makeJoin($joins, $query, $formerTableAlias, $jointype, $adjTable, $srcField, $tgtField, $joinAlias);
      if ($j["constraints"] != "") { // If the user chooses to apply constraints on some fields in the JOIN part. 
        $newConstraints = $j["constraints"]["rules"];
        $newCondition = $j["constraints"]["condition"];
        $query = $this->constraintsOfLevel($newConstraints, $query, $joins, $adjTable, $joinAlias, $newCondition);
      }
    }

    return $query;
  }


  /**
   * Get the full first block of querybuilder.
   * 
   * @param mixed $data, query : the full array containing the info in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, all fields are checked for the first table, please keep at least one box checked.   
   */
  /* public function getBlocks($data, $query)
  {

    $initial = $data["initial"];
    $table = $initial["initialTable"];
    $initAlias = $initial["initialAlias"];
    $query = $query->from('BbeesE3sBundle:' . $table, $initAlias); // Adding the initial table to the query
    $table = $initAlias;
    $fields = $initial["initialFields"];
    foreach ($fields as $value) {
      $query = $query->addSelect($initAlias . "." . $value . " AS " . $initAlias . "_" . $value); // Adding every field selected for the initial table
    };

    if ($initial["constraintsTable1"] != "") { // If the user decided to add some constraints
      $condition = $initial["constraintsTable1"]["condition"];
      $constraints = $initial["constraintsTable1"]["rules"];
      $query = $this->constraintsOfLevel($constraints, $query, $data, $table, $initAlias, $condition); // Adding the constraints to the query
    }

    if (count($data) > 1) { // If the user decided to make some joins
      if (strlen($data["joins"] >= 1)) {
        $joins = $data["joins"];
        foreach ($joins as $j) { // For each block added
          if ($j == $joins[0]) {
            $formerTable = $initAlias;
          } else {
            $formerTable = $j["formerTableAlias"];
          }
          $adjTable = $j["adjacent_table"];
          $jointype = $j["join"];
          $srcField = $j["sourceField"];
          $tgtField = $j["targetField"];
          $alias = $j["alias"];

          if (count($j) == 9) { // If the user chooses to return some fields.
            $newFields = $j["fields"];
            foreach ($newFields as $newValue) {
              $query = $query->addSelect($alias . "." . $newValue . " AS " . $alias . "_" . $newValue);
            };
          }
          $query = $this->makeJoin($joins, $query, $formerTable, $jointype, $adjTable, $srcField, $tgtField, $alias);

          if ($j["constraints"] != "") { // If the user chooses to apply constraints on some fields in the JOIN part. 
            $constraints = $j["constraints"]["rules"];
            $condition = $j["constraints"]["condition"];
            $table = $j["alias"];
            $query = $this->constraintsOfLevel($constraints, $query, $data, $table, $initAlias, $condition);
          }
        }
      }
    }
    return $query;
  }
 */

  /**
   * Get the first constraints (simple function that is used on each constraint). 
   * 
   * @param mixed $constrains, $data, $query, $table, $condition : the array containing the constraints in the form, all info, 
   *              the current state of the query, the current chosen table and the condition to apply on the constraints. 
   * @return mixed $query : the query with the 'WHERE' constraints added. 
   */
  private function getConstraints($constraints, $data, $query, $table, $condition)
  {
    $field = $constraints["field"];
    $operator = $constraints["operator"];
    $value = $constraints["value"];
    $tableField = $table . "." . $field;
    if ((preg_match('#^date#', $field) === 1) && ($field !== "dateMaj" && $field !== "dateCre")) {
      $value = \DateTime::createFromFormat("Y-m-d", $value)->format("Y-m-d");
      $value = "'" . $value . "'";
    } else if ($field === "dateMaj" || $field === "dateCre") {
      $value = \DateTime::createFromFormat("Y-m-d H:i:s", $value)->format("Y-m-d H:i:s");
      $value = "'" . $value . "'";
    }

    if ($operator == "equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " = " . " '" . $value . "'");
      } else {
        $query = $query->andWhere($tableField . " = " . " '" . $value . "'");
      }
    } elseif ($operator == "not_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . "!=" . " '" . $value . "'");
      } else {
        $query = $query->andWhere($tableField . "!=" . " '" . $value . "'");
      }
    } elseif ($operator == "less") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . "<" . $value);
      } else {
        $query = $query->andWhere($tableField . "<" . $value);
      }
    } elseif ($operator == "less_or_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . "<=" . $value);
      } else {
        $query = $query->andWhere($tableField . "<=" . $value);
      }
    } elseif ($operator == "greater") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . ">" . $value);
      } else {
        $query = $query->andWhere($tableField . ">" . $value);
      }
    } elseif ($operator == "greater_or_equal") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . ">=" . $value);
      } else {
        $query = $query->andWhere($tableField . ">=" . $value);
      }
    } elseif ($operator == "begins_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " LIKE" . " '" . $value . "%'");
      } else {
        $query = $query->andWhere($tableField . " LIKE" . " '" . $value . "%'");
      }
    } elseif ($operator == "not_begins_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " NOT LIKE" . " '" . $value . "%'");
      } else {
        $query = $query->andWhere($tableField . " NOT LIKE" . " '" . $value . "%'");
      }
    } elseif ($operator == "is_null") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " " . $value . " IS NULL");
      } else {
        $query = $query->andWhere($tableField . " " . $value . " IS NULL");
      }
    } elseif ($operator == "is_not_null") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " " . $value . " IS NOT NULL");
      } else {
        $query = $query->andWhere($tableField . " " . $value . " IS NOT NULL");
      }
    } elseif ($operator == "between") {
      $lowVal = $value[0];
      $highVal = $value[1];
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " BETWEEN " . $lowVal . " AND " . $highVal);
      } else {
        $query = $query->andWhere($tableField . " BETWEEN " . $lowVal . " AND " . $highVal);
      }
    } elseif ($operator == "not_between") {
      $lowVal = $value[0];
      $highVal = $value[1];
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " NOT BETWEEN " . $lowVal . " AND " . $highVal);
      } else {
        $query = $query->andWhere($tableField . " NOT BETWEEN " . $lowVal . " AND " . $highVal);
      }
    } elseif ($operator == "ends_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " LIKE" . " '%" . $value . "'");
      } else {
        $query = $query->andWhere($tableField . " LIKE" . " '%" . $value . "'");
      }
    } elseif ($operator == "not_ends_with") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " NOT LIKE" . " '%" . $value . "'");
      } else {
        $query = $query->andWhere($tableField . " NOT LIKE" . " '%" . $value . "'");
      }
    } elseif ($operator == "contains") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " LIKE" . " '%" . $value . "%'");
      } else {
        $query = $query->andWhere($tableField . " LIKE" . " '%" . $value . "%'");
      }
    } elseif ($operator == "not_contains") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " NOT LIKE" . " '%" . $value . "%'");
      } else {
        $query = $query->andWhere($tableField . " NOT LIKE" . " '%" . $value . "%'");
      }
    } elseif ($operator == "is_empty") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " " . $value . "= ''");
      } else {
        $query = $query->andWhere($tableField . " " . $value . "= ''");
      }
    } elseif ($operator == "is_not_empty") {
      if ($condition == "OR") {
        $query = $query->orWhere($tableField . " " . $value . "!=''");
      } else {
        $query = $query->andWhere($tableField . " " . $value . "!=''");
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
   * Get the type of JOIN and makes the appropriate query.
   * 
   * @param mixed $joins, $query, $formerTable, $jointype, $adjTable, $adjTableAlias, $srcField, $tgtField : the array containing the JOIN info, 
   *              the current state of the query, the chosen former table, the JOIN type, 
   *              the source and the target fields. 
   * @return mixed $query : the query with the JOIN added
   * 
   */
  private function makeJoin($joins, $query, $formerTableAlias, $jointype, $adjTable, $srcField, $tgtField, $alias)
  {
    if ($jointype == "Inner Join") {
      $query = $query->innerJoin('BbeesE3sBundle:' . $adjTable, $alias, 'WITH', $formerTableAlias . '.' . $srcField . " = " . $alias . '.' . $tgtField);
    } elseif ($jointype == "Left Join") {
      $query = $query->leftJoin('BbeesE3sBundle:' . $adjTable, $alias, 'WITH', $formerTableAlias . '.' . $srcField . " = " . $alias . '.' . $tgtField);
    }

    return $query;
  }
}
