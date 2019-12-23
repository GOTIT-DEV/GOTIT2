<?php

/*
 * This file is part of the E3sBundle.
 *
 * Authors : see information concerning authors of GOTIT project in file AUTHORS.md
 *
 * E3sBundle is free software : you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 * 
 * E3sBundle is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with E3sBundle.  If not, see <https://www.gnu.org/licenses/>
 * 
 */

namespace Bbees\E3sBundle\Controller;

use Bbees\E3sBundle\Entity\Chromatogramme;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\Common\Collections\ArrayCollection;
use Bbees\E3sBundle\Services\GenericFunctionService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * Chromatogramme controller.
 *
 * @Route("chromatogramme")
 * @Security("has_role('ROLE_INVITED')")
 * 
 */
class ChromatogrammeController extends Controller
{
    /**
     * Lists all chromatogramme entities.
     *
     * @Route("/", name="chromatogramme_index")
     * @Method("GET")
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $chromatogrammes = $em->getRepository('BbeesE3sBundle:Chromatogramme')->findAll();

        return $this->render('chromatogramme/index.html.twig', array(
            'chromatogrammes' => $chromatogrammes,
        ));
    }

    /**
     * Returns in json format a set of fields to display (tab_toshow) with the following criteria: 
     * a) 1 search criterion ($ request-> get ('searchPhrase')) insensitive to the case and  applied to a field
     * b) the number of lines to display ($ request-> get ('rowCount'))
     * c) 1 sort criterion on a collone ($ request-> get ('sort'))
     *
     * @Route("/indexjson", name="chromatogramme_indexjson")
     * @Method("POST")
     */
    public function indexjsonAction(Request $request)
    {
        // load services
        $service = $this->get('bbees_e3s.generic_function_e3s');      
        $em = $this->getDoctrine()->getManager();
        //
        $rowCount = ($request->get('rowCount')  !== NULL) ? $request->get('rowCount') : 10;
        $orderBy = ($request->get('sort')  !== NULL) ? $request->get('sort') : array('chromatogramme.dateMaj' => 'desc', 'chromatogramme.id' => 'desc');  
        $minRecord = intval($request->get('current')-1)*$rowCount;
        $maxRecord = $rowCount; 
        // initializes the searchPhrase variable as appropriate and sets the condition according to the url idFk parameter
        $where = 'LOWER(chromatogramme.codeChromato) LIKE :criteriaLower';
        $searchPhrase = $request->get('searchPhrase');
        if ( $request->get('searchPatern') !== null && $request->get('searchPatern') !== '' && $searchPhrase == '') {
            $searchPhrase = $request->get('searchPatern');
        }
        if ( $request->get('idFk') !== null && $request->get('idFk') !== '') {
            $where .= ' AND chromatogramme.pcrFk = '.$request->get('idFk');
        }
        // Search for the list to show EstAligneEtTraite
        $tab_toshow =[];
        $toshow = $em->getRepository("BbeesE3sBundle:Chromatogramme")->createQueryBuilder('chromatogramme')
            ->where($where)
            ->setParameter('criteriaLower', strtolower($searchPhrase).'%')
            ->leftJoin('BbeesE3sBundle:Pcr', 'pcr', 'WITH', 'chromatogramme.pcrFk = pcr.id')
            ->leftJoin('BbeesE3sBundle:Adn', 'adn', 'WITH', 'pcr.adnFk = adn.id')
            ->leftJoin('BbeesE3sBundle:Individu', 'individu', 'WITH', 'adn.individuFk = individu.id')
            ->leftJoin('BbeesE3sBundle:Voc', 'vocGene', 'WITH', 'pcr.geneVocFk = vocGene.id')
            ->leftJoin('BbeesE3sBundle:Voc', 'vocQualiteChromato', 'WITH', 'chromatogramme.qualiteChromatoVocFk = vocQualiteChromato.id')
            ->addOrderBy(array_keys($orderBy)[0], array_values($orderBy)[0])
            ->getQuery()
            ->getResult();
        $nb = count($toshow);
        $toshow = array_slice($toshow, $minRecord, $rowCount);  
        $lastTaxname = '';
        foreach($toshow as $entity)
        {
            $id = $entity->getId();
            $DateMaj = ($entity->getDateMaj() !== null) ?  $entity->getDateMaj()->format('Y-m-d H:i:s') : null;
            $DateCre = ($entity->getDateCre() !== null) ?  $entity->getDateCre()->format('Y-m-d H:i:s') : null;       
            // search for sequences associated with the chromatogram
            $query = $em->createQuery('SELECT eaet.id, sa.id as id_sqc_ass, sa.codeSqcAss as code_sqc_ass, voc.libelle as statut, sa.codeSqcAlignement as code_sqc_alignement, sa.dateCreationSqcAss as date_sqc_ass FROM BbeesE3sBundle:EstAligneEtTraite eaet JOIN eaet.sequenceAssembleeFk sa JOIN sa.statutSqcAssVocFk voc WHERE eaet.chromatogrammeFk = '.$id.' ORDER BY eaet.id DESC')->getResult();
            $lastCodeSeqAss = (count($query) > 0) ? $query[0]['code_sqc_ass'] : '';
            $lastCodeSeqAlignement = (count($query) > 0) ? $query[0]['code_sqc_alignement'] : '';
            $lastStatutSeqAss = (count($query) > 0) ? $query[0]['statut'] : '';
            $lastDateSeqAss = (count($query) > 0 && $query[0]['date_sqc_ass']!== null ) ? $query[0]['date_sqc_ass']->format('Y-m-d') : '';
            $linkSqcAss = (count($query) > 0) ?  $query[0]['id_sqc_ass'] : '';
            //
            $tab_toshow[] = array("id" => $id, "chromatogramme.id" => $id, 
             "individu.codeIndBiomol" => $entity->getPcrFk()->getAdnFk()->getIndividuFk()->getCodeIndBiomol(),
             "adn.codeAdn" => $entity->getPcrFk()->getAdnFk()->getCodeAdn(),
             "chromatogramme.codeChromato" => $entity->getCodeChromato(),
             "vocGene.code" => $entity->getPcrFk()->getGeneVocFk()->getCode(), 
             "pcr.codePcr" => $entity->getPcrFk()->getCodePcr(),  
             "pcr.numPcr" => $entity->getPcrFk()->getNumPcr(), 
             "vocQualiteChromato.code" => $entity->getQualiteChromatoVocFk()->getLibelle(),   
             "chromatogramme.dateCre" => $DateCre, "chromatogramme.dateMaj" => $DateMaj,
             "userCreId" => $service->GetUserCreId($entity), "chromatogramme.userCre" => $service->GetUserCreUsername($entity) ,"chromatogramme.userMaj" => $service->GetUserMajUsername($entity),
             "lastCodeSeqAss" => $lastCodeSeqAss,"lastStatutSeqAss" => $lastStatutSeqAss,"lastCodeSeqAlignement" => $lastCodeSeqAlignement,"lastDateSeqAss" => $lastDateSeqAss,
             "linkSequenceassemblee" => $linkSqcAss,);
        }    
 
        // Ajax answer
        $response = new Response ();
        $response->setContent ( json_encode ( array (
            "current"    => intval( $request->get('current') ), 
            "rowCount"  => $rowCount,            
            "rows"     => $tab_toshow, 
            "searchPhrase" => $searchPhrase,
            "total"    => $nb // total data array				
            ) ) );
        // If it is an Ajax request: returns the content in json format
        $response->headers->set('Content-Type', 'application/json');

        return $response;          
    }

    
    /**
     * Creates a new chromatogramme entity.
     *
     * @Route("/new", name="chromatogramme_new")
     * @Method({"GET", "POST"})
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function newAction(Request $request)
    {
        $chromatogramme = new Chromatogramme();
        $form = $this->createForm('Bbees\E3sBundle\Form\ChromatogrammeType', $chromatogramme);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($chromatogramme);
            try {
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('chromatogramme/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->redirectToRoute('chromatogramme_edit', array('id' => $chromatogramme->getId(), 'valid' => 1));                      
        }

        return $this->render('chromatogramme/edit.html.twig', array(
            'chromatogramme' => $chromatogramme,
            'edit_form' => $form->createView(),
        ));
    }

    /**
     * Finds and displays a chromatogramme entity.
     *
     * @Route("/{id}", name="chromatogramme_show")
     * @Method("GET")
     */
    public function showAction(Chromatogramme $chromatogramme)
    {
        $deleteForm = $this->createDeleteForm($chromatogramme);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\ChromatogrammeType', $chromatogramme);

        return $this->render('show.html.twig', array(
            'chromatogramme' => $chromatogramme,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Displays a form to edit an existing chromatogramme entity.
     *
     * @Route("/{id}/edit", name="chromatogramme_edit")
     * @Method({"GET", "POST"})
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function editAction(Request $request, Chromatogramme $chromatogramme)
    {
        //  access control for user type  : ROLE_COLLABORATION
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $user = $this->getUser();
        if ($user->getRole() ==  'ROLE_COLLABORATION' && $chromatogramme->getUserCre() != $user->getId() ) {
                $this->denyAccessUnlessGranted('ROLE_ADMIN', null, 'ACCESS DENIED');
        }
        //
        $deleteForm = $this->createDeleteForm($chromatogramme);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\ChromatogrammeType', $chromatogramme);
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            // flush
            $this->getDoctrine()->getManager()->persist($chromatogramme);                       
            try {
                $this->getDoctrine()->getManager()->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('chromatogramme/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->render('chromatogramme/edit.html.twig', array(
                'chromatogramme' => $chromatogramme,
                'edit_form' => $editForm->createView(),
                'valid' => 1));
        }        

        return $this->render('chromatogramme/edit.html.twig', array(
            'chromatogramme' => $chromatogramme,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Deletes a chromatogramme entity.
     *
     * @Route("/{id}", name="chromatogramme_delete")
     * @Method("DELETE")
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function deleteAction(Request $request, Chromatogramme $chromatogramme)
    {
        $form = $this->createDeleteForm($chromatogramme);
        $form->handleRequest($request);

        $submittedToken = $request->request->get('token');
        if (($form->isSubmitted() && $form->isValid()) || $this->isCsrfTokenValid('delete-item', $submittedToken) ) {
            $em = $this->getDoctrine()->getManager();
            try {
                $em->remove($chromatogramme);
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('chromatogramme/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            }   
        }
        
        return $this->redirectToRoute('chromatogramme_index');
    }

    /**
     * Creates a form to delete a chromatogramme entity.
     *
     * @param Chromatogramme $chromatogramme The chromatogramme entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Chromatogramme $chromatogramme)
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('chromatogramme_delete', array('id' => $chromatogramme->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
