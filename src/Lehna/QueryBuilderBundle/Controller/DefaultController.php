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

use Bbees\E3sBundle\Entity\ACibler;
use Bbees\E3sBundle\Entity\Adn;
use Bbees\E3sBundle\Entity\AdnEstRealisePar;
use Bbees\E3sBundle\Entity\APourFixateur;
use Bbees\E3sBundle\Entity\APourSamplingMethod;
use Bbees\E3sBundle\Entity\Assigne;
use Bbees\E3sBundle\Entity\Commune;
use Bbees\E3sBundle\Entity\CompositionLotMateriel;
use Bbees\E3sBundle\Entity\EspeceIdentifiee;
use Bbees\E3sBundle\Entity\Collecte;
use Bbees\E3sBundle\Entity\Station;
use Bbees\E3sBundle\Entity\LotMateriel;
use Bbees\E3sBundle\Entity\LotMaterielExt;
use Bbees\E3sBundle\Entity\Individu;
use Bbees\E3sBundle\Entity\IndividuLame;
use Bbees\E3sBundle\Entity\Pcr;
use Bbees\E3sBundle\Entity\Chromatogramme;
use Bbees\E3sBundle\Entity\SequenceAssemblee;
use Bbees\E3sBundle\Entity\SequenceAssembleeExt;
use Bbees\E3sBundle\Entity\Motu;
use Bbees\E3sBundle\Entity\Boite;
use Bbees\E3sBundle\Entity\Source;


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
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();
        $initial = $data["initial"];
        $query = $this->getFirstBlock($initial, $qb);
        
        $q = $query->getQuery();

        $results = $q->getArrayResult();

        return $this->render('@LehnaQueryBuilder/formResults.html.twig', array(
            "donnees" => $results,
        ));
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
    public function getFirstBlock($initial, $query) {
        
        $firstTable = $initial["table"];
        $query = $query->from('BbeesE3sBundle:'.$firstTable, $firstTable);
        $firstFields = $initial["fields"];
        $condition = $initial["constraintsTable1"]["condition"];
        $firstConstraints = $initial["constraintsTable1"]["rules"];
        
        foreach ($firstFields as $value){
            $query = $query->addSelect($firstTable.".".$value);
        };

        $query = $this->constraintsOfLevel($initial["constraintsTable1"]["rules"], $query, $initial, $firstTable, $condition);


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

    

}