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
 * ReferentielTaxon
 *
 * @ORM\Table(name="referentiel_taxon", uniqueConstraints={ @ORM\UniqueConstraint(name="cu_referentiel_taxon_cle_primaire", columns={"taxname"}), @ORM\UniqueConstraint(name="cu_referentiel_taxon_code_taxon", columns={"code_taxon"}) } )
 * @ORM\Entity
 * @author Philippe Grison  <philippe.grison@mnhn.fr>
 */
class ReferentielTaxon
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="bigint", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     * @ORM\SequenceGenerator(sequenceName="referentiel_taxon_id_seq", allocationSize=1, initialValue=1)
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="taxname", type="string", length=255, nullable=false)
     */
    private $taxname;

    /**
     * @var string
     *
     * @ORM\Column(name="rank", type="string", length=255, nullable=false)
     */
    private $rank;

    /**
     * @var string
     *
     * @ORM\Column(name="subclass", type="string", length=255, nullable=true)
     */
    private $subclass;

    /**
     * @var string
     *
     * @ORM\Column(name="ordre", type="string", length=255, nullable=true)
     */
    private $ordre;

    /**
     * @var string
     *
     * @ORM\Column(name="family", type="string", length=255, nullable=true)
     */
    private $family;

    /**
     * @var string
     *
     * @ORM\Column(name="genus", type="string", length=255, nullable=true)
     */
    private $genus;

    /**
     * @var string
     *
     * @ORM\Column(name="species", type="string", length=255, nullable=true)
     */
    private $species;

    /**
     * @var string
     *
     * @ORM\Column(name="subspecies", type="string", length=255, nullable=true)
     */
    private $subspecies;

    /**
     * @var integer
     *
     * @ORM\Column(name="validity", type="smallint", nullable=false)
     */
    private $validity;

    /**
     * @var string
     *
     * @ORM\Column(name="code_taxon", type="string", length=255, nullable=false)
     */
    private $codeTaxon;

    /**
     * @var string
     *
     * @ORM\Column(name="commentaire_ref", type="text", nullable=true)
     */
    private $commentaireRef;

    /**
     * @var string
     *
     * @ORM\Column(name="clade", type="string", length=255, nullable=true)
     */
    private $clade;

    /**
     * @var string
     *
     * @ORM\Column(name="taxname_ref", type="string", length=255, nullable=true)
     */
    private $taxnameRef;

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
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set taxname
     *
     * @param string $taxname
     *
     * @return ReferentielTaxon
     */
    public function setTaxname($taxname)
    {
        $this->taxname = $taxname;

        return $this;
    }

    /**
     * Get taxname
     *
     * @return string
     */
    public function getTaxname()
    {
        return $this->taxname;
    }

    /**
     * Set rank
     *
     * @param string $rank
     *
     * @return ReferentielTaxon
     */
    public function setRank($rank)
    {
        $this->rank = $rank;

        return $this;
    }

    /**
     * Get rank
     *
     * @return string
     */
    public function getRank()
    {
        return $this->rank;
    }

    /**
     * Set subclass
     *
     * @param string $subclass
     *
     * @return ReferentielTaxon
     */
    public function setSubclass($subclass)
    {
        $this->subclass = $subclass;

        return $this;
    }

    /**
     * Get subclass
     *
     * @return string
     */
    public function getSubclass()
    {
        return $this->subclass;
    }

    /**
     * Set ordre
     *
     * @param string $ordre
     *
     * @return ReferentielTaxon
     */
    public function setOrdre($ordre)
    {
        $this->ordre = $ordre;

        return $this;
    }

    /**
     * Get ordre
     *
     * @return string
     */
    public function getOrdre()
    {
        return $this->ordre;
    }

    /**
     * Set family
     *
     * @param string $family
     *
     * @return ReferentielTaxon
     */
    public function setFamily($family)
    {
        $this->family = $family;

        return $this;
    }

    /**
     * Get family
     *
     * @return string
     */
    public function getFamily()
    {
        return $this->family;
    }

    /**
     * Set genus
     *
     * @param string $genus
     *
     * @return ReferentielTaxon
     */
    public function setGenus($genus)
    {
        $this->genus = $genus;

        return $this;
    }

    /**
     * Get genus
     *
     * @return string
     */
    public function getGenus()
    {
        return $this->genus;
    }

    /**
     * Set species
     *
     * @param string $species
     *
     * @return ReferentielTaxon
     */
    public function setSpecies($species)
    {
        $this->species = $species;

        return $this;
    }

    /**
     * Get species
     *
     * @return string
     */
    public function getSpecies()
    {
        return $this->species;
    }

    /**
     * Set subspecies
     *
     * @param string $subspecies
     *
     * @return ReferentielTaxon
     */
    public function setSubspecies($subspecies)
    {
        $this->subspecies = $subspecies;

        return $this;
    }

    /**
     * Get subspecies
     *
     * @return string
     */
    public function getSubspecies()
    {
        return $this->subspecies;
    }

    /**
     * Set validity
     *
     * @param integer $validity
     *
     * @return ReferentielTaxon
     */
    public function setValidity($validity)
    {
        $this->validity = $validity;

        return $this;
    }

    /**
     * Get validity
     *
     * @return integer
     */
    public function getValidity()
    {
        return $this->validity;
    }

    /**
     * Set codeTaxon
     *
     * @param string $codeTaxon
     *
     * @return ReferentielTaxon
     */
    public function setCodeTaxon($codeTaxon)
    {
        $this->codeTaxon = $codeTaxon;

        return $this;
    }

    /**
     * Get codeTaxon
     *
     * @return string
     */
    public function getCodeTaxon()
    {
        return $this->codeTaxon;
    }

    /**
     * Set commentaireRef
     *
     * @param string $commentaireRef
     *
     * @return ReferentielTaxon
     */
    public function setCommentaireRef($commentaireRef)
    {
        $this->commentaireRef = $commentaireRef;

        return $this;
    }

    /**
     * Get commentaireRef
     *
     * @return string
     */
    public function getCommentaireRef()
    {
        return $this->commentaireRef;
    }

    /**
     * Set clade
     *
     * @param string $clade
     *
     * @return ReferentielTaxon
     */
    public function setClade($clade)
    {
        $this->clade = $clade;

        return $this;
    }

    /**
     * Get clade
     *
     * @return string
     */
    public function getClade()
    {
        return $this->clade;
    }

    /**
     * Set taxnameRef
     *
     * @param string $taxnameRef
     *
     * @return ReferentielTaxon
     */
    public function setTaxnameRef($taxnameRef)
    {
        $this->taxnameRef = $taxnameRef;

        return $this;
    }

    /**
     * Get taxnameRef
     *
     * @return string
     */
    public function getTaxnameRef()
    {
        return $this->taxnameRef;
    }

    /**
     * Set dateCre
     *
     * @param \DateTime $dateCre
     *
     * @return ReferentielTaxon
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
     * @return ReferentielTaxon
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
     * @return ReferentielTaxon
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
     * @return ReferentielTaxon
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
}
