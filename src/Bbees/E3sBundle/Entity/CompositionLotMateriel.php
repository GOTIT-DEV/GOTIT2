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

namespace Bbees\E3sBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * CompositionLotMateriel
 *
 * @ORM\Table(name="composition_lot_materiel", indexes={@ORM\Index(name="IDX_10A697444236D33E", columns={"type_individu_voc_fk"}), @ORM\Index(name="IDX_10A6974454DBBD4D", columns={"lot_materiel_fk"})})
 * @ORM\Entity
 * @author Philippe Grison  <philippe.grison@mnhn.fr>
 */
class CompositionLotMateriel
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="bigint", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     * @ORM\SequenceGenerator(sequenceName="composition_lot_materiel_id_seq", allocationSize=1, initialValue=1)
     */
    private $id;

    /**
     * @var integer
     *
     * @ORM\Column(name="nb_individus", type="bigint", nullable=true)
     */
    private $nbIndividus;

    /**
     * @var string
     *
     * @ORM\Column(name="commentaire_compo_lot_materiel", type="text", nullable=true)
     */
    private $commentaireCompoLotMateriel;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date_cre", type="datetime", nullable=true)
     */
    private $dateCre;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date_maj", type="datetime", nullable=true)
     */
    private $dateMaj;

    /**
     * @var integer
     *
     * @ORM\Column(name="user_cre", type="bigint", nullable=true)
     */
    private $userCre;

    /**
     * @var integer
     *
     * @ORM\Column(name="user_maj", type="bigint", nullable=true)
     */
    private $userMaj;

    /**
     * @var \Voc
     *
     * @ORM\ManyToOne(targetEntity="Voc")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="type_individu_voc_fk", referencedColumnName="id", nullable=false)
     * })
     */
    private $typeIndividuVocFk;

    /**
     * @var \LotMateriel
     *
     * @ORM\ManyToOne(targetEntity="LotMateriel", inversedBy="compositionLotMateriels")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="lot_materiel_fk", referencedColumnName="id", nullable=false, onDelete="CASCADE")
     * })
     */
    private $lotMaterielFk;



    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set nbIndividus
     *
     * @param integer $nbIndividus
     *
     * @return CompositionLotMateriel
     */
    public function setNbIndividus($nbIndividus)
    {
        $this->nbIndividus = $nbIndividus;

        return $this;
    }

    /**
     * Get nbIndividus
     *
     * @return integer
     */
    public function getNbIndividus()
    {
        return $this->nbIndividus;
    }

    /**
     * Set commentaireCompoLotMateriel
     *
     * @param string $commentaireCompoLotMateriel
     *
     * @return CompositionLotMateriel
     */
    public function setCommentaireCompoLotMateriel($commentaireCompoLotMateriel)
    {
        $this->commentaireCompoLotMateriel = $commentaireCompoLotMateriel;

        return $this;
    }

    /**
     * Get commentaireCompoLotMateriel
     *
     * @return string
     */
    public function getCommentaireCompoLotMateriel()
    {
        return $this->commentaireCompoLotMateriel;
    }

    /**
     * Set dateCre
     *
     * @param \DateTime $dateCre
     *
     * @return CompositionLotMateriel
     */
    public function setDateCre($dateCre)
    {
        $this->dateCre = $dateCre;

        return $this;
    }

    /**
     * Get dateCre
     *
     * @return \DateTime
     */
    public function getDateCre()
    {
        return $this->dateCre;
    }

    /**
     * Set dateMaj
     *
     * @param \DateTime $dateMaj
     *
     * @return CompositionLotMateriel
     */
    public function setDateMaj($dateMaj)
    {
        $this->dateMaj = $dateMaj;

        return $this;
    }

    /**
     * Get dateMaj
     *
     * @return \DateTime
     */
    public function getDateMaj()
    {
        return $this->dateMaj;
    }

    /**
     * Set userCre
     *
     * @param integer $userCre
     *
     * @return CompositionLotMateriel
     */
    public function setUserCre($userCre)
    {
        $this->userCre = $userCre;

        return $this;
    }

    /**
     * Get userCre
     *
     * @return integer
     */
    public function getUserCre()
    {
        return $this->userCre;
    }

    /**
     * Set userMaj
     *
     * @param integer $userMaj
     *
     * @return CompositionLotMateriel
     */
    public function setUserMaj($userMaj)
    {
        $this->userMaj = $userMaj;

        return $this;
    }

    /**
     * Get userMaj
     *
     * @return integer
     */
    public function getUserMaj()
    {
        return $this->userMaj;
    }

    /**
     * Set typeIndividuVocFk
     *
     * @param \Bbees\E3sBundle\Entity\Voc $typeIndividuVocFk
     *
     * @return CompositionLotMateriel
     */
    public function setTypeIndividuVocFk(\Bbees\E3sBundle\Entity\Voc $typeIndividuVocFk = null)
    {
        $this->typeIndividuVocFk = $typeIndividuVocFk;

        return $this;
    }

    /**
     * Get typeIndividuVocFk
     *
     * @return \Bbees\E3sBundle\Entity\Voc
     */
    public function getTypeIndividuVocFk()
    {
        return $this->typeIndividuVocFk;
    }

    /**
     * Set lotMaterielFk
     *
     * @param \Bbees\E3sBundle\Entity\LotMateriel $lotMaterielFk
     *
     * @return CompositionLotMateriel
     */
    public function setLotMaterielFk(\Bbees\E3sBundle\Entity\LotMateriel $lotMaterielFk = null)
    {
        $this->lotMaterielFk = $lotMaterielFk;

        return $this;
    }

    /**
     * Get lotMaterielFk
     *
     * @return \Bbees\E3sBundle\Entity\LotMateriel
     */
    public function getLotMaterielFk()
    {
        return $this->lotMaterielFk;
    }
}
