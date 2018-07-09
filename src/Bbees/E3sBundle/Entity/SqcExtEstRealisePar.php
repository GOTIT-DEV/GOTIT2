<?php

namespace Bbees\E3sBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SqcExtEstRealisePar
 *
 * @ORM\Table(name="sqc_ext_est_realise_par", indexes={@ORM\Index(name="IDX_DC41E25ACDD1F756", columns={"sequence_assemblee_ext_fk"}), @ORM\Index(name="IDX_DC41E25AB53CD04C", columns={"personne_fk"})})
 * @ORM\Entity
 */
class SqcExtEstRealisePar
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="bigint", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="sqc_ext_est_realise_par_id_seq", allocationSize=1, initialValue=1)
     */
    private $id;

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
     * @var \SequenceAssembleeExt
     *
     * @ORM\ManyToOne(targetEntity="SequenceAssembleeExt", inversedBy="sqcExtEstRealisePars")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="sequence_assemblee_ext_fk", referencedColumnName="id")
     * })
     */
    private $sequenceAssembleeExtFk;

    /**
     * @var \Personne
     *
     * @ORM\ManyToOne(targetEntity="Personne")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="personne_fk", referencedColumnName="id")
     * })
     */
    private $personneFk;



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
     * Set dateCre
     *
     * @param \DateTime $dateCre
     *
     * @return SqcExtEstRealisePar
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
     * @return SqcExtEstRealisePar
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
     * @return SqcExtEstRealisePar
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
     * @return SqcExtEstRealisePar
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
     * Set sequenceAssembleeExtFk
     *
     * @param \Bbees\E3sBundle\Entity\SequenceAssembleeExt $sequenceAssembleeExtFk
     *
     * @return SqcExtEstRealisePar
     */
    public function setSequenceAssembleeExtFk(\Bbees\E3sBundle\Entity\SequenceAssembleeExt $sequenceAssembleeExtFk = null)
    {
        $this->sequenceAssembleeExtFk = $sequenceAssembleeExtFk;

        return $this;
    }

    /**
     * Get sequenceAssembleeExtFk
     *
     * @return \Bbees\E3sBundle\Entity\SequenceAssembleeExt
     */
    public function getSequenceAssembleeExtFk()
    {
        return $this->sequenceAssembleeExtFk;
    }

    /**
     * Set personneFk
     *
     * @param \Bbees\E3sBundle\Entity\Personne $personneFk
     *
     * @return SqcExtEstRealisePar
     */
    public function setPersonneFk(\Bbees\E3sBundle\Entity\Personne $personneFk = null)
    {
        $this->personneFk = $personneFk;

        return $this;
    }

    /**
     * Get personneFk
     *
     * @return \Bbees\E3sBundle\Entity\Personne
     */
    public function getPersonneFk()
    {
        return $this->personneFk;
    }
}