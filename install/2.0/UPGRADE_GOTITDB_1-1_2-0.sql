ALTER TABLE lot_materiel_ext RENAME COLUMN collecte_fk TO sampling_fk ; ALTER TABLE sequence_assemblee_ext RENAME COLUMN collecte_fk TO sampling_fk ; ALTER TABLE lot_materiel RENAME COLUMN collecte_fk TO sampling_fk ;
ALTER TABLE a_cibler RENAME COLUMN collecte_fk TO sampling_fk ;
ALTER TABLE a_pour_sampling_method RENAME COLUMN collecte_fk TO sampling_fk ; ALTER TABLE a_pour_fixateur RENAME COLUMN collecte_fk TO sampling_fk ;
ALTER TABLE est_finance_par RENAME COLUMN collecte_fk TO sampling_fk ; ALTER TABLE est_effectue_par RENAME COLUMN collecte_fk TO sampling_fk ;

ALTER TABLE a_cibler RENAME COLUMN referentiel_taxon_fk TO taxon_fk ;
ALTER TABLE espece_identifiee RENAME COLUMN referentiel_taxon_fk TO taxon_fk ;

ALTER TABLE boite RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE boite RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE chromatogramme RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE chromatogramme RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE composition_lot_materiel RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE composition_lot_materiel RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE adn RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE adn RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE lot_materiel_ext RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE lot_materiel_ext RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE sequence_assemblee_ext RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE lot_materiel RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE lot_materiel RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE sequence_assemblee RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE sequence_assemblee RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE motu RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE motu RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE pcr RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE pcr RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE collecte RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE collecte RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE station RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE station RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE source RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE source RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE individu RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE individu RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE individu_lame RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE individu_lame RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE est_aligne_et_traite RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE est_aligne_et_traite RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE adn_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE adn_est_realise_par RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE lot_materiel_ext_est_reference_dans RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE lot_materiel_ext_est_reference_dans RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE sqc_ext_est_reference_dans RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE sqc_ext_est_reference_dans RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE a_cibler RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE a_cibler RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE espece_identifiee RENAME COLUMN date_cre TO date_of_creation ;

ALTER TABLE espece_identifiee RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE lot_est_publie_dans RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE lot_est_publie_dans RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE sqc_est_publie_dans RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE sqc_est_publie_dans RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE a_pour_sampling_method RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE a_pour_sampling_method RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE source_a_ete_integre_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE source_a_ete_integre_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE a_pour_fixateur RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE a_pour_fixateur RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE est_finance_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE est_finance_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE motu_est_genere_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE motu_est_genere_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE est_identifie_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE est_identifie_par RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE individu_lame_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE individu_lame_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE est_effectue_par RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE est_effectue_par RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE assigne RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE assigne RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE pcr_est_realise_par RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE pcr_est_realise_par RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE pays RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE pays RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE etablissement RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE etablissement RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE commune RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE commune RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE personne RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE personne RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE programme RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE programme RENAME COLUMN date_maj TO date_of_update ;
ALTER TABLE referentiel_taxon RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE referentiel_taxon RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE voc RENAME COLUMN date_cre TO date_of_creation ;
ALTER TABLE voc RENAME COLUMN date_maj TO date_of_update ; ALTER TABLE user_db RENAME COLUMN date_cre TO date_of_creation ; ALTER TABLE user_db RENAME COLUMN date_maj TO date_of_update ;

ALTER TABLE boite RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE boite RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE chromatogramme RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE chromatogramme RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE composition_lot_materiel RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE composition_lot_materiel RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE adn RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE adn RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE lot_materiel_ext RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE lot_materiel_ext RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN user_cre TO creation_user_name ;

ALTER TABLE sequence_assemblee_ext RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE lot_materiel RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE lot_materiel RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE sequence_assemblee RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE sequence_assemblee RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE motu RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE motu RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE pcr RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE pcr RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE collecte RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE collecte RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE station RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE station RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE source RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE source RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE individu RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE individu RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE individu_lame RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE individu_lame RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE est_aligne_et_traite RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE est_aligne_et_traite RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE adn_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE adn_est_realise_par RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE lot_materiel_ext_est_reference_dans RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE lot_materiel_ext_est_reference_dans RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE sqc_ext_est_reference_dans RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE sqc_ext_est_reference_dans RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE a_cibler RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE a_cibler RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE espece_identifiee RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE espece_identifiee RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE lot_est_publie_dans RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE lot_est_publie_dans RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE sqc_est_publie_dans RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE sqc_est_publie_dans RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE a_pour_sampling_method RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE a_pour_sampling_method RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE source_a_ete_integre_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE source_a_ete_integre_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE a_pour_fixateur RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE a_pour_fixateur RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE est_finance_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE est_finance_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE motu_est_genere_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE motu_est_genere_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE est_identifie_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE est_identifie_par RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE individu_lame_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE individu_lame_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE est_effectue_par RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE est_effectue_par RENAME COLUMN user_maj TO update_user_name ;

ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE assigne RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE assigne RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE pcr_est_realise_par RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE pcr_est_realise_par RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE pays RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE pays RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE etablissement RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE etablissement RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE commune RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE commune RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE personne RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE personne RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE programme RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE programme RENAME COLUMN user_maj TO update_user_name ;
ALTER TABLE referentiel_taxon RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE referentiel_taxon RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE voc RENAME COLUMN user_cre TO creation_user_name ;
ALTER TABLE voc RENAME COLUMN user_maj TO update_user_name ; ALTER TABLE user_db RENAME COLUMN user_cre TO creation_user_name ; ALTER TABLE user_db RENAME COLUMN user_maj TO update_user_name ;

ALTER TABLE a_cibler RENAME TO has_targeted_taxa;
ALTER SEQUENCE a_cibler_id_seq RENAME TO has_targeted_taxa_id_seq;
ALTER TABLE a_pour_fixateur RENAME COLUMN fixateur_voc_fk TO fixative_voc_fk ;

ALTER TABLE a_pour_fixateur RENAME TO sample_is_fixed_with ;
ALTER SEQUENCE a_pour_fixateur_id_seq RENAME TO sample_is_fixed_with_id_seq ;

ALTER TABLE a_pour_sampling_method RENAME TO sampling_is_done_with_method ;
ALTER SEQUENCE a_pour_sampling_method_id_seq RENAME TO sampling_is_done_with_method_id_seq ;

ALTER TABLE adn RENAME COLUMN code_adn TO dna_code ;
ALTER TABLE adn RENAME COLUMN date_adn TO dna_extraction_date ;
ALTER TABLE adn RENAME COLUMN concentration_ng_microlitre TO dna_concentration ; ALTER TABLE adn RENAME COLUMN commentaire_adn TO dna_comments ;
ALTER TABLE adn RENAME COLUMN methode_extraction_adn_voc_fk TO dna_extraction_method_voc_fk ; ALTER TABLE adn RENAME COLUMN individu_fk TO specimen_fk ;
ALTER TABLE adn RENAME COLUMN qualite_adn_voc_fk TO dna_quality_voc_fk ; ALTER TABLE adn RENAME COLUMN boite_fk TO storage_box_fk ;

ALTER TABLE lot_materiel RENAME COLUMN boite_fk TO storage_box_fk ; ALTER TABLE individu_lame RENAME COLUMN boite_fk TO storage_box_fk ; ALTER TABLE individu_lame RENAME COLUMN individu_fk TO specimen_fk ; ALTER TABLE espece_identifiee RENAME COLUMN individu_fk TO specimen_fk ;

ALTER TABLE adn RENAME TO dna ;
ALTER SEQUENCE adn_id_seq RENAME TO dna_id_seq ;

# Internationalisatio n de la table adn_est_realise_par

# modification des noms de colonnes de la table adn ; adn_fk , personne_fk ALTER TABLE adn_est_realise_par RENAME COLUMN adn_fk TO dna_fk ;
ALTER TABLE adn_est_realise_par RENAME COLUMN personne_fk TO person_fk ;

# modification des noms de colonnes ( adn_fk , personne_fk )à de autres tables de la bdd ALTER TABLE pcr RENAME COLUMN adn_fk TO dna_fk ;
ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN personne_fk TO person_fk ; ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN personne_fk TO person_fk ;
ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN personne_fk TO person_fk ; ALTER TABLE source_a_ete_integre_par RENAME COLUMN personne_fk TO person_fk ;
ALTER TABLE motu_est_genere_par RENAME COLUMN personne_fk TO person_fk ; ALTER TABLE est_identifie_par RENAME COLUMN personne_fk TO person_fk ;
ALTER TABLE individu_lame_est_realise_par RENAME COLUMN personne_fk TO person_fk ; ALTER TABLE est_effectue_par RENAME COLUMN personne_fk TO person_fk ;
ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN personne_fk TO person_fk ; ALTER TABLE pcr_est_realise_par RENAME COLUMN personne_fk TO person_fk ;

# modification du nom de la table adn et de la sequence de l'id auto ALTER TABLE adn_est_realise_par RENAME TO dna_is_extracted_by ;
ALTER SEQUENCE adn_est_realise_par_id_seq RENAME TO dna_is_extracted_by_id_seq ;

-- Internationalisation de la table assigne

-- modification des noms de colonnes de la table adn ; num_motu, sequence_assemblee_ext_fk, methode_motu_voc_fk, sequence_assemblee_fk, motu_fk
ALTER TABLE assigne RENAME COLUMN num_motu TO motu_number ;
ALTER TABLE assigne RENAME COLUMN sequence_assemblee_ext_fk TO external_sequence_fk ; ALTER TABLE assigne RENAME COLUMN methode_motu_voc_fk TO delimitation_method_voc_fk ; ALTER TABLE assigne RENAME COLUMN sequence_assemblee_fk TO internal_sequence_fk ;

-- modification des noms de colonnes ( num_motu, sequence_assemblee_ext_fk, methode_motu_voc_fk, sequence_assemblee_fk, motu_fk )à de autres tables de la bdd
ALTER TABLE est_aligne_et_traite RENAME COLUMN sequence_assemblee_fk TO internal_sequence_fk ; ALTER TABLE sqc_ext_est_realise_par RENAME COLUMN sequence_assemblee_ext_fk TO external_sequence_fk ;
ALTER TABLE sqc_ext_est_reference_dans RENAME COLUMN sequence_assemblee_ext_fk TO external_sequence_fk ;
ALTER TABLE espece_identifiee RENAME COLUMN sequence_assemblee_ext_fk TO external_sequence_fk ; ALTER TABLE espece_identifiee RENAME COLUMN sequence_assemblee_fk TO internal_sequence_fk ; ALTER TABLE sqc_est_publie_dans RENAME COLUMN sequence_assemblee_fk TO internal_sequence_fk ; ALTER TABLE sequence_assemblee_est_realise_par RENAME COLUMN sequence_assemblee_fk TO internal_sequence_fk ;


-- modification du nom de la table adn et de la sequence de l'id auto ALTER TABLE assigne RENAME TO motu_number ;
ALTER SEQUENCE assigne_id_seq RENAME TO motu_number_id_seq ;

-- Internationalisation de la table boite

-- modification des noms de colonnes de la table ; code_boite,libelle_boite, commentaire_boite, type_collection_voc_fk, code_collection_voc_fk, type_boite_voc_fk
ALTER TABLE boite RENAME COLUMN code_boite TO box_code ; ALTER TABLE boite RENAME COLUMN libelle_boite TO box_title ;
ALTER TABLE boite RENAME COLUMN commentaire_boite TO box_comments ;
ALTER TABLE boite RENAME COLUMN type_collection_voc_fk TO collection_type_voc_fk ; ALTER TABLE boite RENAME COLUMN code_collection_voc_fk TO collection_code_voc_fk ; ALTER TABLE boite RENAME COLUMN type_boite_voc_fk TO box_type_voc_fk ;

-- modification des noms de colonnes (  ) dans les autres tables de la bdd


-- modification du nom de la table adn et de la sequence de l'id auto ALTER TABLE boite RENAME TO storage_box ;
ALTER SEQUENCE boite_id_seq RENAME TO storage_box_id_seq ;

-- Internationalisation de la table chromatogramme

-- modification des noms de colonnes; code_chromato, num_yas, commentaire_chromato, primer_chromato_voc_fk, qualite_chromato_voc_fk, etablissement_fk
ALTER TABLE chromatogramme RENAME COLUMN code_chromato TO chromatogram_code ; ALTER TABLE chromatogramme RENAME COLUMN num_yas TO chromatogram_number ;
ALTER TABLE chromatogramme RENAME COLUMN commentaire_chromato TO chromatogram_comments ; ALTER TABLE chromatogramme RENAME COLUMN primer_chromato_voc_fk TO chromato_primer_voc_fk ; ALTER TABLE chromatogramme RENAME COLUMN qualite_chromato_voc_fk TO chromato_quality_voc_fk ; ALTER TABLE chromatogramme RENAME COLUMN etablissement_fk TO institution_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd ALTER TABLE personne RENAME COLUMN etablissement_fk TO institution_fk ;


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE chromatogramme RENAME TO chromatogram ;
ALTER SEQUENCE chromatogramme_id_seq RENAME TO chromatogram_id_seq ;

-- Internationalisation de la table collecte

-- modification des noms de colonnes;
ALTER TABLE collecte RENAME COLUMN code_collecte TO sample_code ;
ALTER TABLE collecte RENAME COLUMN duree_echantillonnage_mn TO sampling_duration ; ALTER TABLE collecte RENAME COLUMN temperature_c TO temperature ;
ALTER TABLE collecte RENAME COLUMN conductivite_micro_sie_cm TO specific_conductance ; ALTER TABLE collecte RENAME COLUMN a_faire TO sample_status ;
ALTER TABLE collecte RENAME COLUMN commentaire_collecte TO sampling_comments ; ALTER TABLE collecte RENAME COLUMN leg_voc_fk TO donation_voc_fk ;
ALTER TABLE collecte RENAME COLUMN station_fk TO site_fk ;


-- modification du nom de la table adn et de la sequence de l'id auto ALTER TABLE collecte RENAME TO sampling ;
ALTER SEQUENCE collecte_id_seq RENAME TO sampling_id_seq ;

-- Internationalisation de la table commune

-- modification des noms de colonnes;
ALTER TABLE commune RENAME COLUMN code_commune TO municipality_code ; ALTER TABLE commune RENAME COLUMN nom_commune TO municipality_name ; ALTER TABLE commune RENAME COLUMN nom_region TO region_name ;
ALTER TABLE commune RENAME COLUMN pays_fk TO country_fk ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd ALTER TABLE station RENAME COLUMN pays_fk TO country_fk ;


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE commune RENAME TO municipality ;
ALTER SEQUENCE commune_id_seq RENAME TO municipality_id_seq ;

-- Internationalisation de la table composition_lot_materiel

-- modification des noms de colonnes;
ALTER TABLE composition_lot_materiel RENAME COLUMN nb_individus TO number_of_specimens ; ALTER TABLE composition_lot_materiel RENAME COLUMN commentaire_compo_lot_materiel TO internal_biological_material_composition_comments ;
ALTER TABLE composition_lot_materiel RENAME COLUMN type_individu_voc_fk TO specimen_type_voc_fk
;
ALTER TABLE composition_lot_materiel RENAME COLUMN lot_materiel_fk TO internal_biological_material_fk ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd
ALTER TABLE individu RENAME COLUMN type_individu_voc_fk TO specimen_type_voc_fk ; ALTER TABLE individu RENAME COLUMN lot_materiel_fk TO internal_biological_material_fk ;
ALTER TABLE espece_identifiee RENAME COLUMN lot_materiel_fk TO internal_biological_material_fk ; ALTER TABLE lot_est_publie_dans RENAME COLUMN lot_materiel_fk TO internal_biological_material_fk ; ALTER TABLE lot_materiel_est_realise_par RENAME COLUMN lot_materiel_fk TO internal_biological_material_fk ;

-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE composition_lot_materiel RENAME TO composition_of_internal_biological_material ; ALTER SEQUENCE composition_lot_materiel_id_seq RENAME TO composition_of_internal_biological_material_id_seq ;

-- Internationalisation de la table espece_identifiee

-- modification des noms de colonnes;
ALTER TABLE espece_identifiee RENAME COLUMN date_identification TO identification_date ;
ALTER TABLE espece_identifiee RENAME COLUMN commentaire_esp_id TO identified_species_comments ; ALTER TABLE espece_identifiee RENAME COLUMN critere_identification_voc_fk TO identification_criterion_voc_fk ;
ALTER TABLE espece_identifiee RENAME COLUMN lot_materiel_ext_fk TO external_biological_material_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd ALTER TABLE lot_materiel_ext_est_realise_par RENAME COLUMN lot_materiel_ext_fk TO external_biological_material_fk ;
ALTER TABLE lot_materiel_ext_est_reference_dans RENAME COLUMN lot_materiel_ext_fk TO external_biological_material_fk ;


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE espece_identifiee RENAME TO identified_species ;
ALTER SEQUENCE espece_identifiee_id_seq RENAME TO identified_species_id_seq ;

-- Internationalisation de la table est_aligne_et_traite

-- modification des noms de colonnes;
ALTER TABLE est_aligne_et_traite RENAME COLUMN chromatogramme_fk TO chromatogram_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE est_aligne_et_traite RENAME TO chromatogram_is_processed_to ;
ALTER SEQUENCE est_aligne_et_traite_id_seq RENAME TO chromatogram_is_processed_to_id_seq ;

-- Internationalisation de la table est_effectue_par

-- modification des noms de colonnes;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE est_effectue_par RENAME TO sampling_is_performed_by ;
ALTER SEQUENCE est_effectue_par_id_seq RENAME TO sampling_is_performed_by_id_seq ;

-- Internationalisation de la table est_finance_par

-- modification des noms de colonnes;
ALTER TABLE est_finance_par RENAME COLUMN programme_fk TO program_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE est_finance_par RENAME TO sampling_is_funded_by ;
ALTER SEQUENCE est_finance_par_id_seq RENAME TO sampling_is_funded_by_id_seq ;

-- Internationalisation de la table est_identifie_par

-- modification des noms de colonnes;
ALTER TABLE est_identifie_par RENAME COLUMN espece_identifiee_fk TO identified_species_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE est_identifie_par RENAME TO species_is_identified_by ;
ALTER SEQUENCE est_identifie_par_id_seq RENAME TO species_is_identified_by_id_seq ;

-- Internationalisation de la table etablissement

-- modification des noms de colonnes;
ALTER TABLE etablissement RENAME COLUMN nom_etablissement TO institution_name ;
ALTER TABLE etablissement RENAME COLUMN commentaire_etablissement TO institution_comments ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE etablissement RENAME TO institution ;
ALTER SEQUENCE etablissement_id_seq RENAME TO institution_id_seq ;

-- Internationalisation de la table individu

-- modification des noms de colonnes;
ALTER TABLE individu RENAME COLUMN code_ind_biomol TO specimen_molecular_code ;
ALTER TABLE individu RENAME COLUMN code_ind_tri_morpho TO specimen_morphological_code ; ALTER TABLE individu RENAME COLUMN code_tube TO tube_code ;
ALTER TABLE individu RENAME COLUMN num_ind_biomol TO specimen_molecular_number ; ALTER TABLE individu RENAME COLUMN commentaire_ind TO specimen_comments ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE individu RENAME TO specimen ;
ALTER SEQUENCE individu_id_seq RENAME TO specimen_id_seq ;

-- Internationalisation de la table individu_lame

-- modification des noms de colonnes;
ALTER TABLE individu_lame RENAME COLUMN code_lame_coll TO collection_slide_code ; ALTER TABLE individu_lame RENAME COLUMN libelle_lame TO slide_title ;
ALTER TABLE individu_lame RENAME COLUMN date_lame TO slide_date ;
ALTER TABLE individu_lame RENAME COLUMN nom_dossier_photos TO photo_folder_name ; ALTER TABLE individu_lame RENAME COLUMN commentaire_lame TO slide_comments ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE individu_lame RENAME TO specimen_slide ;
ALTER SEQUENCE individu_lame_id_seq RENAME TO specimen_slide_id_seq ;

-- Internationalisation de la table individu_lame_est_realise_par

-- modification des noms de colonnes;
ALTER TABLE individu_lame_est_realise_par RENAME COLUMN individu_lame_fk TO specimen_slide_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE individu_lame_est_realise_par RENAME TO slide_is_mounted_by ;
ALTER SEQUENCE individu_lame_est_realise_par_id_seq RENAME TO slide_is_mounted_by_id_seq ;

-- Internationalisation de la table lot_est_publie_dans

-- modification des noms de colonnes;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_est_publie_dans RENAME TO internal_biological_material_is_published_in ; ALTER SEQUENCE lot_est_publie_dans_id_seq RENAME TO internal_biological_material_is_published_in_id_seq ;

-- Internationalisation de la table lot_materiel

-- modification des noms de colonnes;
ALTER TABLE lot_materiel RENAME COLUMN code_lot_materiel TO internal_biological_material_code ; ALTER TABLE lot_materiel RENAME COLUMN date_lot_materiel TO internal_biological_material_date ; ALTER TABLE lot_materiel RENAME COLUMN commentaire_conseil_sqc TO sequencing_advice ; ALTER TABLE lot_materiel RENAME COLUMN commentaire_lot_materiel TO internal_biological_material_comments ;
ALTER TABLE lot_materiel RENAME COLUMN a_faire TO internal_biological_material_status ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_materiel RENAME TO internal_biological_material ;
ALTER SEQUENCE lot_materiel_id_seq RENAME TO internal_biological_material_id_seq ;

-- Internationalisation de la table lot_materiel_est_realise_par

-- modification des noms de colonnes;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_materiel_est_realise_par RENAME TO Internal_biological_material_is_treated_by ; ALTER SEQUENCE lot_materiel_est_realise_par_id_seq RENAME TO Internal_biological_material_is_treated_by_id_seq ;

-- Internationalisation de la table lot_materiel_ext

-- modification des noms de colonnes;
ALTER TABLE lot_materiel_ext RENAME COLUMN code_lot_materiel_ext TO external_biological_material_code ;
ALTER TABLE lot_materiel_ext RENAME COLUMN date_creation_lot_materiel_ext TO external_biological_material_creation_date ;
ALTER TABLE lot_materiel_ext RENAME COLUMN commentaire_lot_materiel_ext TO external_biological_material_comments ;
ALTER TABLE lot_materiel_ext RENAME COLUMN commentaire_nb_individus TO number_of_specimens_comments ;
ALTER TABLE lot_materiel_ext RENAME COLUMN nb_individus_voc_fk TO number_of_specimens_voc_fk ; ALTER TABLE lot_materiel_ext RENAME COLUMN yeux_voc_fk TO eyes_voc_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd ALTER TABLE lot_materiel RENAME COLUMN yeux_voc_fk TO eyes_voc_fk ;


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_materiel_ext RENAME TO external_biological_material ;
ALTER SEQUENCE lot_materiel_ext_id_seq RENAME TO external_biological_material_id_seq ;

-- Internationalisation de la table lot_materiel_ext_est_realise_par

-- modification des noms de colonnes;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_materiel_ext_est_realise_par RENAME TO external_biological_material_is_processed_by ; ALTER SEQUENCE lot_materiel_ext_est_realise_par_id_seq RENAME TO external_biological_material_is_processed_by_id_seq ;

-- Internationalisation de la table lot_materiel_ext_est_reference_dans

-- modification des noms de colonnes;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE lot_materiel_ext_est_reference_dans RENAME TO external_biological_material_is_published_in ; ALTER SEQUENCE lot_materiel_ext_est_reference_dans_id_seq RENAME TO external_biological_material_is_published_in_id_seq ;

-- Internationalisation de la table motu

-- modification des noms de colonnes;
ALTER TABLE motu RENAME COLUMN nom_fichier_csv TO csv_file_name ; ALTER TABLE motu RENAME COLUMN date_motu TO motu_date ;
ALTER TABLE motu RENAME COLUMN commentaire_motu TO motu_comments ; ALTER TABLE motu RENAME COLUMN libelle_motu TO motu_title ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto

-- Internationalisation de la table motu_est_genere_par

-- modification des noms de colonnes;
ALTER TABLE motu_est_genere_par RENAME COLUMN motu_fk TO motu_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE motu_est_genere_par RENAME TO motu_is_generated_by ;
ALTER SEQUENCE motu_est_genere_par_id_seq RENAME TO motu_is_generated_by_id_seq ;

-- Internationalisation de la table pays

-- modification des noms de colonnes;
ALTER TABLE pays RENAME COLUMN code_pays TO country_code ; ALTER TABLE pays RENAME COLUMN nom_pays TO country_name ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE pays RENAME TO country ;
ALTER SEQUENCE pays_id_seq RENAME TO country_id_seq ;

-- Internationalisation de la table pcr

-- modification des noms de colonnes;
ALTER TABLE pcr RENAME COLUMN code_pcr TO pcr_code ; ALTER TABLE pcr RENAME COLUMN num_pcr TO pcr_number ; ALTER TABLE pcr RENAME COLUMN date_pcr TO pcr_date ; ALTER TABLE pcr RENAME COLUMN detail_pcr TO pcr_details ;
ALTER TABLE pcr RENAME COLUMN remarque_pcr TO pcr_comments ;
ALTER TABLE pcr RENAME COLUMN qualite_pcr_voc_fk TO pcr_quality_voc_fk ; ALTER TABLE pcr RENAME COLUMN specificite_voc_fk TO pcr_specificity_voc_fk ;
ALTER TABLE pcr RENAME COLUMN primer_pcr_start_voc_fk TO forward_primer_voc_fk ; ALTER TABLE pcr RENAME COLUMN primer_pcr_end_voc_fk TO reverse_primer_voc_fk ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd

-- modification du nom de la table et de la sequence de l'id auto

-- Internationalisation de la table pcr_est_realise_par

-- modification des noms de colonnes;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd

-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE pcr_est_realise_par RENAME TO pcr_is_done_by ;
ALTER SEQUENCE pcr_est_realise_par_id_seq RENAME TO pcr_is_done_by_id_seq ;

-- Internationalisation de la table personne

-- modification des noms de colonnes;
ALTER TABLE personne RENAME COLUMN nom_personne TO person_name ; ALTER TABLE personne RENAME COLUMN nom_complet TO person_full_name ; ALTER TABLE personne RENAME COLUMN nom_personne_ref TO person_name_bis ;
ALTER TABLE personne RENAME COLUMN commentaire_personne TO person_comments ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd

-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE personne RENAME TO person ;
ALTER SEQUENCE personne_id_seq RENAME TO person_id_seq ;

-- Internationalisation de la table programme

-- modification des noms de colonnes;
ALTER TABLE programme RENAME COLUMN code_programme TO program_code ; ALTER TABLE programme RENAME COLUMN nom_programme TO program_name ; ALTER TABLE programme RENAME COLUMN noms_responsables TO coordinator_names ; ALTER TABLE programme RENAME COLUMN type_financeur TO funding_agency ; ALTER TABLE programme RENAME COLUMN annee_debut TO starting_year ;
ALTER TABLE programme RENAME COLUMN annee_fin TO ending_year ;
ALTER TABLE programme RENAME COLUMN commentaire_programme TO program_comments ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd

-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE programme RENAME TO program ;
ALTER SEQUENCE programme_id_seq RENAME TO program_id_seq ;

-- Internationalisation de la table referentiel_taxon

-- modification des noms de colonnes;
ALTER TABLE referentiel_taxon RENAME COLUMN taxname TO taxon_name ; ALTER TABLE referentiel_taxon RENAME COLUMN rank TO taxon_rank ; ALTER TABLE referentiel_taxon RENAME COLUMN ordre TO "order" ;
ALTER TABLE referentiel_taxon RENAME COLUMN validity TO taxon_validity ; ALTER TABLE referentiel_taxon RENAME COLUMN code_taxon TO taxon_code ;
ALTER TABLE referentiel_taxon RENAME COLUMN commentaire_ref TO taxon_comments ; ALTER TABLE referentiel_taxon RENAME COLUMN taxname_ref TO taxon_synonym ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd

-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE referentiel_taxon RENAME TO taxon ;
ALTER SEQUENCE referentiel_taxon_id_seq RENAME TO taxon_id_seq ;

-- Internationalisation de la table sequence_assemblee
ALTER TABLE sequence_assemblee RENAME COLUMN code_sqc_ass TO internal_sequence_code ; ALTER TABLE sequence_assemblee RENAME COLUMN date_creation_sqc_ass TO internal_sequence_creation_date ;
ALTER TABLE sequence_assemblee RENAME COLUMN accession_number TO internal_sequence_accession_number ;
ALTER TABLE sequence_assemblee RENAME COLUMN code_sqc_alignement TO internal_sequence_alignment_code ;
ALTER TABLE sequence_assemblee RENAME COLUMN commentaire_sqc_ass TO internal_sequence_comments ;
ALTER TABLE sequence_assemblee RENAME COLUMN statut_sqc_ass_voc_fk TO internal_sequence_status_voc_fk ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE sequence_assemblee RENAME TO internal_sequence ;
ALTER SEQUENCE sequence_assemblee_id_seq RENAME TO internal_sequence_id_seq ;

-- Internationalisation de la table sequence_assemblee_est_realise_par



-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER SEQUENCE sequence_assemblee_est_realise_par_id_seq RENAME TO internal_sequence_is_assembled_by_id_seq ;
ALTER TABLE sequence_assemblee_est_realise_par RENAME TO internal_sequence_is_assembled_by ;

-- Internationalisation de la table sequence_assemblee_ext
ALTER TABLE sequence_assemblee_ext RENAME COLUMN code_sqc_ass_ext_alignement TO external_sequence_alignment_code ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN code_sqc_ass_ext TO external_sequence_code ; ALTER TABLE sequence_assemblee_ext RENAME COLUMN date_creation_sqc_ass_ext TO external_sequence_creation_date ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN accession_number_sqc_ass_ext TO external_sequence_accession_number ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN num_individu_sqc_ass_ext TO external_sequence_specimen_number ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN taxon_origine_sqc_ass_ext TO external_sequence_primary_taxon ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN commentaire_sqc_ass_ext TO external_sequence_comments ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN origine_sqc_ass_ext_voc_fk TO external_sequence_origin_voc_fk ;
ALTER TABLE sequence_assemblee_ext RENAME COLUMN statut_sqc_ass_voc_fk TO external_sequence_status_voc_fk ;

-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE sequence_assemblee_ext RENAME TO external_sequence ;
ALTER SEQUENCE sequence_assemblee_ext_id_seq RENAME TO external_sequence_id_seq ;

-- Internationalisation de la table source
ALTER TABLE source RENAME COLUMN code_source TO source_code ; ALTER TABLE source RENAME COLUMN annee_source TO source_year ; ALTER TABLE source RENAME COLUMN libelle_source TO source_title ;
ALTER TABLE source RENAME COLUMN commentaire_source TO source_comments ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto

-- Internationalisation de la table source_a_ete_integre_par


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE source_a_ete_integre_par RENAME TO source_is_entered_by ;
ALTER SEQUENCE source_a_ete_integre_par_id_seq RENAME TO source_is_entered_by_id_seq ;

-- Internationalisation de la table sqc_est_publie_dans


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE sqc_est_publie_dans RENAME TO internal_sequence_is_published_in ;
ALTER SEQUENCE sqc_est_publie_dans_id_seq RENAME TO internal_sequence_is_published_in_id_seq ;

-- Internationalisation de la table sqc_ext_est_realise_par


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE sqc_ext_est_realise_par RENAME TO external_sequence_is_entered_by ;
ALTER SEQUENCE sqc_ext_est_realise_par_id_seq RENAME TO external_sequence_is_entered_by_id_seq ;

-- Internationalisation de la table sqc_ext_est_reference_dans


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto
ALTER TABLE sqc_ext_est_reference_dans RENAME TO external_sequence_is_published_in ; ALTER SEQUENCE sqc_ext_est_reference_dans_id_seq RENAME TO external_sequence_is_published_in_id_seq ;

-- Internationalisation de la table sqc_ext_est_reference_dans
ALTER TABLE station RENAME COLUMN code_station TO site_code ; ALTER TABLE station RENAME COLUMN nom_station TO site_name ; ALTER TABLE station RENAME COLUMN lat_deg_dec TO latitude ; ALTER TABLE station RENAME COLUMN long_deg_dec TO longitude ; ALTER TABLE station RENAME COLUMN altitude_m TO elevation ;
ALTER TABLE station RENAME COLUMN info_localisation TO location_info ; ALTER TABLE station RENAME COLUMN info_description TO site_description ; ALTER TABLE station RENAME COLUMN commentaire_station TO site_comments ; ALTER TABLE station RENAME COLUMN commune_fk TO municipality_fk ;
ALTER TABLE station RENAME COLUMN point_acces_voc_fk TO access_point_voc_fk ; ALTER TABLE station RENAME COLUMN habitat_type_voc_fk TO habitat_type_voc_fk ;
ALTER TABLE station RENAME COLUMN precision_lat_long_voc_fk TO coordinate_precision_voc_fk ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE station RENAME TO site ;
ALTER SEQUENCE station_id_seq RENAME TO site_id_seq ;

-- Internationalisation de la table user_db
ALTER TABLE user_db RENAME COLUMN username TO user_name ; ALTER TABLE user_db RENAME COLUMN password TO user_password ; ALTER TABLE user_db RENAME COLUMN role TO user_role ;
ALTER TABLE user_db RENAME COLUMN name TO user_full_name ; ALTER TABLE user_db RENAME COLUMN email TO user_email ;
ALTER TABLE user_db RENAME COLUMN institution TO user_institution ; ALTER TABLE user_db RENAME COLUMN commentaire_user TO user_comments ; ALTER TABLE user_db RENAME COLUMN salt TO salt ;
ALTER TABLE user_db RENAME COLUMN is_active TO user_is_active ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto

-- Internationalisation de la table voc
ALTER TABLE voc RENAME COLUMN libelle TO vocabulary_title ; ALTER TABLE voc RENAME COLUMN commentaire TO voc_comments ;


-- modification des noms de colonnes modifiées existantes dans les autres tables de la bdd


-- modification du nom de la table et de la sequence de l'id auto ALTER TABLE voc RENAME TO vocabulary ;
ALTER SEQUENCE voc_id_seq RENAME TO vocabulary_id_seq ;

-- Internationalisation de la table user_db

-- modification des noms de colonnes;
ALTER TABLE user_db RENAME COLUMN commentaire_user TO user_comments;


---------------------------------------------------------------------------------
-- CHANGE CONSTRAINTS NAMES
ALTER TABLE chromatogram RENAME CONSTRAINT ce_cle_etrangere98 TO fk_98 ;
ALTER TABLE chromatogram RENAME CONSTRAINT ce_cle_etrangere97 TO fk_97 ;
ALTER TABLE chromatogram RENAME CONSTRAINT ce_cle_etrangere96 TO fk_96 ;
ALTER TABLE chromatogram RENAME CONSTRAINT ce_cle_etrangere99 TO fk_99 ;
ALTER TABLE chromatogram_is_processed_to RENAME CONSTRAINT ce_cle_etrangere37 TO fk_37 ;
ALTER TABLE chromatogram_is_processed_to RENAME CONSTRAINT ce_cle_etrangere38 TO fk_38 ;
ALTER TABLE composition_of_internal_biological_material RENAME CONSTRAINT ce_cle_etrangere15 TO fk_15 ;
ALTER TABLE composition_of_internal_biological_material RENAME CONSTRAINT ce_cle_etrangere16 TO fk_16 ;
ALTER TABLE dna RENAME CONSTRAINT ce_cle_etrangere87 TO fk_87 ;
ALTER TABLE dna RENAME CONSTRAINT ce_cle_etrangere84 TO fk_84 ;
ALTER TABLE dna RENAME CONSTRAINT ce_cle_etrangere88 TO fk_88 ;
ALTER TABLE dna RENAME CONSTRAINT ce_cle_etrangere85 TO fk_85 ;
ALTER TABLE dna RENAME CONSTRAINT ce_cle_etrangere86 TO fk_86 ;
ALTER TABLE dna_is_extracted_by RENAME CONSTRAINT ce_cle_etrangere24 TO fk_24 ;
ALTER TABLE dna_is_extracted_by RENAME CONSTRAINT ce_cle_etrangere23 TO fk_23 ;
ALTER TABLE external_biological_material RENAME CONSTRAINT ce_cle_etrangere50 TO fk_50 ;
ALTER TABLE external_biological_material RENAME CONSTRAINT ce_cle_etrangere46 TO fk_46 ;
ALTER TABLE external_biological_material RENAME CONSTRAINT ce_cle_etrangere47 TO fk_47 ;
ALTER TABLE external_biological_material RENAME CONSTRAINT ce_cle_etrangere48 TO fk_48 ;
ALTER TABLE external_biological_material RENAME CONSTRAINT ce_cle_etrangere49 TO fk_49 ;
ALTER TABLE external_biological_material_is_processed_by RENAME CONSTRAINT ce_cle_etrangere51 TO fk_51 ;
ALTER TABLE external_biological_material_is_processed_by RENAME CONSTRAINT ce_cle_etrangere52 TO fk_52 ;
ALTER TABLE external_biological_material_is_published_in RENAME CONSTRAINT ce_cle_etrangere54 TO fk_54 ;
ALTER TABLE external_biological_material_is_published_in RENAME CONSTRAINT ce_cle_etrangere53 TO fk_53 ;
ALTER TABLE external_sequence RENAME CONSTRAINT ce_cle_etrangere3 TO fk_3 ;
ALTER TABLE external_sequence RENAME CONSTRAINT ce_cle_etrangere2 TO fk_2 ;
ALTER TABLE external_sequence RENAME CONSTRAINT ce_cle_etrangere4 TO fk_4 ;
ALTER TABLE external_sequence RENAME CONSTRAINT ce_cle_etrangere6 TO fk_6 ;
ALTER TABLE external_sequence RENAME CONSTRAINT ce_cle_etrangere5 TO fk_5 ;
ALTER TABLE external_sequence_is_entered_by RENAME CONSTRAINT ce_cle_etrangere31 TO fk_31 ;
ALTER TABLE external_sequence_is_entered_by RENAME CONSTRAINT ce_cle_etrangere32 TO fk_32 ;
ALTER TABLE external_sequence_is_published_in RENAME CONSTRAINT ce_cle_etrangere8 TO fk_8 ;
ALTER TABLE external_sequence_is_published_in RENAME CONSTRAINT ce_cle_etrangere7 TO fk_7 ;
ALTER TABLE has_targeted_taxa RENAME CONSTRAINT ce_cle_etrangere17 TO fk_17 ;
ALTER TABLE has_targeted_taxa RENAME CONSTRAINT ce_cle_etrangere18 TO fk_18 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere79 TO fk_79 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere75 TO fk_75 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere74 TO fk_74 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere76 TO fk_76 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere80 TO fk_80 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere78 TO fk_78 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere77 TO fk_77 ;
ALTER TABLE identified_species RENAME CONSTRAINT ce_cle_etrangere81 TO fk_81 ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT ce_cle_etrangere69 TO fk_69 ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT ce_cle_etrangere71 TO fk_71 ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT ce_cle_etrangere73 TO fk_73 ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT ce_cle_etrangere72 TO fk_72 ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT ce_cle_etrangere70 TO fk_70 ;
ALTER TABLE internal_biological_material_is_published_in RENAME CONSTRAINT ce_cle_etrangere44 TO fk_44 ;
ALTER TABLE internal_biological_material_is_published_in RENAME CONSTRAINT ce_cle_etrangere45 TO fk_45 ;
ALTER TABLE internal_biological_material_is_treated_by RENAME CONSTRAINT ce_cle_etrangere28 TO fk_28 ;
ALTER TABLE internal_biological_material_is_treated_by RENAME CONSTRAINT ce_cle_etrangere27 TO fk_27 ;
ALTER TABLE internal_sequence RENAME CONSTRAINT ce_cle_etrangere36 TO fk_36 ;
ALTER TABLE internal_sequence RENAME CONSTRAINT ce_cle_etrangere35 TO fk_35 ;
ALTER TABLE internal_sequence_is_assembled_by RENAME CONSTRAINT ce_cle_etrangere20 TO fk_20 ;
ALTER TABLE internal_sequence_is_assembled_by RENAME CONSTRAINT ce_cle_etrangere19 TO fk_19 ;
ALTER TABLE internal_sequence_is_published_in RENAME CONSTRAINT ce_cle_etrangere TO fk_ ;
ALTER TABLE internal_sequence_is_published_in RENAME CONSTRAINT ce_cle_etrangere1 TO fk_1 ;
ALTER TABLE motu_is_generated_by RENAME CONSTRAINT ce_cle_etrangere34 TO fk_34 ;
ALTER TABLE motu_is_generated_by RENAME CONSTRAINT ce_cle_etrangere33 TO fk_33 ;
ALTER TABLE motu_number RENAME CONSTRAINT ce_cle_etrangere14 TO fk_14 ;
ALTER TABLE motu_number RENAME CONSTRAINT ce_cle_etrangere13 TO fk_13 ;
ALTER TABLE motu_number RENAME CONSTRAINT ce_cle_etrangere12 TO fk_12 ;
ALTER TABLE motu_number RENAME CONSTRAINT ce_cle_etrangere11 TO fk_11 ;
ALTER TABLE municipality RENAME CONSTRAINT ce_cle_etrangere39 TO fk_39 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere94 TO fk_94 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere89 TO fk_89 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere90 TO fk_90 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere91 TO fk_91 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere92 TO fk_92 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere95 TO fk_95 ;
ALTER TABLE pcr RENAME CONSTRAINT ce_cle_etrangere93 TO fk_93 ;
ALTER TABLE pcr_is_done_by RENAME CONSTRAINT ce_cle_etrangere22 TO fk_22 ;
ALTER TABLE pcr_is_done_by RENAME CONSTRAINT ce_cle_etrangere21 TO fk_21 ;
ALTER TABLE person RENAME CONSTRAINT ce_cle_etrangere63 TO fk_63 ;
ALTER TABLE sample_is_fixed_with RENAME CONSTRAINT ce_cle_etrangere42 TO fk_42 ;
ALTER TABLE sample_is_fixed_with RENAME CONSTRAINT ce_cle_etrangere43 TO fk_43 ;
ALTER TABLE sampling RENAME CONSTRAINT ce_cle_etrangere60 TO fk_60 ;
ALTER TABLE sampling RENAME CONSTRAINT ce_cle_etrangere62 TO fk_62 ;
ALTER TABLE sampling RENAME CONSTRAINT ce_cle_etrangere61 TO fk_61 ;
ALTER TABLE sampling_is_done_with_method RENAME CONSTRAINT ce_cle_etrangere41 TO fk_41 ;
ALTER TABLE sampling_is_done_with_method RENAME CONSTRAINT ce_cle_etrangere40 TO fk_40 ;
ALTER TABLE sampling_is_funded_by RENAME CONSTRAINT ce_cle_etrangere100 TO fk_100 ;
ALTER TABLE sampling_is_funded_by RENAME CONSTRAINT ce_cle_etrangere101 TO fk_101 ;
ALTER TABLE sampling_is_performed_by RENAME CONSTRAINT ce_cle_etrangere65 TO fk_65 ;
ALTER TABLE sampling_is_performed_by RENAME CONSTRAINT ce_cle_etrangere64 TO fk_64 ;
ALTER TABLE site RENAME CONSTRAINT ce_cle_etrangere55 TO fk_55 ;
ALTER TABLE site RENAME CONSTRAINT ce_cle_etrangere57 TO fk_57 ;
ALTER TABLE site RENAME CONSTRAINT ce_cle_etrangere56 TO fk_56 ;
ALTER TABLE site RENAME CONSTRAINT ce_cle_etrangere58 TO fk_58 ;
ALTER TABLE site RENAME CONSTRAINT ce_cle_etrangere59 TO fk_59 ;
ALTER TABLE slide_is_mounted_by RENAME CONSTRAINT ce_cle_etrangere25 TO fk_25 ;
ALTER TABLE slide_is_mounted_by RENAME CONSTRAINT ce_cle_etrangere26 TO fk_26 ;
ALTER TABLE source_is_entered_by RENAME CONSTRAINT ce_cle_etrangere30 TO fk_30 ;
ALTER TABLE source_is_entered_by RENAME CONSTRAINT ce_cle_etrangere29 TO fk_29 ;
ALTER TABLE species_is_identified_by RENAME CONSTRAINT ce_cle_etrangere10 TO fk_10 ;
ALTER TABLE species_is_identified_by RENAME CONSTRAINT ce_cle_etrangere9 TO fk_9 ;
ALTER TABLE specimen RENAME CONSTRAINT ce_cle_etrangere83 TO fk_83 ;
ALTER TABLE specimen RENAME CONSTRAINT ce_cle_etrangere82 TO fk_82 ;
ALTER TABLE specimen_slide RENAME CONSTRAINT ce_cle_etrangere103 TO fk_103 ;
ALTER TABLE specimen_slide RENAME CONSTRAINT ce_cle_etrangere104 TO fk_104 ;
ALTER TABLE specimen_slide RENAME CONSTRAINT ce_cle_etrangere102 TO fk_102 ;
ALTER TABLE storage_box RENAME CONSTRAINT ce_cle_etrangere66 TO fk_66 ;
ALTER TABLE storage_box RENAME CONSTRAINT ce_cle_etrangere67 TO fk_67 ;
ALTER TABLE storage_box RENAME CONSTRAINT ce_cle_etrangere68 TO fk_68 ;
ALTER TABLE chromatogram RENAME CONSTRAINT cp_chromatogramme_cle_primaire  TO pk_chromatogram ;
ALTER TABLE chromatogram_is_processed_to RENAME CONSTRAINT cp_est_aligne_et_traite_cle_primaire  TO pk_chromatogram_is_processed_to ;
ALTER TABLE composition_of_internal_biological_material RENAME CONSTRAINT cp_composition_lot_materiel_cle_primaire  TO pk_composition_of_internal_biological_material ;
ALTER TABLE country RENAME CONSTRAINT cp_pays_cle_primaire  TO pk_country ;
ALTER TABLE dna RENAME CONSTRAINT cp_adn_cle_primaire  TO pk_dna ;
ALTER TABLE dna_is_extracted_by RENAME CONSTRAINT cp_adn_est_realise_par_cle_primaire  TO pk_dna_is_extracted_by ;
ALTER TABLE external_biological_material RENAME CONSTRAINT cp_lot_materiel_ext_cle_primaire  TO pk_external_biological_material ;
ALTER TABLE external_biological_material_is_processed_by RENAME CONSTRAINT cp_lot_materiel_ext_est_realise_par_cle_primaire  TO pk_external_biological_material_is_processed_by ;
ALTER TABLE external_biological_material_is_published_in RENAME CONSTRAINT cp_lot_materiel_ext_est_reference_dans_cle_primaire  TO pk_external_biological_material_is_published_in ;
ALTER TABLE external_sequence RENAME CONSTRAINT cp_sequence_assemblee_ext_cle_primaire  TO pk_external_sequence ;
ALTER TABLE external_sequence_is_entered_by RENAME CONSTRAINT cp_sqc_ext_est_realise_par_cle_primaire  TO pk_external_sequence_is_entered_by ;
ALTER TABLE external_sequence_is_published_in RENAME CONSTRAINT cp_sqc_ext_est_reference_dans_cle_primaire  TO pk_external_sequence_is_published_in ;
ALTER TABLE has_targeted_taxa RENAME CONSTRAINT cp_a_cibler_cle_primaire  TO pk_has_targeted_taxa ;
ALTER TABLE identified_species RENAME CONSTRAINT cp_espece_identifiee_cle_primaire  TO pk_identified_species ;
ALTER TABLE institution RENAME CONSTRAINT cp_etablissement_cle_primaire  TO pk_institution ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT cp_lot_materiel_cle_primaire  TO pk_internal_biological_material ;
ALTER TABLE internal_biological_material_is_published_in RENAME CONSTRAINT cp_lot_est_publie_dans_cle_primaire  TO pk_internal_biological_material_is_published_in ;
ALTER TABLE internal_biological_material_is_treated_by RENAME CONSTRAINT cp_lot_materiel_est_realise_par_cle_primaire  TO pk_internal_biological_material_is_treated_by ;
ALTER TABLE internal_sequence RENAME CONSTRAINT cp_sequence_assemblee_cle_primaire  TO pk_internal_sequence ;
ALTER TABLE internal_sequence_is_assembled_by RENAME CONSTRAINT cp_sequence_assemblee_est_realise_par_cle_primaire  TO pk_internal_sequence_is_assembled_by ;
ALTER TABLE internal_sequence_is_published_in RENAME CONSTRAINT cp_sqc_est_publie_dans_cle_primaire  TO pk_internal_sequence_is_published_in ;
ALTER TABLE motu RENAME CONSTRAINT cp_motu_cle_primaire  TO pk_motu ;
ALTER TABLE motu_is_generated_by RENAME CONSTRAINT cp_motu_est_genere_par_cle_primaire  TO pk_motu_is_generated_by ;
ALTER TABLE motu_number RENAME CONSTRAINT cp_assigne_cle_primaire  TO pk_motu_number ;
ALTER TABLE municipality RENAME CONSTRAINT cp_commune_cle_primaire  TO pk_municipality ;
ALTER TABLE pcr RENAME CONSTRAINT cp_pcr_cle_primaire  TO pk_pcr ;
ALTER TABLE pcr_is_done_by RENAME CONSTRAINT cp_pcr_est_realise_par_cle_primaire  TO pk_pcr_is_done_by ;
ALTER TABLE person RENAME CONSTRAINT cp_personne_cle_primaire  TO pk_person ;
ALTER TABLE program RENAME CONSTRAINT cp_programme_cle_primaire  TO pk_program ;
ALTER TABLE sample_is_fixed_with RENAME CONSTRAINT cp_a_pour_fixateur_cle_primaire  TO pk_sample_is_fixed_with ;
ALTER TABLE sampling RENAME CONSTRAINT cp_collecte_cle_primaire  TO pk_sampling ;
ALTER TABLE sampling_is_done_with_method RENAME CONSTRAINT cp_a_pour_sampling_method_cle_primaire  TO pk_sampling_is_done_with_method ;
ALTER TABLE sampling_is_funded_by RENAME CONSTRAINT cp_est_finance_par_cle_primaire  TO pk_sampling_is_funded_by ;
ALTER TABLE sampling_is_performed_by RENAME CONSTRAINT cp_est_effectue_par_cle_primaire  TO pk_sampling_is_performed_by ;
ALTER TABLE site RENAME CONSTRAINT cp_station_cle_primaire  TO pk_site ;
ALTER TABLE slide_is_mounted_by RENAME CONSTRAINT cp_individu_lame_est_realise_par_cle_primaire  TO pk_slide_is_mounted_by ;
ALTER TABLE source RENAME CONSTRAINT cp_source_cle_primaire  TO pk_source ;
ALTER TABLE source_is_entered_by RENAME CONSTRAINT cp_source_a_ete_integre_par_cle_primaire  TO pk_source_is_entered_by ;
ALTER TABLE species_is_identified_by RENAME CONSTRAINT cp_est_identifie_par_cle_primaire  TO pk_species_is_identified_by ;
ALTER TABLE specimen RENAME CONSTRAINT cp_individu_cle_primaire  TO pk_specimen ;
ALTER TABLE specimen_slide RENAME CONSTRAINT cp_individu_lame_cle_primaire  TO pk_specimen_slide ;
ALTER TABLE storage_box RENAME CONSTRAINT cp_boite_cle_primaire  TO pk_storage_box ;
ALTER TABLE taxon RENAME CONSTRAINT cp_referentiel_taxon_cle_primaire  TO pk_taxon ;
ALTER TABLE user_db RENAME CONSTRAINT user_db_pkey  TO pk_user_db ;
ALTER TABLE vocabulary RENAME CONSTRAINT cp_voc_cle_primaire  TO pk_vocabulary ;
ALTER TABLE chromatogram RENAME CONSTRAINT cu_chromatogramme_cle_primaire  TO uk_chromatogram__chromatogram_code ;
ALTER TABLE country RENAME CONSTRAINT cu_pays_cle_primaire  TO uk_country__country_code ;
ALTER TABLE dna RENAME CONSTRAINT cu_adn_cle_primaire  TO uk_dna__dna_code ;
ALTER TABLE external_biological_material RENAME CONSTRAINT cu_lot_materiel_ext_code_lot_materiel_ext  TO uk_external_biological_material__external_biological_material_code ;
ALTER TABLE external_sequence RENAME CONSTRAINT cu_sequence_assemblee_ext_code_sqc_ass_ext_alignement  TO uk_external_sequence__external_sequence_alignment_code ;
ALTER TABLE external_sequence RENAME CONSTRAINT cu_sequence_assemblee_ext_cle_primaire  TO uk_external_sequence__external_sequence_code ;
ALTER TABLE institution RENAME CONSTRAINT cu_etablissement_cle_primaire  TO uk_institution__institution_name ;
ALTER TABLE internal_biological_material RENAME CONSTRAINT cu_lot_materiel_cle_primaire  TO uk_internal_biological_material__internal_biological_material_code ;
ALTER TABLE internal_sequence RENAME CONSTRAINT cu_sequence_assemblee_cle_primaire  TO uk_internal_sequence__internal_sequence_code ;
ALTER TABLE internal_sequence RENAME CONSTRAINT cu_sequence_assemblee_code_sqc_alignement  TO uk_internal_sequence__internal_sequence_alignment_code ;
ALTER TABLE municipality RENAME CONSTRAINT cu_commune_cle_primaire  TO uk_municipality__municipality_code ;
ALTER TABLE pcr RENAME CONSTRAINT cu_pcr_cle_primaire  TO uk_pcr__pcr_code ;
ALTER TABLE person RENAME CONSTRAINT cu_personne_cle_primaire  TO uk_person__person_name ;
ALTER TABLE program RENAME CONSTRAINT cu_programme_cle_primaire  TO uk_program__program_code ;
ALTER TABLE sampling RENAME CONSTRAINT cu_collecte_cle_primaire  TO uk_sampling__sample_code ;
ALTER TABLE site RENAME CONSTRAINT cu_station_cle_primaire  TO uk_site__site_code ;
ALTER TABLE source RENAME CONSTRAINT cu_source_cle_primaire  TO uk_source__source_code ;
ALTER TABLE specimen RENAME CONSTRAINT cu_individu_code_ind_tri_morpho  TO uk_specimen__specimen_morphological_code ;
ALTER TABLE specimen RENAME CONSTRAINT cu_individu_code_ind_biomol  TO uk_specimen__specimen_molecular_code ;
ALTER TABLE specimen_slide RENAME CONSTRAINT cu_individu_lame_cle_primaire  TO uk_specimen_slide__collection_slide_code ;
ALTER TABLE storage_box RENAME CONSTRAINT cu_boite_cle_primaire  TO uk_storage_box__box_code ;
ALTER TABLE taxon RENAME CONSTRAINT cu_referentiel_taxon_cle_primaire  TO uk_taxon__taxon_name ;
ALTER TABLE taxon RENAME CONSTRAINT cu_referentiel_taxon_code_taxon  TO uk_taxon__taxon_code ;
ALTER TABLE user_db RENAME CONSTRAINT cu_user_db_username  TO uk_user_db__username ;

--------------------------------------------------------
-- LAST UPGRADE AND UPDATE 

-- doctrine:schema:update --> SQL to db postgreSQL
CREATE INDEX IDX_1DCF9AF9C53B46B ON dna (dna_quality_voc_fk);
CREATE INDEX IDX_EA07BFA754DBBD4D ON internal_biological_material_is_published_in (internal_biological_material_fk);
CREATE INDEX IDX_EA07BFA7821B1D3F ON internal_biological_material_is_published_in (source_fk);
-- rename INDEX cle_etrangere* in dna table
ALTER INDEX cle_etrangere RENAME TO idx_dna__dna_extraction_method_voc_fk;
ALTER INDEX cle_etrangere1 RENAME TO idx_dna__date_precision_voc_fk;
ALTER INDEX cle_etrangere2 RENAME TO idx_dna__storage_box_fk;
ALTER INDEX cle_etrangere3 RENAME TO idx_dna__specimen_fk;
-- rename pk cu_voc_cle_primaire [vocabulary] => uk_vocabulary__parent__code
ALTER TABLE vocabulary RENAME CONSTRAINT cu_voc_cle_primaire TO uk_vocabulary__parent__code ;

-- add field type_material_voc_fk in identified_species
-- add default values
INSERT INTO vocabulary (code, vocabulary_title, parent, voc_comments, date_of_creation, date_of_update, creation_user_name, update_user_name) VALUES ('NO_TYPE', 'NO TYPE', 'typeMaterial', '', CURRENT_TIMESTAMP(0), CURRENT_TIMESTAMP(0), 1, 1);
-- Changes in table identified_species
ALTER TABLE identified_species ADD type_material_voc_fk BIGINT; 
ALTER TABLE identified_species ADD CONSTRAINT FK_801C3911B669F53D FOREIGN KEY (type_material_voc_fk) REFERENCES vocabulary (id) NOT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX IDX_801C3911B669F53D ON identified_species (type_material_voc_fk);
-- initialized value of existing records to the default value (NO TYPE)
DO $$
    DECLARE last_id INT;
    BEGIN
        SELECT id FROM vocabulary WHERE code LIKE 'NO_TYPE' INTO last_id;
        UPDATE identified_species SET type_material_voc_fk = last_id;
    END;
$$ LANGUAGE plpgsql;

-- add field taxon_full_name in taxon
ALTER TABLE taxon ADD taxon_full_name CHARACTER VARYING(255) ;

   

