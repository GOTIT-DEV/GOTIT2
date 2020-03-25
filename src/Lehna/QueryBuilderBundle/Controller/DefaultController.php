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
     *  @Route("/query", name="query_test", methods={"GET"})
     * 
     */
    public function get_query(Request $request)
    {
        $data = $request->request;
        dump($data);
        return $data;
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
}