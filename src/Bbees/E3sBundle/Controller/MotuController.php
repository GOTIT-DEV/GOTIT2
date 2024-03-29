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

use Bbees\E3sBundle\Entity\Motu;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\Common\Collections\ArrayCollection;
use Bbees\E3sBundle\Services\GenericFunctionE3s;
use Bbees\E3sBundle\Entity\Voc;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Doctrine\ORM\EntityRepository;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * Motu controller.
 *
 * @Route("motu")
 * @Security("has_role('ROLE_INVITED')")
 * @author Philippe Grison  <philippe.grison@mnhn.fr>
 */
class MotuController extends AbstractController
{
    /**
     * Lists all motu entities.
     *
     * @Route("/", name="motu_index", methods={"GET"})
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $motus = $em->getRepository('BbeesE3sBundle:Motu')->findAll();

        return $this->render('motu/index.html.twig', array(
            'motus' => $motus,
        ));
    }

        
    /**
     * Returns in json format a set of fields to display (tab_toshow) with the following criteria: 
     * a) 1 search criterion ($ request-> get ('searchPhrase')) insensitive to the case and  applied to a field
     * b) the number of lines to display ($ request-> get ('rowCount'))
     * c) 1 sort criterion on a collone ($ request-> get ('sort'))
     *
     * @Route("/indexjson", name="motu_indexjson", methods={"POST"})
     */
    public function indexjsonAction(Request $request, GenericFunctionE3s $service)
    {
        // load Doctrine Manager      
        $em = $this->getDoctrine()->getManager();
        //
        $rowCount = ($request->get('rowCount')  !== NULL) ? $request->get('rowCount') : 10;
        $orderBy = ($request->get('sort')  !== NULL) ? $request->get('sort') : array('motu.dateMaj' => 'desc', 'motu.id' => 'desc');  
        $minRecord = intval($request->get('current')-1)*$rowCount;
        $maxRecord = $rowCount; 
        // initializes the searchPhrase variable as appropriate and sets the condition according to the url idFk parameter
        $where = 'LOWER(motu.libelleMotu) LIKE :criteriaLower';
        $searchPhrase = $request->get('searchPhrase');
        if ( $request->get('searchPatern') !== null && $request->get('searchPatern') !== '' && $searchPhrase == '') {
            $searchPhrase = $request->get('searchPatern');
        }
        // Search for the list to show
        $tab_toshow =[];
        $toshow = $em->getRepository("BbeesE3sBundle:Motu")->createQueryBuilder('motu')
            ->where($where)
            ->setParameter('criteriaLower', strtolower($searchPhrase).'%')
            ->addOrderBy(array_keys($orderBy)[0], array_values($orderBy)[0])
            ->getQuery()
            ->getResult();
        $nb = count($toshow);
        $toshow = array_slice($toshow, $minRecord, $rowCount);  
        foreach($toshow as $entity)
        {
            $id = $entity->getId();
            $DateMotu = ($entity->getDateMotu() !== null) ?  $entity->getDateMotu()->format('Y-m-d') : null;
            $DateMaj = ($entity->getDateMaj() !== null) ?  $entity->getDateMaj()->format('Y-m-d H:i:s') : null;
            $DateCre = ($entity->getDateCre() !== null) ?  $entity->getDateCre()->format('Y-m-d H:i:s') : null;
            //  concatenated list of people
            $query = $em->createQuery('SELECT p.nomPersonne as nom FROM BbeesE3sBundle:MotuEstGenerePar megp JOIN megp.personneFk p WHERE megp.motuFk = '.$id.'')->getResult();            
            $arrayListePersonne = array();
            foreach($query as $taxon) {
                 $arrayListePersonne[] = $taxon['nom'];
            }
            $listePersonne= implode(", ", $arrayListePersonne);
            //
            $tab_toshow[] = array("id" => $id, "motu.id" => $id, 
             "motu.libelleMotu" => $entity->getLibelleMotu(),
             "motu.nomFichierCsv" => $entity->getNomFichierCsv(),
             "listePersonne" => $listePersonne, 
             "motu.commentaireMotu" => $entity->getCommentaireMotu(),
             "motu.dateMotu" => $DateMotu ,
             "motu.dateCre" => $DateCre, "motu.dateMaj" => $DateMaj,
             "userCreId" => $service->GetUserCreId($entity), "motu.userCre" => $service->GetUserCreUsername($entity) ,"motu.userMaj" => $service->GetUserMajUsername($entity),
             );
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
     * Creates a new motu entity.
     *
     * @Route("/new", name="motu_new", methods={"GET", "POST"})
     * @Security("has_role('ROLE_ADMIN')")
     */
    public function newAction(Request $request)
    {
        $motu = new Motu();
        $form = $this->createForm('Bbees\E3sBundle\Form\MotuType', $motu);
        $form->handleRequest($request);
        
        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($motu);
            try {
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('motu/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->redirectToRoute('motu_edit', array('id' => $motu->getId(), 'valid' => 1));                       
        }

        return $this->render('motu/edit.html.twig', array(
            'motu' => $motu,
            'edit_form' => $form->createView(),
        ));
    }

    /**
     * Finds and displays a motu entity.
     *
     * @Route("/{id}", name="motu_show", methods={"GET"})
     */
    public function showAction(Motu $motu)
    {
        $deleteForm = $this->createDeleteForm($motu);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\MotuType', $motu);
        
        return $this->render('show.html.twig', array(
            'motu' => $motu,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Displays a form to edit an existing motu entity.
     *
     * @Route("/{id}/edit", name="motu_edit", methods={"GET", "POST"})
     * @Security("has_role('ROLE_ADMIN')")
     */
    public function editAction(Request $request, Motu $motu, GenericFunctionE3s $service)
    {        
        // load service  generic_function_e3s
        // 
        
        // store ArrayCollection       
        $motuEstGenerePars = $service->setArrayCollection('MotuEstGenerePars',$motu);
        
        // 
        $deleteForm = $this->createDeleteForm($motu);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\MotuType', $motu);
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            // delete ArrayCollection
            $service->DelArrayCollection('MotuEstGenerePars',$motu, $motuEstGenerePars);
            // flush
            $this->getDoctrine()->getManager()->persist($motu);                       
            try {
                $this->getDoctrine()->getManager()->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('motu/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->render('motu/edit.html.twig', array(
                'motu' => $motu,
                'edit_form' => $editForm->createView(),
                'valid' => 1));
        }
        return $this->render('motu/edit.html.twig', array(
        'motu' => $motu,
        'edit_form' => $editForm->createView(),
        ));
    }

    /**
     * Deletes a motu entity.
     *
     * @Route("/{id}", name="motu_delete", methods={"DELETE"})
     * @Security("has_role('ROLE_ADMIN')")
     */
    public function deleteAction(Request $request, Motu $motu)
    {
        $form = $this->createDeleteForm($motu);
        $form->handleRequest($request);
        
        $submittedToken = $request->request->get('token');
        if (($form->isSubmitted() && $form->isValid()) || $this->isCsrfTokenValid('delete-item', $submittedToken) ) {
            $em = $this->getDoctrine()->getManager();
            try {
                $em->remove($motu);
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('motu/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            }   
        }

        return $this->redirectToRoute('motu_index');
    }

    /**
     * Creates a form to delete a motu entity.
     *
     * @param Motu $motu The motu entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Motu $motu)
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('motu_delete', array('id' => $motu->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
