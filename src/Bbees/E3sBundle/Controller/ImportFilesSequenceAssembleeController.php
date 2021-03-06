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

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Bbees\E3sBundle\Services\ImportFileCsv;
use Symfony\Component\Translation\TranslatorInterface; 
use Bbees\E3sBundle\Services\ImportFileE3s; 
use Symfony\Component\HttpKernel\KernelInterface;

/**
* ImportIndividu controller.
*
* @Route("importfilessequenceassemblee")
* @Security("has_role('ROLE_COLLABORATION')")
* @author Philippe Grison  <philippe.grison@mnhn.fr>
*/
class ImportFilesSequenceAssembleeController extends AbstractController
{
     /**
     * @var string
     */
    private $type_csv;
     
    /**
     * @Route("/", name="importfilessequenceassemblee_index")
     *    
     */
     public function indexAction(Request $request, ImportFileE3s $importFileE3sService, TranslatorInterface $translator, ImportFileCsv $service, KernelInterface $kernel)
    {   
        $message = ""; 
        //create form
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $user = $this->getUser();
        if($user->getRole() == 'ROLE_ADMIN') {
        $form = $this->createFormBuilder()
                ->setMethod('POST')
                ->add('type_csv', ChoiceType::class, array(
                    'choice_translation_domain' => false,
                    'choices'  => array(
                         ' ' => array('Internal_sequence' => 'internal_sequence'),
                         '  ' => array('Source' => 'source',),
                         '   ' => array('Vocabulary' => 'vocabulary', 'Person' => 'person', 'Taxon' => 'taxon',),)
                    ))
                ->add('fichier', FileType::class)
                // ->add('fichier','file')
                ->add('envoyer', SubmitType::class, array('label' => 'Envoyer'))
                //->add('envoyer','submit')
                ->getForm();        
        }
        if($user->getRole() == 'ROLE_PROJECT') {
        $form = $this->createFormBuilder()
                ->setMethod('POST')
                ->add('type_csv', ChoiceType::class, array(
                    'choice_translation_domain' => false,
                    'choices'  => array(
                         ' ' => array('Internal_sequence' => 'internal_sequence'),
                         '  ' => array('Source' => 'source',),
                         '   ' => array('Person' => 'person',),)
                    ))
                ->add('fichier', FileType::class)
                // ->add('fichier','file')
                ->add('envoyer', SubmitType::class, array('label' => 'Envoyer'))
                //->add('envoyer','submit')
                ->getForm();         
        } 
        if($user->getRole() == 'ROLE_COLLABORATION') {
        $form = $this->createFormBuilder()
                ->setMethod('POST')
                ->add('type_csv', ChoiceType::class, array(
                    'choice_translation_domain' => false,
                    'choices'  => array(
                         ' ' => array('Internal_sequence' => 'internal_sequence'),
                         '  ' => array('Person' => 'person',),)
                    ))
                ->add('fichier', FileType::class)
                // ->add('fichier','file')
                ->add('envoyer', SubmitType::class, array('label' => 'Envoyer'))
                //->add('envoyer','submit')
                ->getForm();       
        }
        $form->handleRequest($request);
        
        if ($form->isSubmitted()){ //processing form request 
            $fichier = $form->get('fichier')->getData()->getRealPath(); // path to the tmp file created
            $this->type_csv = $form->get('type_csv')->getData();
            $nom_fichier_download = $form->get('fichier')->getData()->getClientOriginalName();
            $message = "Import : ".$nom_fichier_download." ( Template ".$this->type_csv.".csv )<br />";
            // test if the file imported match the good columns name of the template file
            $pathToTemplate = $kernel->getRootDir(). '/../web/template/'.$this->type_csv.'.csv';
            // 
            $checkName = $translator->trans($service->checkNameCSVfile2Template($pathToTemplate , $fichier));
            $message .= $checkName;
            if($checkName  == ''){
                switch ($this->type_csv) {
                    case 'internal_sequence':
                        $message .= $importFileE3sService->importCSVDataSequenceAssemblee($fichier, $user->getId());
                        break;
                    case 'source':
                        $message .= $importFileE3sService->importCSVDataSource($fichier, $user->getId());
                        break;
                    case 'vocabulary':
                        $message .= $importFileE3sService->importCSVDataVoc($fichier, $user->getId());
                        break;
                    case 'taxon' :
                        $message .= $importFileE3sService->importCSVDataReferentielTaxon($fichier, $user->getId());
                        break;
                    case 'person' :
                        $message .= $importFileE3sService->importCSVDataPersonne($fichier, $user->getId());
                        break;
                    default:
                       $message .= "ERROR - Bad SELECTED choice ?";
                }
            }
            return $this->render('importfilecsv/importfiles.html.twig', array("message" => $message, 'form' => $form->createView())); 
        }
        return $this->render('importfilecsv/importfiles.html.twig', array("message" => $message,'form' => $form->createView()));
     }    
}
