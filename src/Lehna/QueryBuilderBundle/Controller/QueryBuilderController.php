<?php

namespace Lehna\QueryBuilderBundle\Controller;

use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Lehna\QueryBuilderBundle\Services\SchemaInspectorService;
use Lehna\QueryBuilderBundle\Services\QueryBuilderService;

/**
 * Controller for querying the GOTIT database.
 *
 * @Route("/")
 * @Security("has_role('ROLE_INVITED')")
 */
class QueryBuilderController extends Controller
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
  public function init_builders(SchemaInspectorService $service)
  {
    $config = $service->make_qbuilder_config();
    return new JsonResponse($config);
  }

  /**
   *  @Route("/query", name="qb_make_query", methods={"POST"})
   * 
   *  Main function to query the database. 
   *  Creates a QueryBuilder with Doctrine.
   *  Returns the response of the query.
   */
  public function query(Request $request, QueryBuilderService $service)
  {
    $data = $request->request->all();
    $selectedFields = $service->getSelectFields($data);
    $em = $this->getDoctrine()->getManager();
    $qb = $em->createQueryBuilder();

    $query = $service->makeQuery($data, $qb);

    $q = $query->getQuery();
    $dqlresults = $q->getDql();
    $sqlresults = $q->getSql();
    $results = $q->getArrayResult();
    return new JsonResponse([
      "dql" => $dqlresults,
      "sql" => $sqlresults,
      "results" => $this->renderView(
        '@LehnaQueryBuilder/resultQuery.html.twig',
        ["results" => $results, "selectedFields" => $selectedFields]
      )
    ]);
  }
}
