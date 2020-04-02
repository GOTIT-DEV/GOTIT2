<?php

namespace Lehna\QueryBuilderBundle\Services;

use Doctrine\Common\Persistence\ManagerRegistry;
use Doctrine\Persistence\Mapping\ClassMetadata;
use Doctrine\Bundle\DoctrineBundle\Mapping\DisconnectedMetadataFactory;
use Psr\Container\ContainerInterface;

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
}
