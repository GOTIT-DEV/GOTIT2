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

use Bbees\E3sBundle\Entity\LotMateriel;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\Common\Collections\ArrayCollection;
use Bbees\E3sBundle\Services\GenericFunctionService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * Lotmateriel controller.
 *
 * @Route("lotmateriel")
 * @Security("has_role('ROLE_INVITED')")
 * @author Philippe Grison  <philippe.grison@mnhn.fr>
 */
class LotMaterielController extends Controller
{
    const MAX_RESULTS_TYPEAHEAD   = 20;
    
    /**
     * Lists all lotMateriel entities.
     *
     * @Route("/", name="lotmateriel_index", methods={"GET"})
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $lotMateriels = $em->getRepository('BbeesE3sBundle:LotMateriel')->findAll();

        return $this->render('lotmateriel/index.html.twig', array(
            'lotMateriels' => $lotMateriels,
        ));
    }
           
    /**
     * @Route("/search/{q}", requirements={"q"=".+"}, name="lotmateriel_search")
     */
    public function searchAction($q)
    {
        $qb = $this->getDoctrine()->getManager()->createQueryBuilder();
        $qb->select('lot.id, lot.codeLotMateriel as code')
            ->from('BbeesE3sBundle:LotMateriel', 'lot');
        $query = explode(' ', strtolower(trim(urldecode($q))));
        $and = [];
        for($i=0; $i<count($query); $i++) {
            $and[] = '(LOWER(lot.codeLotMateriel) like :q'.$i.')';
        }
        $qb->where(implode(' and ', $and));
        for($i=0; $i<count($query); $i++) {
            $qb->setParameter('q'.$i, $query[$i].'%');
        }
        $qb->addOrderBy('code', 'ASC');
        $qb->setMaxResults(self::MAX_RESULTS_TYPEAHEAD);
        $results = $qb->getQuery()->getResult();           
        // Ajax answer
        return $this->json(
            $results
        );
    }

    
    /**
     * Returns in json format a set of fields to display (tab_toshow) with the following criteria: 
     * a) 1 search criterion ($ request-> get ('searchPhrase')) insensitive to the case and  applied to a field
     * b) the number of lines to display ($ request-> get ('rowCount'))
     * c) 1 sort criterion on a collone ($ request-> get ('sort'))
     *
     * @Route("/indexjson", name="lotmateriel_indexjson", methods={"POST"})
     */
    public function indexjsonAction(Request $request)
    {
        // load services
        $service = $this->get('bbees_e3s.generic_function_e3s');       
        $em = $this->getDoctrine()->getManager();
        //
        $rowCount = ($request->get('rowCount')  !== NULL) ? $request->get('rowCount') : 10;
        $orderBy = ($request->get('sort')  !== NULL) ? array_keys($request->get('sort'))[0]." ".array_values($request->get('sort'))[0] : "lot.date_of_update DESC, lot.id DESC";  
        $minRecord = intval($request->get('current')-1)*$rowCount;
        $maxRecord = $rowCount; 
        // initializes the searchPhrase variable as appropriate and sets the condition according to the url idFk parameter
        $where = ' WHERE LOWER(lot.internal_biological_material_code) LIKE :criteriaLower';
        $searchPhrase = $request->get('searchPhrase');
        if ( $request->get('searchPatern') !== null && $request->get('searchPatern') !== '' && $searchPhrase == '') {
            $searchPhrase = $request->get('searchPatern');
        }
        if ( $request->get('idFk') !== null && $request->get('idFk') !== '') {
            $where .= ' AND lot.sampling_fk = '.$request->get('idFk');
        }
        // Search for the list to show
        $tab_toshow =[];
        $rawSql = "SELECT  lot.id, st.site_code, st.latitude, st.longitude, sampling.sample_code, country.country_name, municipality.municipality_code,
        lot.internal_biological_material_status,lot.sequencing_advice, lot.internal_biological_material_date, lot.date_of_creation, lot.date_of_update, voc_lot_identification_criterion.code as code_lot_identification_criterion,
	lot.internal_biological_material_code, rt_lot.taxon_name as last_taxname_lot, ei_lot.identification_date as last_date_identification_lot,
        lot.creation_user_name, user_cre.username as user_cre_username , user_maj.username as user_maj_username,
        string_agg(DISTINCT person.person_name , ' ; ') as list_person, string_agg(cast( ind.id as character varying) , ' ;') as list_specimen
	FROM internal_biological_material lot 
                LEFT JOIN user_db user_cre ON user_cre.id = lot.creation_user_name
                LEFT JOIN user_db user_maj ON user_maj.id = lot.update_user_name
		JOIN sampling ON sampling.id = lot.sampling_fk
			JOIN site st ON st.id = sampling.site_fk
                        LEFT JOIN country ON st.country_fk = country.id
                        LEFT JOIN municipality ON st.municipality_fk = municipality.id
                LEFT JOIN internal_biological_material_is_treated_by ibmitb ON ibmitb.internal_biological_material_fk = lot.id
                    LEFT JOIN person ON ibmitb.person_fk = person.id
		LEFT JOIN identified_species ei_lot ON ei_lot.internal_biological_material_fk = lot.id
			INNER JOIN (SELECT MAX(ei_loti.id) AS maxei_loti 
				FROM identified_species ei_loti 
				GROUP BY ei_loti.internal_biological_material_fk) ei_lot2 ON (ei_lot.id = ei_lot2.maxei_loti)
			LEFT JOIN taxon rt_lot ON ei_lot.taxon_fk = rt_lot.id
                        LEFT JOIN vocabulary voc_lot_identification_criterion ON ei_lot.identification_criterion_voc_fk = voc_lot_identification_criterion.id
		LEFT JOIN  specimen ind ON ind.internal_biological_material_fk = lot.id"
        .$where." 
        GROUP BY lot.id, st.site_code, st.latitude, st.longitude, sampling.sample_code, country.country_name, municipality.municipality_code,
        lot.internal_biological_material_status,lot.sequencing_advice, lot.internal_biological_material_date, lot.date_of_creation, lot.date_of_update, voc_lot_identification_criterion.code ,
	lot.internal_biological_material_code, rt_lot.taxon_name, ei_lot.identification_date,
        lot.creation_user_name, user_cre.username, user_maj.username" 
        ." ORDER BY ".$orderBy;
        
        // $rawSql .= $where;
        $stmt = $em->getConnection()->prepare($rawSql);
        $stmt->bindValue('criteriaLower', strtolower($searchPhrase).'%');
        $stmt->execute();
        // $stmt->fetchAll(\PDO::FETCH_UNIQUE | \PDO::FETCH_ASSOC);
        $entities_toshow = $stmt->fetchAll();
        $nb = count($entities_toshow);
        $entities_toshow = ($request->get('rowCount') > 0 ) ? array_slice($entities_toshow, $minRecord, $rowCount) : array_slice($entities_toshow, $minRecord);
        
        foreach($entities_toshow as $key => $val){
             $linkIndividu = ($val['list_specimen'] !== null) ? strval($val['id']) : '';
             $tab_toshow[] = array("id" => $val['id'], "lot.id" => $val['id'], "lot.internal_biological_material_code" => $val['internal_biological_material_code'], "lot.internal_biological_material_status" => $val['internal_biological_material_status'], 
                "last_taxname_lot" => $val['last_taxname_lot'], "last_date_identification_lot" => $val['last_date_identification_lot'],  "code_lot_identification_criterion" => $val['code_lot_identification_criterion'],
                "lot.sequencing_advice" => $val['sequencing_advice'], "lot.internal_biological_material_date" => $val['internal_biological_material_date'] ,"lot.date_of_creation" => $val['date_of_creation'], "lot.date_of_update" => $val['date_of_update'],
                "list_person" => $val['list_person'], 
                "sampling.sample_code" => $val['sample_code'],
                "country.country_name" => $val['country_name'], "municipality.municipality_code" => $val['municipality_code'],
                "creation_user_name" => $val['creation_user_name'], "user_cre.username" => $val['user_cre_username'] ,"user_maj.username" => $val['user_maj_username'],
                "linkIndividu" => $linkIndividu, 
                "linkIndividu_codestation" => "%|".$val['site_code']."_%" 
             );
         }
        
       
        $lastTaxname = '';
        /*
        foreach($entities_toshow as $entity)
        {
            $id = $entity->getId();
            $codeStation = $entity->getCollecteFk()->getStationFk()->getCodeStation();
            $DateLot = ($entity->getDateLotMateriel() !== null) ?  $entity->getDateLotMateriel()->format('Y-m-d') : null;
            $DateMaj = ($entity->getDateMaj() !== null) ?  $entity->getDateMaj()->format('Y-m-d H:i:s') : null;
            $DateCre = ($entity->getDateCre() !== null) ?  $entity->getDateCre()->format('Y-m-d H:i:s') : null;
            // search for specimen associated to a material
            $query = $em->createQuery('SELECT ind.id FROM BbeesE3sBundle:Individu ind WHERE ind.lotMaterielFk = '.$id.'')->getResult();
            $linkIndividu = (count($query) > 0) ? $id : '';
            // load the first identified taxon            
            $query = $em->createQuery('SELECT ei.id, ei.dateIdentification, rt.taxname as taxname, voc.libelle as codeIdentification FROM BbeesE3sBundle:EspeceIdentifiee ei JOIN ei.referentielTaxonFk rt JOIN ei.critereIdentificationVocFk voc WHERE ei.lotMaterielFk = '.$id.' ORDER BY ei.id DESC')->getResult(); 
            $lastTaxname = ($query[0]['taxname'] !== NULL) ? $query[0]['taxname'] : NULL;
            $lastdateIdentification = ($query[0]['dateIdentification']  !== NULL) ? $query[0]['dateIdentification']->format('Y-m-d') : NULL;
            $codeIdentification = ($query[0]['codeIdentification'] !== NULL) ? $query[0]['codeIdentification'] : NULL;
            //  concatenated list of people
            $query = $em->createQuery('SELECT p.nomPersonne as nom FROM BbeesE3sBundle:LotMaterielEstRealisePar lmerp JOIN lmerp.personneFk p WHERE lmerp.lotMaterielFk = '.$id.'')->getResult();            
            $arrayListePersonne = array();
            foreach($query as $taxon) {
                 $arrayListePersonne[] = $taxon['nom'];
            }
            $listePersonne= implode(", ", $arrayListePersonne);
            //
            $tab_toshow[] = array("id" => $id, "lotMateriel.id" => $id, "lotMateriel.codeLotMateriel" => $entity->getCodeLotMateriel(),
             "lotMateriel.commentaireConseilSqc" => $entity->getCommentaireConseilSqc(),"listePersonne" => $listePersonne, "collecte.codeCollecte" => $entity->getCollecteFk()->getCodeCollecte(),
             "lotMateriel.dateLotMateriel" => $DateLot ,"lotMateriel.dateCre" => $DateCre, "lotMateriel.dateMaj" => $DateMaj,
             "lastTaxname" => $lastTaxname, "lastdateIdentification" => $lastdateIdentification , "codeIdentification" => $codeIdentification ,
             "pays.nomPays" => $entity->getCollecteFk()->getStationFk()->getpaysFk()->getNomPays(),
             "lotMateriel.aFaire" => $entity->getAfaire(),   
             "commune.codeCommune" => $entity->getCollecteFk()->getStationFk()->getCommuneFk()->getCodeCommune(),
             "userCreId" => $service->GetUserCreId($entity), "lotMateriel.userCre" => $service->GetUserCreUsername($entity) ,"lotMateriel.userMaj" => $service->GetUserMajUsername($entity),
             "linkIndividu" => $linkIndividu, "linkIndividu_codestation" => "%|".$codeStation."_%",);
        }
         */  
        
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
     * Returns in json format a set of fields to display (tab_toshow) with the following criteria: 
     * a) 1 search criterion ($ request-> get ('searchPhrase')) insensitive to the case and  applied to a field
     * b) the number of lines to display ($ request-> get ('rowCount'))
     * c) 1 sort criterion on a collone ($ request-> get ('sort'))
     *
     * @Route("/indexjson", name="lotmateriel_indexjson_backup", methods={"POST"})
     */
    public function indexjsonAction_backup(Request $request)
    {
        // load services
        $service = $this->get('bbees_e3s.generic_function_e3s');       
        $em = $this->getDoctrine()->getManager();
        //
        $rowCount = ($request->get('rowCount')  !== NULL) ? $request->get('rowCount') : 10;
        $orderBy = ($request->get('sort')  !== NULL) ? $request->get('sort') : array('lotMateriel.dateMaj' => 'desc', 'lotMateriel.id' => 'desc');  
        $minRecord = intval($request->get('current')-1)*$rowCount;
        $maxRecord = $rowCount; 
        // initializes the searchPhrase variable as appropriate and sets the condition according to the url idFk parameter
        $where = 'LOWER(lotMateriel.codeLotMateriel) LIKE :criteriaLower';
        $searchPhrase = $request->get('searchPhrase');
        if ( $request->get('searchPatern') !== null && $request->get('searchPatern') !== '' && $searchPhrase == '') {
            $searchPhrase = $request->get('searchPatern');
        }
        if ( $request->get('idFk') !== null && $request->get('idFk') !== '') {
            $where .= ' AND lotMateriel.collecteFk = '.$request->get('idFk');
        }
        // Search for the list to show
        $tab_toshow =[];
        $entities_toshow = $em->getRepository("BbeesE3sBundle:LotMateriel")->createQueryBuilder('lotMateriel')
            ->where($where)
            ->setParameter('criteriaLower', strtolower($searchPhrase).'%')
            ->leftJoin('BbeesE3sBundle:Collecte', 'collecte', 'WITH', 'lotMateriel.collecteFk = collecte.id')
            ->leftJoin('BbeesE3sBundle:Station', 'station', 'WITH', 'collecte.stationFk = station.id')
            ->leftJoin('BbeesE3sBundle:Pays', 'pays', 'WITH', 'station.paysFk = pays.id')
            ->addOrderBy(array_keys($orderBy)[0], array_values($orderBy)[0])
            ->getQuery()
            ->getResult();
        $nb = count($entities_toshow);
        $entities_toshow = ($request->get('rowCount') > 0 ) ? array_slice($entities_toshow, $minRecord, $rowCount) : array_slice($entities_toshow, $minRecord);

        $lastTaxname = '';
        foreach($entities_toshow as $entity)
        {
            $id = $entity->getId();
            $codeStation = $entity->getCollecteFk()->getStationFk()->getCodeStation();
            $DateLot = ($entity->getDateLotMateriel() !== null) ?  $entity->getDateLotMateriel()->format('Y-m-d') : null;
            $DateMaj = ($entity->getDateMaj() !== null) ?  $entity->getDateMaj()->format('Y-m-d H:i:s') : null;
            $DateCre = ($entity->getDateCre() !== null) ?  $entity->getDateCre()->format('Y-m-d H:i:s') : null;
            // search for specimen associated to a material
            $query = $em->createQuery('SELECT ind.id FROM BbeesE3sBundle:Individu ind WHERE ind.lotMaterielFk = '.$id.'')->getResult();
            $linkIndividu = (count($query) > 0) ? $id : '';
            // load the first identified taxon            
            $query = $em->createQuery('SELECT ei.id, ei.dateIdentification, rt.taxname as taxname, voc.libelle as codeIdentification FROM BbeesE3sBundle:EspeceIdentifiee ei JOIN ei.referentielTaxonFk rt JOIN ei.critereIdentificationVocFk voc WHERE ei.lotMaterielFk = '.$id.' ORDER BY ei.id DESC')->getResult(); 
            $lastTaxname = ($query[0]['taxname'] !== NULL) ? $query[0]['taxname'] : NULL;
            $lastdateIdentification = ($query[0]['dateIdentification']  !== NULL) ? $query[0]['dateIdentification']->format('Y-m-d') : NULL;
            $codeIdentification = ($query[0]['codeIdentification'] !== NULL) ? $query[0]['codeIdentification'] : NULL;
            //  concatenated list of people
            $query = $em->createQuery('SELECT p.nomPersonne as nom FROM BbeesE3sBundle:LotMaterielEstRealisePar lmerp JOIN lmerp.personneFk p WHERE lmerp.lotMaterielFk = '.$id.'')->getResult();            
            $arrayListePersonne = array();
            foreach($query as $taxon) {
                 $arrayListePersonne[] = $taxon['nom'];
            }
            $listePersonne= implode(", ", $arrayListePersonne);
            //
            $tab_toshow[] = array("id" => $id, "lotMateriel.id" => $id, "lotMateriel.codeLotMateriel" => $entity->getCodeLotMateriel(),
             "lotMateriel.commentaireConseilSqc" => $entity->getCommentaireConseilSqc(),"listePersonne" => $listePersonne, "collecte.codeCollecte" => $entity->getCollecteFk()->getCodeCollecte(),
             "lotMateriel.dateLotMateriel" => $DateLot ,"lotMateriel.dateCre" => $DateCre, "lotMateriel.dateMaj" => $DateMaj,
             "lastTaxname" => $lastTaxname, "lastdateIdentification" => $lastdateIdentification , "codeIdentification" => $codeIdentification ,
             "pays.nomPays" => $entity->getCollecteFk()->getStationFk()->getpaysFk()->getNomPays(),
             "lotMateriel.aFaire" => $entity->getAfaire(),   
             "commune.codeCommune" => $entity->getCollecteFk()->getStationFk()->getCommuneFk()->getCodeCommune(),
             "userCreId" => $service->GetUserCreId($entity), "lotMateriel.userCre" => $service->GetUserCreUsername($entity) ,"lotMateriel.userMaj" => $service->GetUserMajUsername($entity),
             "linkIndividu" => $linkIndividu, "linkIndividu_codestation" => "%|".$codeStation."_%",);
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
     * Creates a new lotMateriel entity.
     *
     * @Route("/new", name="lotmateriel_new", methods={"GET", "POST"})
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function newAction(Request $request)
    {
        $lotMateriel = new Lotmateriel();
        $em = $this->getDoctrine()->getManager();
        // check if the relational Entity (Collecte) is given and set the RelationalEntityFk for the new Entity
        if ($request->get('idFk') !== null && $request->get('idFk') !== '') {
            $RelEntityId = $request->get('idFk');
            $RelEntity = $em->getRepository('BbeesE3sBundle:Collecte')->find($RelEntityId);
            $lotMateriel->setCollecteFk($RelEntity);
        }        
        $form = $this->createForm('Bbees\E3sBundle\Form\LotMaterielType', $lotMateriel);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // (i) load the id  the relational Entity (Collecte) from typeahead input field and (ii) set the foreign key 
            $RelEntityId = $form->get('collecteId');
            $RelEntity = $em->getRepository('BbeesE3sBundle:Collecte')->find($RelEntityId->getData());
            $lotMateriel->setCollecteFk($RelEntity);
            // persist
            $em->persist($lotMateriel);
            try {
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('lotmateriel/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->redirectToRoute('lotmateriel_edit', array('id' => $lotMateriel->getId(), 'valid' => 1, 'idFk' => $request->get('idFk') ));                       
        }

        return $this->render('lotmateriel/edit.html.twig', array(
            'lotMateriel' => $lotMateriel,
            'edit_form' => $form->createView(),
        ));
    }

    /**
     * Finds and displays a lotMateriel entity.
     *
     * @Route("/{id}", name="lotmateriel_show", methods={"GET"})
     */
    public function showAction(LotMateriel $lotMateriel)
    {
        $deleteForm = $this->createDeleteForm($lotMateriel);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\LotMaterielType', $lotMateriel);

        return $this->render('lotmateriel/edit.html.twig', array(
            'lotMateriel' => $lotMateriel,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));

    }

    /**
     * Displays a form to edit an existing lotMateriel entity.
     *
     * @Route("/{id}/edit", name="lotmateriel_edit", methods={"GET", "POST"})
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function editAction(Request $request, LotMateriel $lotMateriel)
    {
        //  access control for user type  : ROLE_COLLABORATION
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $user = $this->getUser();
        if ($user->getRole() ==  'ROLE_COLLABORATION' && $lotMateriel->getUserCre() != $user->getId() ) {
                $this->denyAccessUnlessGranted('ROLE_ADMIN', null, 'ACCESS DENIED');
        }
        // load service  generic_function_e3s
        $service = $this->get('bbees_e3s.generic_function_e3s');
        
        // store ArrayCollection       
        $compositionLotMateriels = $service->setArrayCollection('CompositionLotMateriels',$lotMateriel);
        $especeIdentifiees = $service->setArrayCollectionEmbed('EspeceIdentifiees','EstIdentifiePars',$lotMateriel);
        $lotEstPublieDanss = $service->setArrayCollection('LotEstPublieDanss',$lotMateriel);
        $lotMaterielEstRealisePars = $service->setArrayCollection('LotMaterielEstRealisePars',$lotMateriel);
        
        // 
        $deleteForm = $this->createDeleteForm($lotMateriel);
        $editForm = $this->createForm('Bbees\E3sBundle\Form\LotMaterielType', $lotMateriel);
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            // delete ArrayCollection
            $service->DelArrayCollection('CompositionLotMateriels',$lotMateriel, $compositionLotMateriels);
            $service->DelArrayCollectionEmbed('EspeceIdentifiees','EstIdentifiePars',$lotMateriel, $especeIdentifiees);
            $service->DelArrayCollection('LotEstPublieDanss',$lotMateriel, $lotEstPublieDanss);
            $service->DelArrayCollection('LotMaterielEstRealisePars',$lotMateriel, $lotMaterielEstRealisePars);
            // (i) load the id of relational Entity (Collecte) from typeahead input field  (ii) set the foreign key
            $em = $this->getDoctrine()->getManager();
            $RelEntityId = $editForm->get('collecteId');;
            $RelEntity = $em->getRepository('BbeesE3sBundle:Collecte')->find($RelEntityId->getData());
            $lotMateriel->setCollecteFk($RelEntity);
            // flush
            $this->getDoctrine()->getManager()->persist($lotMateriel);                       
            try {
                $this->getDoctrine()->getManager()->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('lotmateriel/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            } 
            return $this->render('lotmateriel/edit.html.twig', array(
                'lotMateriel' => $lotMateriel,
                'edit_form' => $editForm->createView(),
                'valid' => 1));
        }
        
        return $this->render('lotmateriel/edit.html.twig', array(
            'lotMateriel' => $lotMateriel,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Deletes a lotMateriel entity.
     *
     * @Route("/{id}", name="lotmateriel_delete", methods={"DELETE"})
     * @Security("has_role('ROLE_COLLABORATION')")
     */
    public function deleteAction(Request $request, LotMateriel $lotMateriel)
    {
        $form = $this->createDeleteForm($lotMateriel);
        $form->handleRequest($request);

        $submittedToken = $request->request->get('token');
        if (($form->isSubmitted() && $form->isValid()) || $this->isCsrfTokenValid('delete-item', $submittedToken) ) {
            $em = $this->getDoctrine()->getManager();
            try {
                $em->remove($lotMateriel);
                $em->flush();
            } 
            catch(\Doctrine\DBAL\DBALException $e) {
                $exception_message =  str_replace('"', '\"',str_replace("'", "\'", html_entity_decode(strval($e), ENT_QUOTES , 'UTF-8')));
                return $this->render('lotmateriel/index.html.twig', array('exception_message' =>  explode("\n", $exception_message)[0]));
            }   
        }
        
        return $this->redirectToRoute('lotmateriel_index');
    }

    /**
     * Creates a form to delete a lotMateriel entity.
     *
     * @param LotMateriel $lotMateriel The lotMateriel entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(LotMateriel $lotMateriel)
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('lotmateriel_delete', array('id' => $lotMateriel->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
