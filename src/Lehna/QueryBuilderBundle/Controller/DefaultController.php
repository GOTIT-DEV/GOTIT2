<?php

namespace Lehna\QueryBuilderBundle\Controller;

use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Lehna\QueryBuilderBundle\Services\QueryBuilderService;
use Lehna\QueryBuilderBundle\Services\BuilderQueryService;
use Lehna\SpeciesSearchBundle\Services\SpeciesQueryService;
use Bbees\E3sBundle\Services\GenericFunctionService;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Config\Definition\Exception\Exception;




/**
 * Controller for querying COI sampling coverage
 *
 * @Route("/")
 * @Security("has_role('ROLE_INVITED')")
 */
class DefaultController extends Controller
{
    /**
     * @Route("/", name="query_builder_index")
     * Index : render query form interface
     */
    public function indexAction()
    {
        return $this->render('@LehnaQueryBuilder/index.html.twig');
        
    }


    /**
     * @Route("/init", name="querybuilder_init", methods={"GET"})
     * 
     */
    public function init_builders(QueryBuilderService $service)
    {
        $config = $service->make_qbuilder_config();
        return new JsonResponse($config);
    }

    /**
     *  @Route("/query", name="query_test", methods={"POST"})
     * 
     */
    public function getRequestBuilder(Request $request) {
        
        $data = $request->request->all();
        dump($data);
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();
        $initial = $data["initial"];
        $query = $this->getFirstBlock($data, $initial, $qb);
        if (count($data) > 1) 
            if (strlen($data["joins"] >= 1)) {
                $joins = $data["joins"];
                $this->getJointsBlocks($joins, $query);
            }
        dump($query);
        $q = $query->getQuery();
        dump($q);
        $results = $q->getArrayResult();
        dump($results);
        return new JsonResponse($results);
        
    }

    /**
    * Get the level. 
    * @Route("/query", name="test_query", methods={"POST"})
    * 
    */
    public function constraintsOfLevel($level, $query, $initial, $firstTable, $condition){

        if (strlen($level == 1)) {
                $query = $this->getFirstConstraints($firstConstraints, $initial, $query, $firstTable, $condition);
        } elseif (strlen($level > 1)) {
            foreach ($level as $r) {
                dump(count($r));
                if(count($r)==6){
                    $query = $this->getFirstConstraints($r, $initial, $query, $firstTable, $condition);
                }
                elseif(count($r)==2){
                    dump($condition);
                    dump($r["condition"]);
                    $query = $this->constraintsOfLevel($r["rules"], $query, $initial, $firstTable, $r["condition"]);
                }            
            }
        }
        return $query;
    }


    /**
    * Get the first fields of the first table that we want to return and creates the "select" part of the query. 
    * 
    */
    public function getFirstBlock($data, $initial, $query) {
        
        $firstTable = $initial["table"];
        $query = $query->from('BbeesE3sBundle:'.$firstTable, $firstTable);
        $firstFields = $initial["fields"];
        
        foreach ($firstFields as $value){
            $query = $query->addSelect($firstTable.".".$value);
        };

        if ($initial["constraintsTable1"] != "") {
            $condition = $initial["constraintsTable1"]["condition"];
            $firstConstraints = $initial["constraintsTable1"]["rules"];
            $query = $this->constraintsOfLevel($initial["constraintsTable1"]["rules"], $query, $initial, $firstTable, $condition);
        }



        /* if (strlen($initial["constraintsTable1"]["rules"] == 1)) {
            $query = $this->getFirstConstraints($firstConstraints, $initial, $query, $firstTable, $condition);
        } elseif (strlen($initial["constraintsTable1"]["rules"] > 1)) {
            foreach ($initial["constraintsTable1"]["rules"] as $r) {
                dump(count($r));
                $query = $this->getFirstConstraints($r, $initial, $query, $firstTable, $condition);
                
            }
        } */
        return $query;
    }

    /**
    * Get the first constraints. 
    * 
    */
    public function getFirstConstraints($firstConstraints, $initial, $query, $firstTable, $condition) {
        $firstField = $firstConstraints["field"];
        $firstOperator = $firstConstraints["operator"];
        $firstValue = $firstConstraints["value"];
        $ft = $firstTable.".".$firstField;
        if ($firstOperator == "equal") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." = ".$firstValue);
            } else {
                $query = $query->andWhere($ft." = ".$firstValue);
            }
        } elseif ($firstOperator == "not_equal"){
            if ($condition == "OR") {
                $query = $query->orWhere($ft."!=".$firstValue);
            } else {
                $query = $query->andWhere($ft."!=".$firstValue);
            }
        } elseif ($firstOperator == "less") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft."<".$firstValue);
            } else {
                $query = $query->andWhere($ft."<".$firstValue);
            }
        } elseif ($firstOperator == "less_or_equal") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft."<=".$firstValue);
            } else {
                $query = $query->andWhere($ft."<=".$firstValue);
            }
        } elseif ($firstOperator == "greater") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft.">".$firstValue);
            } else {
                $query = $query->andWhere($ft.">".$firstValue);
            }
        } elseif ($firstOperator == "greater_or_equal") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft.">=".$firstValue);
            } else {
                $query = $query->andWhere($ft.">=".$firstValue);
            }
        } elseif ($firstOperator == "begins_with") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." LIKE"." '".strtoupper($firstValue)."%'");
            } else {
                $query = $query->andWhere($ft." LIKE"." '".strtoupper($firstValue)."%'");
            }
        } elseif ($firstOperator == "not_begins_with") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." NOT LIKE"." '".strtoupper($firstValue)."%'");
            } else {
                $query = $query->andWhere($ft." NOT LIKE"." '".strtoupper($firstValue)."%'");
            }
        } elseif ($firstOperator == "is_null") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." ".$firstValue." IS NULL");
            } else {
                $query = $query->andWhere($ft." ".$firstValue." IS NULL");
            }
        } elseif ($firstOperator == "is_not_null") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." ".$firstValue." IS NOT NULL");
            } else {
                $query = $query->andWhere($ft." ".$firstValue." IS NOT NULL");
            }
        } elseif ($firstOperator == "between") {
            $lowVal = $firstValue[0];
            $highVal = $firstValue[1];
            if ($condition == "OR") {
                $query = $query->orWhere($ft." BETWEEN ".$lowVal." AND ".$highVal);
            } else {
                $query = $query->andWhere($ft." BETWEEN ".$lowVal." AND ".$highVal);
            }
        } elseif ($firstOperator == "not_between") {
            $lowVal = $firstValue[0];
            $highVal = $firstValue[1];
            if ($condition == "OR") {
                $query = $query->orWhere($ft." NOT BETWEEN ".$lowVal." AND ".$highVal);
            } else {
                $query = $query->andWhere($ft." NOT BETWEEN ".$lowVal." AND ".$highVal);
            }
        } elseif ($firstOperator == "ends_with") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." LIKE"." '%".strtoupper($firstValue)."'");
            } else {
                $query = $query->andWhere($ft." LIKE"." '%".strtoupper($firstValue)."'");
            }
        } elseif ($firstOperator == "not_ends_with") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." NOT LIKE"." '%".strtoupper($firstValue)."'");
            } else {
                $query = $query->andWhere($ft." NOT LIKE"." '%".strtoupper($firstValue)."'");
            }
        } elseif ($firstOperator == "contains") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." LIKE"." '%".strtoupper($firstValue)."%'");
            } else {
                $query = $query->andWhere($ft." LIKE"." '%".strtoupper($firstValue)."%'");
            }
        } elseif ($firstOperator == "not_contains") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." NOT LIKE"." '%".strtoupper($firstValue)."%'");
            } else {
                $query = $query->andWhere($ft." NOT LIKE"." '%".strtoupper($firstValue)."%'");
            }
        } elseif ($firstOperator == "is_empty") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." ".$firstValue."= ''");
            } else {
                $query = $query->andWhere($ft." ".$firstValue."= ''");
            }
        } elseif ($firstOperator == "is_not_empty") {
            if ($condition == "OR") {
                $query = $query->orWhere($ft." ".$firstValue."!=''");
            } else {
                $query = $query->andWhere($ft." ".$firstValue."!=''");
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
    * Get the info contained in each block of joint. 
    * 
    */
    public function getJointsBlocks($joins, $query) {

        foreach ($joins as $j) {
            $formerTable = $j["formerTable"];
            $jointtype = $j["join"];
            $adjTable = $j["adjacent_table"];
            $srcField = $j["sourceField"];
            $tgtField = $j["targetField"];
            if ($j["constraints"] != "") {
                $newConstraints = $j["constraints"];
                $newCondition = $newConstraints["condition"];
            }
            if (count($j) == 7) {
                $newFields = $j["fields"];
                foreach ($newFields as $newValue){
                    $query = $query->addSelect($adjTable.".".$newValue);
                };
            }
            $query = $this->makeJoint($joins, $query, $formerTable, $jointtype, $adjTable, $srcField, $tgtField);
                

            dump($newCondition); 
        }
        return $query;
    }

    /**
    * Get the type of joint and returns the query with the appropriate joint. 
    * 
    */
    public function makeJoint($joins, $query, $formerTable, $jointtype, $adjTable, $srcField, $tgtField) {
        // inner, left, right, cross, full
        if ($jointtype == "inner join") {
            $query = $query->addSelect($adjTable.'.'.$tgtField)
            ->innerJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
            
        } elseif ($jointtype == "left join") {
            $query = $query->addSelect($adjTable.'.'.$tgtField)
            ->leftJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        } elseif ($jointtype == "right join") {
            $query = $query->addSelect($adjTable.'.'.$tgtField)
            ->leftJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $adjTable.'.'.$tgtField." = ".$formerTable.'.'.$srcField);
        } elseif ($jointtype == "cross join") {
            $query = $query->addSelect($adjTable.'.'.$tgtField)
            ->crossJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        } elseif ($jointtype == "full join") {
            $query = $query->addSelect($adjTable.'.'.$tgtField)
            ->fullJoin('BbeesE3sBundle:'.$adjTable, $adjTable, 'WITH', $formerTable.'.'.$srcField." = ".$adjTable.'.'.$tgtField);
        }
        dump($query);
        return $query;
    }

    /**
    * Get the type of joint and returns the query with the appropriate joint. 
    * 
    */
    public function getNewConstraints($newConstraints, $joins, $query, $adjTable, $newCondition) {
        $newField = $newConstraints["field"];
        $newOperator = $newConstraints["operator"];
        $newValue = $newConstraints["value"];
        $nft = $adjTable.".".$newField;
        if ($newOperator == "equal") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." = ".$newValue);
            } else {
                $query = $query->andWhere($nft." = ".$newValue);
            }
        } elseif ($newOperator == "not_equal"){
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft."!=".$newValue);
            } else {
                $query = $query->andWhere($nft."!=".$newValue);
            }
        } elseif ($newOperator == "less") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft."<".$newValue);
            } else {
                $query = $query->andWhere($nft."<".$newValue);
            }
        } elseif ($newOperator == "less_or_equal") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft."<=".$newValue);
            } else {
                $query = $query->andWhere($nft."<=".$newValue);
            }
        } elseif ($newOperator == "greater") {
            if ($nweCondition == "OR") {
                $query = $query->orWhere($nft.">".$newValue);
            } else {
                $query = $query->andWhere($nft.">".$newValue);
            }
        } elseif ($newOperator == "greater_or_equal") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft.">=".$newValue);
            } else {
                $query = $query->andWhere($nft.">=".$newValue);
            }
        } elseif ($newOperator == "begins_with") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." LIKE"." '".strtoupper($newValue)."%'");
            } else {
                $query = $query->andWhere($nft." LIKE"." '".strtoupper($newValue)."%'");
            }
        } elseif ($newOperator == "not_begins_with") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." NOT LIKE"." '".strtoupper($newValue)."%'");
            } else {
                $query = $query->andWhere($nft." NOT LIKE"." '".strtoupper($newValue)."%'");
            }
        } elseif ($newOperator == "is_null") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." ".$newValue." IS NULL");
            } else {
                $query = $query->andWhere($nft." ".$newValue." IS NULL");
            }
        } elseif ($newOperator == "is_not_null") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." ".$newValue." IS NOT NULL");
            } else {
                $query = $query->andWhere($nft." ".$newValue." IS NOT NULL");
            }
        } elseif ($newOperator == "between") {
            $newLowVal = $newValue[0];
            $newHighVal = $newValue[1];
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." BETWEEN ".$newLowVal." AND ".$newHighVal);
            } else {
                $query = $query->andWhere($nft." BETWEEN ".$newLowVal." AND ".$newHighVal);
            }
        } elseif ($newOperator == "not_between") {
            $newLowVal = $newValue[0];
            $newHighVal = $newValue[1];
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." NOT BETWEEN ".$newLowVal." AND ".$newHighVal);
            } else {
                $query = $query->andWhere($nft." NOT BETWEEN ".$newLowVal." AND ".$newHighVal);
            }
        } elseif ($newOperator == "ends_with") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." LIKE"." '%".strtoupper($newValue)."'");
            } else {
                $query = $query->andWhere($nft." LIKE"." '%".strtoupper($newValue)."'");
            }
        } elseif ($newOperator == "not_ends_with") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." NOT LIKE"." '%".strtoupper($newValue)."'");
            } else {
                $query = $query->andWhere($nft." NOT LIKE"." '%".strtoupper($newValue)."'");
            }
        } elseif ($newOperator == "contains") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." LIKE"." '%".strtoupper($newValue)."%'");
            } else {
                $query = $query->andWhere($nft." LIKE"." '%".strtoupper($newValue)."%'");
            }
        } elseif ($newOperator == "not_contains") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." NOT LIKE"." '%".strtoupper($newValue)."%'");
            } else {
                $query = $query->andWhere($nft." NOT LIKE"." '%".strtoupper($newValue)."%'");
            }
        } elseif ($newOperator == "is_empty") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." ".$newValue."= ''");
            } else {
                $query = $query->andWhere($nft." ".$newValue."= ''");
            }
        } elseif ($newOperator == "is_not_empty") {
            if ($newCondition == "OR") {
                $query = $query->orWhere($nft." ".$newValue."!=''");
            } else {
                $query = $query->andWhere($nft." ".$newValue."!=''");
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