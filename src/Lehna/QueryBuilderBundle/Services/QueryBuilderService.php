<?php

namespace Lehna\QueryBuilderBundle\Services;

use InvalidArgumentException;

/**
 * Service QueryBuilderService
 */
class QueryBuilderService
{
  /** 
   * Create the query. 
   * 
   * @param mixed $data $query all the info from the form and the state of the query. 
   * @return array $query the full query.  
   */
  public function makeQuery($data, $query)
  {

    $this->parseFirstBlock($data["initial"], $query);
    // If the user decided to make joins
    if (array_key_exists('joins', $data)) {
      $this->parseJoinsBlocks($data["joins"], $query);
    }

    return $query;
  }

  /** 
   * Get the selected fields of the query to create a template table for the results. 
   * 
   * @param mixed $data the array containing the info for the query. 
   * @return array $resultsTab the array with the initial tables and the adjacent tables as keys and the corresponding fields as values.  
   */
  public function getSelectFields($data)
  {
    $initialTableAlias = $data["initial"]["initialAlias"];
    $initialFields = $data["initial"]["initialFields"];
    $resultsTab = [$initialTableAlias => $initialFields]; // Init the array with the first fields
    if (array_key_exists("joins", $data)) { // If there are join blocks in the query
      $joins = $data["joins"];
      foreach ($joins as $j) {
        if (array_key_exists('fields', $j)) {
          $alias = $j["alias"];
          $joinsFields = $j["fields"];
          $resultsTab[$alias] = $joinsFields; // Adding the selected fields for each join block
        }
      }
    }

    return $resultsTab;
  }

  /**
   * Parse the first block of querybuilder.
   * 
   * @param mixed $initial, $qb : the info from the first block, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, all fields are checked for the first table, please keep at least one field selected.   
   */
  private function parseFirstBlock($initial, $qb)
  {
    $firstTable = $initial["initialTable"];
    $initAlias = $initial["initialAlias"];
    // Adding the initial table to the query
    $query = $qb->from('BbeesE3sBundle:' . $firstTable, $initAlias);
    foreach ($initial["initialFields"] as $value) {
      // Adding every field selected for the initial table with their alias
      $query = $query->addSelect($initAlias . "." . $value . " AS " . $initAlias . "_" . $value);
    };
    // If there are some constraints addedby the user
    if (array_key_exists('rules', $initial)) {
      $query->andWhere($this->parseGroup($initial['rules'], $qb, $initAlias));
    }

    return $query;
  }


  /**
   * Get the info contained in each block of JOIN. 
   * 
   * @param mixed $joins, $query : the info contained on each block in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints.
   * 
   * Warning : by default, no fields are checked for the chosen adjacent table, the user is free to keep it that way or choose some fields to return.   
   */
  private function parseJoinsBlocks($joins, $query)
  {
    foreach ($joins as $j) {
      // Adding the fields to the query if the user chooses to return some.
      if (array_key_exists('fields', $j)) {
        foreach ($j["fields"] as $newValue) {
          $query = $query->addSelect($j["alias"] . "." . $newValue . " AS " .  $j["alias"] . "_" . $newValue);;
        };
      }
      // Join tables
      $query = $this->makeJoin($j, $query);
      // Parse constraints if the user chooses to apply some.
      if (array_key_exists('rules', $j)) {
        $query->andWhere($this->parseGroup($j['rules'], $query,  $j["alias"]));
      }
    }

    return $query;
  }


  /*  if ((preg_match('#^date#', $field) === 1) && ($field !== "dateMaj" && $field !== "dateCre")) {
    $value = \DateTime::createFromFormat("Y-m-d", $value)->format("Y-m-d");
    $value = "'" . $value . "'";
  } else if ($field === "dateMaj" || $field === "dateCre") {
    $value = \DateTime::createFromFormat("Y-m-d H:i:s", $value)->format("Y-m-d H:i:s");
    $value = "'" . $value . "'";
  } */

  /**
   * Parse each rule contained in a group. 
   * 
   * @param mixed $rule, $qb, $tableAlias : the rule, the qb object and the alias of the table.
   * @return mixed $qb : the qb updated with  the constraint.
   *    
   */
  private function parseRule($rule, $qb, $tableAlias)
  {
    // If we are on a rule, we create the constraint
    if (array_key_exists("operator", $rule)) {

      // Check if field type is a date or datetime
      if ((preg_match('#^date#', $rule["field"]) === 1) && ($rule["field"] !== "dateMaj" && $rule["field"] !== "dateCre")) {
        $value = \DateTime::createFromFormat("Y-m-d", $rule["value"])->format("Y-m-d");
      } else if ($rule["field"] === "dateMaj" || $rule["field"] === "dateCre") {
        $value = \DateTime::createFromFormat("Y-m-d H:i:s", $rule["value"])->format("Y-m-d H:i:s");
      } else $value = $rule["value"];

      // Find the right operator
      if ($rule["operator"] === "equal") {
        return $qb->expr()->eq($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "not_equal") {
        return $qb->expr()->neq($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "in") {
        return $qb->expr()->in($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "not_in") {
        return $qb->expr()->notIn($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "less") {
        return $qb->expr()->lt($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "less_or_equal") {
        return $qb->expr()->lte($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "greater") {
        return $qb->expr()->gt($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "greater_or_equal") {
        return $qb->expr()->gte($tableAlias . "." . $rule["field"], "'" . $value . "'");
      } else if ($rule["operator"] === "between") {
        return $qb->expr()->between($tableAlias . "." . $rule["field"], $value[0], $value[1]);
      } else if ($rule["operator"] === "not_between") {
        return $qb->expr()->not($qb->expr()->between($tableAlias . "." . $rule["field"], $value[0], $value[1]));
      } else if ($rule["operator"] === "is_null") {
        return $qb->expr()->isNull($tableAlias . "." . $rule["field"]);
      } else if ($rule["operator"] === "is_not_null") {
        return $qb->expr()->not($qb->expr()->isNull($tableAlias . "." . $rule["field"]));
      } else if ($rule["operator"] === "begins_with") {
        return $qb->expr()->like($tableAlias . "." . $rule["field"], "'" . $value . "%" . "'" );
      } else if ($rule["operator"] === "not_begins_with") {
        return $qb->expr()->not($qb->expr()->like($tableAlias . "." . $rule["field"], "'" . $value . "%" . "'" ));
      } else if ($rule["operator"] === "contains") {
        return $qb->expr()->like($tableAlias . "." . $rule["field"], "'" . "%" . $value . "%" . "'" );
      } else if ($rule["operator"] === "not_contains") {
        return $qb->expr()->not($qb->expr()->like($tableAlias . "." . $rule["field"], "'" . "%" . $value . "%" . "'" ));
      } else if ($rule["operator"] === "ends_with") {
        return $qb->expr()->like($tableAlias . "." . $rule["field"], "'" . "%" . $value . "'" );
      } else if ($rule["operator"] === "not_ends_with") {
        return $qb->expr()->not($qb->expr()->like($tableAlias . "." . $rule["field"], "'" . "%" . $value . "'" ));
      } else if ($rule["operator"] === "is_empty") {
        return $qb->expr()->eq($tableAlias . "." . $rule["field"], "''");
      } else if ($rule["operator"] === "is_not_empty") {
        return $qb->expr()->not($qb->expr()->eq($tableAlias . "." . $rule["field"], "''"));
      }
      else {
        throw new InvalidArgumentException("Querybuilder : Unknown operator " . $rule['operator']);
      }

      // ... operators
      // If we are on a new group, we parse it with the dedicated function
    } else if (array_key_exists("condition", $rule)) {
      return $this->parseGroup($rule, $qb, $tableAlias);
    } else {
      throw new InvalidArgumentException("Querybuilder : Invalid rule encountered");
    }
  }

  /**
   * Parse each group contained in the full constraints object. 
   * 
   * @param mixed $group, $qb, $tableAlias : the group, the qb object and the alias of the table.
   * @return mixed $qb : the qb updated with  the constraint.
   *    
   */
  private function parseGroup($group, $qb, $tableAlias)
  {
    // Make sure parseRule has the correct arguments
    $parseRule = function ($rule) use (&$qb, &$tableAlias) {
      return $this->parseRule($rule, $qb, $tableAlias);
    };
    // Create an array with all the rules
    $constraints = array_map($parseRule, $group["rules"]);
    $condition = $group["condition"];
    // Create the constraint with the appropriate condition
    if ($condition === "AND") {
      return $qb->expr()->andX(...$constraints);
    } else if ($condition === "OR") {
      return $qb->expr()->orX(...$constraints);
    } else
      throw new InvalidArgumentException("Querybuilder : Invalid operator " . $condition);
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
  private function makeJoin($joinBlock, $query)
  {
    $source = $joinBlock["formerTableAlias"] . '.' . $joinBlock["sourceField"];
    $target = $joinBlock["alias"] . '.' . $joinBlock["targetField"];
    $joinFields =  $source . " = " . $target;

    if ($joinBlock["join"] == "Inner Join") {
      $query = $query->innerJoin(
        'BbeesE3sBundle:' . $joinBlock["adjacent_table"],
        $joinBlock["alias"],
        'WITH',
        $joinFields
      );
    } elseif ($joinBlock["join"] == "Left Join") {
      $query = $query->leftJoin(
        'BbeesE3sBundle:' . $joinBlock["adjacent_table"],
        $joinBlock["alias"],
        'WITH',
        $joinFields
      );
    }

    return $query;
  }
}
