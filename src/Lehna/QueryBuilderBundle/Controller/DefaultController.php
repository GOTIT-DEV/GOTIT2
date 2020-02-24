<?php

namespace Lehna\QueryBuilderBundle\Controller;

use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Bbees\E3sBundle\Entity;
use Lehna\QueryBuilderBundle\Services\QueryBuilderService;

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
     * @Route("/parser-test", name="parser-test", methods={"POST"})
     */
    public function reportsAction(Request $request)
    {

        $jsonString = $request->getContent();
        dump($jsonString);

        $parsedRuleGroup = $this->get('fl_qbjs_parser.json_query_parser.doctrine_orm_parser')
            ->parseJsonString($jsonString, Entity\Boite::class, ["codeBoite", "libelleBoite"]);

        $query_str = $parsedRuleGroup->getQueryString();
        $parameters = $parsedRuleGroup->getParameters();

        dump($query_str);

        $query = $this->getDoctrine()->getEntityManager()
            ->createQuery($query_str);
        $query->setParameters($parameters);
        $results = $query->getArrayResult();

        return new JsonResponse($results);
    }
}
