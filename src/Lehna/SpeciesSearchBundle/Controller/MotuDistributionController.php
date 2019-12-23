<?php

/*
 * This file is part of the SpeciesSearchBundle.
 *
 * Authors : see information concerning authors of GOTIT project in file AUTHORS.md
 *
 * SpeciesSearchBundle is free software : you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 * 
 * SpeciesSearchBundle is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with SpeciesSearchBundle.  If not, see <https://www.gnu.org/licenses/>
 *
 */

namespace Lehna\SpeciesSearchBundle\Controller;

use Bbees\E3sBundle\Entity\Motu;
use Lehna\SpeciesSearchBundle\Services\QueryBuilderService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * Controller for querying MOTU distribution 
 *
 * @Route("/distribution")
 * @Security("has_role('ROLE_INVITED')")
 * @author Louis Duchemin <ls.duchemin@gmail.com>
 */
class MotuDistributionController extends Controller {

  /**
   * @Route("/", name="distribution")
   *
   * Index : render query form template
   */
  public function index(QueryBuilderService $service) {
    $doctrine = $this->getDoctrine();
    # fetch datasets
    $datasets = $doctrine->getRepository(Motu::class)->findAll();
    # fetch genus and method sets 
    $genus_set    = $service->getGenusSet();
    $methods_list = $service->listMethodsByDate();
    # render form template
    return $this->render('@LehnaSpeciesSearch/motu-distribution/index.html.twig', array(
      'genus_set'    => $genus_set,
      'datasets'     => $datasets,
      'methods_list' => $methods_list,
    ));
  }

  /**
   * @Route("/query", name="distribution-query")
   *
   * returns a JSON response with 
   * - query : the initial query parameters 
   * - rows : geographical + motu data for each sequence
   * - methode : MOTU method details
   */
  public function searchQuery(Request $request, QueryBuilderService $service) {
    # POST parameters 
    $data = $request->request;
    # Obtention de la localisation géographique
    $res = $service->getMotuGeoLocation($data);
    $methode = $service->getMethod($data->get('methode'), $data->get('dataset'));
    # Renvoi réponse JSON
    return new JsonResponse(array(
      'query'   => $data->all(),
      'rows'    => $res,
      'methode' => $methode,
    ));
  }
}
