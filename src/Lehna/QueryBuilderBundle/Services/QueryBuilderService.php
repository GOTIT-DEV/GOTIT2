<?php

namespace Lehna\QueryBuilderBundle\Services;

use InvalidArgumentException;

/**
 * Service QueryBuilderService
 */
class QueryBuilderService
{

  public function makeQuery($data, $query)
  {

    $this->parseFirstBlock($data["initial"], $query);
    if (array_key_exists('joins', $data)) {
      $this->parseJoinsBlocks($data["joins"], $query);
    }

    return $query;
  }
  /** 
   * Get the selected fields of the query to create a template table for the results. 
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
   * Get the full first block of querybuilder.
   * 
   * @param mixed $data, $initial, $query : the full array containing the info in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, all fields are checked for the first table, please keep at least one field selected.   
   */
  private function parseFirstBlock($initial, $qb)
  {
    $firstTable = $initial["initialTable"];
    $initAlias = $initial["initialAlias"];

    $query = $qb->from('BbeesE3sBundle:' . $firstTable, $initAlias); // Adding the initial table to the query
    foreach ($initial["initialFields"] as $value) {
      $query = $query->addSelect($initAlias . "." . $value . " AS " . $initAlias . "_" . $value); // Adding every field selected for the initial table
    };
    if (array_key_exists('rules', $initial)) {
      $query->andWhere($this->parseGroup($initial['rules'], $qb, $initAlias));
    }

    return $query;
  }


  /**
   * Get the info contained in each block of JOIN. 
   * 
   * @param mixed $joins, query : the info contained on each block in the form, the current state of the query.
   * @return mixed $query : the query with the added chosen table, the fields and the constraints if the user choses to apply some constraints
   * 
   * Warning : by default, no fields are checked for the chosen adjacent table, the user is free to keep it that way or choose some fields to return.   
   */
  private function parseJoinsBlocks($joins, $query)
  {
    foreach ($joins as $j) {
      // If the user chooses to return some fields.
      if (array_key_exists('fields', $j)) {
        foreach ($j["fields"] as $newValue) {
          $query = $query->addSelect($j["alias"] . "." . $newValue . " AS " .  $j["alias"] . "_" . $newValue);;
        };
      }
      // Join tables
      $query = $this->makeJoin($j, $query);
      // Parse constraints 
      if (array_key_exists('rules', $j)) { // If the user chooses to apply constraints on some fields in the JOIN part. 
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

  private function parseRule($rule, $qb, $tableAlias)
  {
    if (array_key_exists("operator", $rule)) {
      if ($rule["operator"] === "equal") {
        return $qb->expr()->eq($tableAlias . "." . $rule["field"], $rule["value"]);
      } else {
        throw new InvalidArgumentException("Querybuilder : Unknown operator " . $rule['operator']);
      }

      // ... operators
    } else if (array_key_exists("condition", $rule)) {
      return $this->parseGroup($rule, $qb, $tableAlias);
    } else {
      throw new InvalidArgumentException("Querybuilder : Invalid rule encountered");
    }
  }

  private function parseGroup($group, $qb, $tableAlias)
  {
    $parseRule = function ($rule) use (&$qb, &$tableAlias) {
      $this->parseRule($rule, $qb, $tableAlias);
    };

    $constraints = array_map($parseRule, $group["rules"]);

    $operator = $group["condition"];
    if ($operator === "AND")
      return $qb->expr()->andX(...$constraints);
    else if ($operator === "OR")
      return $qb->expr()->orX(...$constraints);
    else
      throw new InvalidArgumentException("Querybuilder : Invalid operator " . $operator);
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
