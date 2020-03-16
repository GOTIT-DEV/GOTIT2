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
        return $this;
    }
}
