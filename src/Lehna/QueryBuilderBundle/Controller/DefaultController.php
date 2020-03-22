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
     *  @Route("/response", name="response_test", methods={"POST"})
     * 
     */
    public function indexjsonAction(Request $request)
    {   
        // load services
        $service = $this->get('bbees_e3s.generic_function_e3s');
        $em = $this->getDoctrine()->getManager();
        //
        $rowCount = ($request->get('rowCount')  !== NULL) ? $request->get('rowCount') : 10;
        $orderBy = ($request->get('sort')  !== NULL) ? $request->get('sort') : array('station.dateMaj' => 'desc', 'station.id' => 'desc');  
        $minRecord = intval($request->get('current')-1)*$rowCount;
        $maxRecord = $rowCount;      
        $tab_toshow =[];
        $entities_toshow = $em->getRepository("BbeesE3sBundle:Station")->createQueryBuilder('station')
            ->where('LOWER(station.codeStation) LIKE :criteriaLower')
            ->setParameter('criteriaLower', strtolower($request->get('searchPhrase')).'%')
            ->leftJoin('BbeesE3sBundle:Pays', 'pays', 'WITH', 'station.paysFk = pays.id')
            ->leftJoin('BbeesE3sBundle:Commune', 'commune', 'WITH', 'station.communeFk = commune.id')
            ->addOrderBy(array_keys($orderBy)[0], array_values($orderBy)[0])
            ->getQuery()
            ->getResult();
        $nb_entities = count($entities_toshow);
        $entities_toshow = array_slice($entities_toshow, $minRecord, $rowCount); 
        
        foreach($entities_toshow as $entity)
        {
            $id = $entity->getId();
            $DateCre = ($entity->getDateCre() !== null) ?  $entity->getDateCre()->format('Y-m-d H:i:s') : null;
            $DateMaj = ($entity->getDateMaj() !== null) ?  $entity->getDateMaj()->format('Y-m-d H:i:s') : null;
            $query = $em->createQuery('SELECT collecte.id FROM BbeesE3sBundle:Collecte collecte WHERE collecte.stationFk = '.$id.'')->getResult();
            $stationFk = (count($query) > 0) ? $id : '';
            $tab_toshow[] = array( "id" => $id, "station.id" => $id, "station.codeStation" => $entity->getCodeStation(),
             "station.nomStation" => $entity->getNomStation(),
             "commune.codeCommune" => $entity->getCommuneFk()->getCodeCommune(),
             "pays.codePays" => $entity->getPaysFk()->getCodePays(),
             "station.latDegDec" => $entity->getLatDegDec(), "station.longDegDec" => $entity->getLongDegDec(),
             "station.dateCre" => $DateCre, "station.dateMaj" => $DateMaj, 
             "userCreId" => $service->GetUserCreId($entity), "station.userCre" => $service->GetUserCreUsername($entity) ,"station.userMaj" => $service->GetUserMajUsername($entity),
             "linkCollecte" => $stationFk);
        }                
        $response = new Response ();
        $response->setContent ( json_encode ( array (
            "current"    => intval( $request->get('current') ), 
            "rowCount"  => $rowCount,            
            "rows"     => $tab_toshow, 
            "total"    => $nb_entities // total data array				
            ) ) );
        // If it is an Ajax request: returns the content in json format
        $response->headers->set('Content-Type', 'application/json');

        return $response;          
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
     * @Route("/{table}", name="table_get", methods={"POST"})
     * 
     */
    public function showStation(Request $request,$table)
    {
        $service = $this->get('bbees_e3s.generic_function_e3s');
        $em = $this->getDoctrine()->getManager();
        $tables = $em->getRepository('BbeesE3sBundle:'.$table)->findAll();
        $tab_toshow =[];
        foreach($tables as $entity)
        {
            $id = $entity->getId();
            $user = $entity-> getUserCre();
            $tab_toshow[] = array( "id" => $id, "user" => $user);
        }
        $response = new Response ();
        $response->setContent ( json_encode ( array ( 
            "rows"  => $tab_toshow       			
            ) ) );
        // If it is an Ajax request: returns the content in json format
        $response->headers->set('Content-Type', 'application/json');

        return $response;  
    }
}