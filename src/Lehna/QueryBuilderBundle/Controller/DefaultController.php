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
    public function get_query(Request $request)
    {
        $data = $request->request->all();
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();
        $initial = $data["initial"];
        $query = $this->getFirstBlock($initial, $qb);
        //$query = $this->getFirstTable($data, $query);
        //$query = $this->getFirstConstraints($data, $query);
        $q = $query->getQuery();
        dump($q);
        $results = $q->getArrayResult();
        dump($results);
        return new JsonResponse($results);
        
    }

    /**
     * Lists all user entities. 
     * @Route("/ab", name="user_index", methods={"GET"})
     * 
     */
    public function showUser(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $users = $em->getRepository('BbeesUserBundle:User')->findAll();
        dump($users);
        return $this->render('@LehnaQueryBuilder/results.html.twig',['users'=>$users]);
    }


    /**
     * Lists all station entities. 
     * @Route("/sanscontraintes", name="tablesSans_get", methods={"GET"})
     * 
     */
    public function showStation2(Request $request)
    {
        $service = $this->get('bbees_e3s.generic_function_e3s');
        $em = $this->getDoctrine()->getManager();
        $tables = $em->getRepository('BbeesE3sBundle:Station')->createQueryBuilder('station')
            ->leftJoin('BbeesE3sBundle:Pays', 'pays', 'WITH', 'station.paysFk = pays.id')
            ->getQuery()
            ->getResult();
        $tab_toshow =[];
        foreach($tables as $entity)
        {
            $tab_toshow[] = array( "station.id" => $entity->getId(), "station.codeStation" => $entity->getCodeStation(),
             "station.nomStation" => $entity->getNomStation(),
             "pays.codePays" => $entity->getPaysFk()->getCodePays());
        }
        $response = new Response ();
        $response->setContent ( json_encode ( array ( 
            "rows"  => $tab_toshow       			
            ) ) );
        // If it is an Ajax request: returns the content in json format
        $response->headers->set('Content-Type', 'application/json');

        return $response;  
    }

    /**
    * Lists all station entities. 
    * @Route("/getgenusset", name="get_json", methods={"GET"})
    * 
    */
    

    public function getGenusSet()
    {
        $qb    = $this->entityManager->createQueryBuilder();
        $query = $qb->select('rt.genus')
        ->from('BbeesE3sBundle:ReferentielTaxon', 'rt')
        ->where('rt.genus IS NOT NULL')
        ->distinct()
        ->orderBy('rt.genus')
        ->getQuery();
        return $query->getResult();
    }

    /**
    * Lists all station entities. 
    * @Route("/getgenusset2", name="get_json2", methods={"GET"})
    * 
    */

    public function getGenusSet2(Request $request)
    {
        $request->request->get("field");
        $qb    = $this->entityManager->createQueryBuilder();
        $query = $qb->from('BbeesE3sBundle:ReferentielTaxon', 'rt');
        // on tombe sur une contrainte
        $query = $query->where('rt.genus IS NOT NULL');
        // etc...
        $query = $query->select("rt.genus");

        $query->distinct()
        ->orderBy('rt.genus')
        ->getQuery();
        return $query->getResult();
    }

    /**
    * Lists all station entities. 
    * @Route("/searchquery", name="search_query", methods={"GET"})
    * 
    */
    public function searchQuery(Request $request, SpeciesQueryService $service) {
        # POST parameters
        $data = $request->request;
        # execute query
        $res  = $service->getMotuCountList($data);
        # return JSON response
        return new JsonResponse(array(
        'rows'     => $res,
        'query'    => $data->all(),
        ));
    }

    /**
    * Get the first fields of the first table that we want to return and creates the "select" part of the query. 
    * @Route("/query", name="test_query", methods={"POST"})
    * 
    */
    public function getFirstBlock($initial, $query) {
        $firstTable = $initial["table"];
        $query = $query->from('BbeesE3sBundle:'.$firstTable, $firstTable);
        $firstFields = $initial["fields"];
        foreach ($firstFields as $value){
            $query = $query->addSelect($firstTable.".".$value);
        };
        $query = $this->getFirstConstraints($initial, $query, $firstTable);

        return $query;
    }


    /**
    * Get the first table. 
    * @Route("/query", name="test_query", methods={"POST"})
    * 
    */
    /*
    public function getFirstTable($data, $query) {
        $firstTable = $data["initial"]["table"];
        $query = $query->from('BbeesE3sBundle:'.$firstTable, $firstTable);
        return $query;
    }
*/

    /**
    * Get the first constraints. 
    * @Route("/query", name="test_query", methods={"POST"})
    * 
    */
    
    public function getFirstConstraints($initial, $query, $firstTable) {
        $firstConstraints = $initial["constraintsTable1"]["rules"][0];
        $firstField = $firstConstraints["field"];
        $firstOperator = $firstConstraints["operator"];
        $firstValue = $firstConstraints["value"];
        $ft = $firstTable.".".$firstField;
        if ($firstOperator == "equal") {
            $query = $query->where($ft." = ".$firstValue);
        } elseif ($firstOperator == "not_equal"){
            $query = $query->where($ft."!=".$firstValue);
        } elseif ($firstOperator == "less") {
            $query = $query->where($ft."<".$firstValue);
        } elseif ($firstOperator == "less_or_equal") {
            $query = $query->where($ft."<=".$firstValue);
        } elseif ($firstOperator == "greater") {
            $query = $query->where($ft.">".$firstValue);
        } elseif ($firstOperator == "greater_or_equal") {
            $query = $query->where($ft.">=".$firstValue);
        } elseif ($firstOperator == "begins_with") {
            $query = $query->where($ft." LIKE"." '".strtoupper($firstValue)."%'");
        } elseif ($firstOperator == "not_begins_with") {
            $query = $query->where($ft." NOT LIKE"." '".strtoupper($firstValue)."%'");
        } elseif ($firstOperator == "is_null") {
            $query = $query->where($ft." ".$firstValue." IS NULL");
        } elseif ($firstOperator == "is_not_null") {
            $query = $query->where($ft." ".$firstValue." IS NOT NULL");
        } elseif ($firstOperator == "between") {
            $lowVal = $firstValue[0];
            $highVal = $firstValue[1];
            $query = $query->where($ft." BETWEEN ".$lowVal." AND ".$highVal);
        } elseif ($firstOperator == "not_between") {
            $lowVal = $firstValue[0];
            $highVal = $firstValue[1];
            $query = $query->where($ft." NOT BETWEEN ".$lowVal." AND ".$highVal);
        } elseif ($firstOperator == "ends_with") {
            $query = $query->where($ft." LIKE"." '%".strtouppser($firstValue)."'");
        } elseif ($firstOperator == "not_ends_with") {
            $query = $query->where($ft." NOT LIKE"." '%".strtoupper($firstValue)."'");
        } elseif ($firstOperator == "contains") {
            $query = $query->where($ft." LIKE"." '%".strtoupper($firstValue)."%'");
        } elseif ($firstOperator == "not_contains") {
            $query = $query->where($ft." NOT LIKE"." '%".strtoupper($firstValue)."%'");
        } elseif ($firstOperator == "is_empty") {
            $query = $query->where($ft." ".$firstValue."= ''");
        } elseif ($firstOperator == "is_not_empty") {
            $query = $query->where($ft." ".$firstValue."!=''");
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