<?php

namespace Lehna\QueryBuilderBundle\Controller;

use Bbees\E3sBundle\BbeesE3sBundle;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use FL\QBJSParserBundle\Service\JavascriptBuilders;
use Symfony\Component\HttpFoundation\Request;
use Bbees\E3sBundle\Entity;

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
        $x = $this->getDoctrine()->getConnection()->getSchemaManager();
        $x = $this->getDoctrine()-> getManager();
        // $bundle = $this->getKernel()->getBundle("BbeesE3sBundle");
        // $meta = $x->getMetadataFactory()->getBundleMetadata($bundle);
        $meta = $x->getMetadataFactory()->getAllMetadata();
        dump($meta[0]);
        dump($meta[0]->fieldMappings);#getFieldMapping("codeCommune"));
        return $this->render('@LehnaQueryBuilder/index.html.twig');
    }

    /**
     * @Route("/init", name="querybuilder_init", methods={"GET"})
     * 
     */
    public function init_builders()
    {
        // dump($sm->listTableForeignKeys("dna"));
        $builders = $this->get('fl_qbjs_parser.javascript_builders')->getBuilders();
        
        
        // $foreign_keys = $sm->listTableForeignKeys("dna");
        // dump($foreign_keys);
        
        $builders_array = array_map(
            function ($b) {
                $builder_data = json_decode($b->getJsonString(), true);
                $extra_data = [
                    "class" => $b->getClassName(),
                    "name" => $b->getHumanReadableName()
                ];
                $sm = $this->getDoctrine()->getConnection()->getSchemaManager();
                $foreign_keys = $sm->listTableForeignKeys($extra_data['name']);
               
                $related = array_map(
                    function ($fk) {
                        return $fk->getForeignTableName();
                    },
                    $foreign_keys
                );

                return array_merge($builder_data, $extra_data, ["related" => $related]);
            },
            $builders
        );
        return new JsonResponse($builders_array);
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
