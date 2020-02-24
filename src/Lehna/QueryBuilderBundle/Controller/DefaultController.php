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
use Doctrine\Persistence\Mapping\ClassMetadata;

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
        $x = $this->getDoctrine()->getManager();
        // $bundle = $this->getKernel()->getBundle("BbeesE3sBundle");
        // $meta = $x->getMetadataFactory()->getBundleMetadata($bundle);
        $meta = $x->getMetadataFactory()->getAllMetadata();

        // dump($meta[0]);
        // dump($meta[0]->fieldMappings)

        return $this->render('@LehnaQueryBuilder/index.html.twig', [
            "meta" => $meta[0]#->getAssociationMappings()
        ]);
    }

    /**
     * @Route("/init", name="querybuilder_init", methods={"GET"})
     * 
     */
    public function init_builders()
    {
        $x = $this->getDoctrine()->getConnection()->getSchemaManager();
        $x = $this->getDoctrine()->getManager();
        // $bundle = $this->getKernel()->getBundle("BbeesE3sBundle");
        // $meta = $x->getMetadataFactory()->getBundleMetadata($bundle);
        $meta = $x->getMetadataFactory()->getAllMetadata();

        // dump($meta[0]);
        // dump($meta[0]->fieldMappings);#getFieldMapping("codeCommune"));

        $res = $this->parse_metadata($meta[0]);
        return new JsonResponse($res);
    }
    private function parse_metadata(ClassMetadata $metadata)
    {
        $make_filter = function ($field) {
            return [
                "id" => $field['fieldName'],
                "label" => $field['fieldName'],
                "type" => $field['type']
            ];
        };
        $entity = $metadata->name;
        $filters = array_map($make_filter, $metadata->fieldMappings);
        $relations = 
        return [
            "class" => $entity,
            "filters" => $filters,
            "human_readable_name" => $entity,
            "table" => $metadata->table["name"]
        ];
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
