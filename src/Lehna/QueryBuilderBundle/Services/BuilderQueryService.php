<?php

namespace Lehna\QueryBuilderBundle\Services;

use Doctrine\ORM\EntityManagerInterface;

/**
 * Service BuilderQueryService
 */
class BuilderQueryService
{
    private $entityManager;

    public function __construct(EntityManagerInterface $manager)
    {
        $this->entityManager = $manager;
    }

    /***************************************************************************
     * UTILITY QUERIES
     ***************************************************************************/

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
}