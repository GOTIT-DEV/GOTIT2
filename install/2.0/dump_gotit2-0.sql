--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.15
-- Dumped by pg_dump version 10.0

-- Started on 2020-02-27 15:11:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2754 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 3 (class 3079 OID 81082)
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- TOC entry 2755 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- TOC entry 2 (class 3079 OID 81154)
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- TOC entry 2756 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


SET search_path = public, pg_catalog;

--
-- TOC entry 321 (class 1255 OID 81169)
-- Name: maj_datecre_datemaj_commune(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION maj_datecre_datemaj_commune() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  n INTEGER := 0 ;
  i INTEGER := 0 ;
BEGIN
	SELECT COUNT(*) FROM commune INTO n ; 
    WHILE  i<n LOOP 
           i := i + 1 ;
          UPDATE commune
            SET date_cre = '2018-07-23 15:33:17'
            WHERE id = i;
          UPDATE commune
            SET date_maj = '2018-07-23 15:33:17'
            WHERE id = i;
    END LOOP ;
    RETURN n ;
END ;
$$;


SET default_with_oids = false;

--
-- TOC entry 189 (class 1259 OID 81211)
-- Name: chromatogram; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chromatogram (
    id bigint NOT NULL,
    chromatogram_code character varying(255) NOT NULL,
    chromatogram_number character varying(255) NOT NULL,
    chromatogram_comments text,
    chromato_primer_voc_fk bigint NOT NULL,
    chromato_quality_voc_fk bigint NOT NULL,
    institution_fk bigint NOT NULL,
    pcr_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 190 (class 1259 OID 81217)
-- Name: chromatogram_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chromatogram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2757 (class 0 OID 0)
-- Dependencies: 190
-- Name: chromatogram_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chromatogram_id_seq OWNED BY chromatogram.id;


--
-- TOC entry 199 (class 1259 OID 81251)
-- Name: chromatogram_is_processed_to; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE chromatogram_is_processed_to (
    id bigint NOT NULL,
    chromatogram_fk bigint NOT NULL,
    internal_sequence_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 200 (class 1259 OID 81254)
-- Name: chromatogram_is_processed_to_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chromatogram_is_processed_to_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2758 (class 0 OID 0)
-- Dependencies: 200
-- Name: chromatogram_is_processed_to_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chromatogram_is_processed_to_id_seq OWNED BY chromatogram_is_processed_to.id;


--
-- TOC entry 195 (class 1259 OID 81235)
-- Name: composition_of_internal_biological_material; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE composition_of_internal_biological_material (
    id bigint NOT NULL,
    number_of_specimens bigint,
    internal_biological_material_composition_comments text,
    specimen_type_voc_fk bigint NOT NULL,
    internal_biological_material_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 196 (class 1259 OID 81241)
-- Name: composition_of_internal_biological_material_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE composition_of_internal_biological_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2759 (class 0 OID 0)
-- Dependencies: 196
-- Name: composition_of_internal_biological_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE composition_of_internal_biological_material_id_seq OWNED BY composition_of_internal_biological_material.id;


--
-- TOC entry 231 (class 1259 OID 81349)
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE country (
    id bigint NOT NULL,
    country_code character varying(255) NOT NULL,
    country_name character varying(1024) NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 232 (class 1259 OID 81355)
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2760 (class 0 OID 0)
-- Dependencies: 232
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE country_id_seq OWNED BY country.id;


--
-- TOC entry 181 (class 1259 OID 81185)
-- Name: dna; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dna (
    id bigint NOT NULL,
    dna_code character varying(255) NOT NULL,
    dna_extraction_date date,
    dna_concentration double precision,
    dna_comments text,
    date_precision_voc_fk bigint NOT NULL,
    dna_extraction_method_voc_fk bigint NOT NULL,
    specimen_fk bigint NOT NULL,
    dna_quality_voc_fk bigint NOT NULL,
    storage_box_fk bigint,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 184 (class 1259 OID 81196)
-- Name: dna_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dna_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2761 (class 0 OID 0)
-- Dependencies: 184
-- Name: dna_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dna_id_seq OWNED BY dna.id;


--
-- TOC entry 182 (class 1259 OID 81191)
-- Name: dna_is_extracted_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dna_is_extracted_by (
    id bigint NOT NULL,
    dna_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 183 (class 1259 OID 81194)
-- Name: dna_is_extracted_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dna_is_extracted_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2762 (class 0 OID 0)
-- Dependencies: 183
-- Name: dna_is_extracted_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dna_is_extracted_by_id_seq OWNED BY dna_is_extracted_by.id;


--
-- TOC entry 220 (class 1259 OID 81316)
-- Name: external_biological_material; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_biological_material (
    id bigint NOT NULL,
    external_biological_material_code character varying(255) NOT NULL,
    external_biological_material_creation_date date,
    external_biological_material_comments text,
    number_of_specimens_comments text,
    sampling_fk bigint NOT NULL,
    date_precision_voc_fk bigint NOT NULL,
    number_of_specimens_voc_fk bigint NOT NULL,
    pigmentation_voc_fk bigint NOT NULL,
    eyes_voc_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 225 (class 1259 OID 81332)
-- Name: external_biological_material_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_biological_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2763 (class 0 OID 0)
-- Dependencies: 225
-- Name: external_biological_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_biological_material_id_seq OWNED BY external_biological_material.id;


--
-- TOC entry 221 (class 1259 OID 81322)
-- Name: external_biological_material_is_processed_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_biological_material_is_processed_by (
    id bigint NOT NULL,
    person_fk bigint NOT NULL,
    external_biological_material_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 222 (class 1259 OID 81325)
-- Name: external_biological_material_is_processed_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_biological_material_is_processed_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2764 (class 0 OID 0)
-- Dependencies: 222
-- Name: external_biological_material_is_processed_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_biological_material_is_processed_by_id_seq OWNED BY external_biological_material_is_processed_by.id;


--
-- TOC entry 223 (class 1259 OID 81327)
-- Name: external_biological_material_is_published_in; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_biological_material_is_published_in (
    id bigint NOT NULL,
    external_biological_material_fk bigint NOT NULL,
    source_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 224 (class 1259 OID 81330)
-- Name: external_biological_material_is_published_in_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_biological_material_is_published_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2765 (class 0 OID 0)
-- Dependencies: 224
-- Name: external_biological_material_is_published_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_biological_material_is_published_in_id_seq OWNED BY external_biological_material_is_published_in.id;


--
-- TOC entry 246 (class 1259 OID 81405)
-- Name: external_sequence; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_sequence (
    id bigint NOT NULL,
    external_sequence_code character varying(1024) NOT NULL,
    external_sequence_creation_date date,
    external_sequence_accession_number character varying(255) NOT NULL,
    external_sequence_alignment_code character varying(1024),
    external_sequence_specimen_number character varying(255) NOT NULL,
    external_sequence_primary_taxon character varying(255),
    external_sequence_comments text,
    gene_voc_fk bigint NOT NULL,
    date_precision_voc_fk bigint NOT NULL,
    external_sequence_origin_voc_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    external_sequence_status_voc_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 247 (class 1259 OID 81411)
-- Name: external_sequence_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_sequence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2766 (class 0 OID 0)
-- Dependencies: 247
-- Name: external_sequence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_sequence_id_seq OWNED BY external_sequence.id;


--
-- TOC entry 255 (class 1259 OID 81433)
-- Name: external_sequence_is_entered_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_sequence_is_entered_by (
    id bigint NOT NULL,
    external_sequence_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 256 (class 1259 OID 81436)
-- Name: external_sequence_is_entered_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_sequence_is_entered_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2767 (class 0 OID 0)
-- Dependencies: 256
-- Name: external_sequence_is_entered_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_sequence_is_entered_by_id_seq OWNED BY external_sequence_is_entered_by.id;


--
-- TOC entry 257 (class 1259 OID 81438)
-- Name: external_sequence_is_published_in; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE external_sequence_is_published_in (
    id bigint NOT NULL,
    source_fk bigint NOT NULL,
    external_sequence_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 258 (class 1259 OID 81441)
-- Name: external_sequence_is_published_in_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE external_sequence_is_published_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2768 (class 0 OID 0)
-- Dependencies: 258
-- Name: external_sequence_is_published_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE external_sequence_is_published_in_id_seq OWNED BY external_sequence_is_published_in.id;


--
-- TOC entry 175 (class 1259 OID 81170)
-- Name: has_targeted_taxa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE has_targeted_taxa (
    id bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    taxon_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 176 (class 1259 OID 81173)
-- Name: has_targeted_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE has_targeted_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2769 (class 0 OID 0)
-- Dependencies: 176
-- Name: has_targeted_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE has_targeted_taxa_id_seq OWNED BY has_targeted_taxa.id;


--
-- TOC entry 197 (class 1259 OID 81243)
-- Name: identified_species; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE identified_species (
    id bigint NOT NULL,
    identification_date date,
    identified_species_comments text,
    identification_criterion_voc_fk bigint NOT NULL,
    date_precision_voc_fk bigint NOT NULL,
    external_sequence_fk bigint,
    external_biological_material_fk bigint,
    internal_biological_material_fk bigint,
    taxon_fk bigint NOT NULL,
    specimen_fk bigint,
    internal_sequence_fk bigint,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint,
    type_material_voc_fk bigint
);


--
-- TOC entry 198 (class 1259 OID 81249)
-- Name: identified_species_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identified_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2770 (class 0 OID 0)
-- Dependencies: 198
-- Name: identified_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identified_species_id_seq OWNED BY identified_species.id;


--
-- TOC entry 207 (class 1259 OID 81271)
-- Name: institution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE institution (
    id bigint NOT NULL,
    institution_name character varying(1024) NOT NULL,
    institution_comments text,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 208 (class 1259 OID 81277)
-- Name: institution_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE institution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2771 (class 0 OID 0)
-- Dependencies: 208
-- Name: institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE institution_id_seq OWNED BY institution.id;


--
-- TOC entry 217 (class 1259 OID 81305)
-- Name: internal_biological_material; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_biological_material (
    id bigint NOT NULL,
    internal_biological_material_code character varying(255) NOT NULL,
    internal_biological_material_date date,
    sequencing_advice text,
    internal_biological_material_comments text,
    internal_biological_material_status smallint NOT NULL,
    date_precision_voc_fk bigint NOT NULL,
    pigmentation_voc_fk bigint NOT NULL,
    eyes_voc_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    storage_box_fk bigint,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 226 (class 1259 OID 81334)
-- Name: internal_biological_material_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_biological_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2772 (class 0 OID 0)
-- Dependencies: 226
-- Name: internal_biological_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_biological_material_id_seq OWNED BY internal_biological_material.id;


--
-- TOC entry 215 (class 1259 OID 81300)
-- Name: internal_biological_material_is_published_in; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_biological_material_is_published_in (
    id bigint NOT NULL,
    internal_biological_material_fk bigint NOT NULL,
    source_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 216 (class 1259 OID 81303)
-- Name: internal_biological_material_is_published_in_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_biological_material_is_published_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2773 (class 0 OID 0)
-- Dependencies: 216
-- Name: internal_biological_material_is_published_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_biological_material_is_published_in_id_seq OWNED BY internal_biological_material_is_published_in.id;


--
-- TOC entry 218 (class 1259 OID 81311)
-- Name: internal_biological_material_is_treated_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_biological_material_is_treated_by (
    id bigint NOT NULL,
    internal_biological_material_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 219 (class 1259 OID 81314)
-- Name: internal_biological_material_is_treated_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_biological_material_is_treated_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2774 (class 0 OID 0)
-- Dependencies: 219
-- Name: internal_biological_material_is_treated_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_biological_material_is_treated_by_id_seq OWNED BY internal_biological_material_is_treated_by.id;


--
-- TOC entry 243 (class 1259 OID 81394)
-- Name: internal_sequence; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_sequence (
    id bigint NOT NULL,
    internal_sequence_code character varying(1024) NOT NULL,
    internal_sequence_creation_date date,
    internal_sequence_accession_number character varying(255),
    internal_sequence_alignment_code character varying(1024),
    internal_sequence_comments text,
    date_precision_voc_fk bigint NOT NULL,
    internal_sequence_status_voc_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 248 (class 1259 OID 81413)
-- Name: internal_sequence_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_sequence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2775 (class 0 OID 0)
-- Dependencies: 248
-- Name: internal_sequence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_sequence_id_seq OWNED BY internal_sequence.id;


--
-- TOC entry 244 (class 1259 OID 81400)
-- Name: internal_sequence_is_assembled_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_sequence_is_assembled_by (
    id bigint NOT NULL,
    internal_sequence_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 245 (class 1259 OID 81403)
-- Name: internal_sequence_is_assembled_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_sequence_is_assembled_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2776 (class 0 OID 0)
-- Dependencies: 245
-- Name: internal_sequence_is_assembled_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_sequence_is_assembled_by_id_seq OWNED BY internal_sequence_is_assembled_by.id;


--
-- TOC entry 253 (class 1259 OID 81428)
-- Name: internal_sequence_is_published_in; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE internal_sequence_is_published_in (
    id bigint NOT NULL,
    source_fk bigint NOT NULL,
    internal_sequence_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 254 (class 1259 OID 81431)
-- Name: internal_sequence_is_published_in_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE internal_sequence_is_published_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2777 (class 0 OID 0)
-- Dependencies: 254
-- Name: internal_sequence_is_published_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE internal_sequence_is_published_in_id_seq OWNED BY internal_sequence_is_published_in.id;


--
-- TOC entry 227 (class 1259 OID 81336)
-- Name: motu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE motu (
    id bigint NOT NULL,
    csv_file_name character varying(1024) NOT NULL,
    motu_date date NOT NULL,
    motu_comments text,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint,
    motu_title character varying(255) NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 81347)
-- Name: motu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE motu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2778 (class 0 OID 0)
-- Dependencies: 230
-- Name: motu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE motu_id_seq OWNED BY motu.id;


--
-- TOC entry 228 (class 1259 OID 81342)
-- Name: motu_is_generated_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE motu_is_generated_by (
    id bigint NOT NULL,
    motu_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 229 (class 1259 OID 81345)
-- Name: motu_is_generated_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE motu_is_generated_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2779 (class 0 OID 0)
-- Dependencies: 229
-- Name: motu_is_generated_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE motu_is_generated_by_id_seq OWNED BY motu_is_generated_by.id;


--
-- TOC entry 185 (class 1259 OID 81198)
-- Name: motu_number; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE motu_number (
    id bigint NOT NULL,
    motu_number bigint NOT NULL,
    external_sequence_fk bigint,
    delimitation_method_voc_fk bigint NOT NULL,
    internal_sequence_fk bigint,
    motu_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 186 (class 1259 OID 81201)
-- Name: motu_number_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE motu_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2780 (class 0 OID 0)
-- Dependencies: 186
-- Name: motu_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE motu_number_id_seq OWNED BY motu_number.id;


--
-- TOC entry 193 (class 1259 OID 81227)
-- Name: municipality; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE municipality (
    id bigint NOT NULL,
    municipality_code character varying(255) NOT NULL,
    municipality_name character varying(1024) NOT NULL,
    region_name character varying(1024) NOT NULL,
    country_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 194 (class 1259 OID 81233)
-- Name: municipality_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE municipality_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2781 (class 0 OID 0)
-- Dependencies: 194
-- Name: municipality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE municipality_id_seq OWNED BY municipality.id;


--
-- TOC entry 233 (class 1259 OID 81357)
-- Name: pcr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pcr (
    id bigint NOT NULL,
    pcr_code character varying(255) NOT NULL,
    pcr_number character varying(255) NOT NULL,
    pcr_date date,
    pcr_details text,
    pcr_comments text,
    gene_voc_fk bigint NOT NULL,
    pcr_quality_voc_fk bigint NOT NULL,
    pcr_specificity_voc_fk bigint NOT NULL,
    forward_primer_voc_fk bigint NOT NULL,
    reverse_primer_voc_fk bigint NOT NULL,
    date_precision_voc_fk bigint NOT NULL,
    dna_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 236 (class 1259 OID 81368)
-- Name: pcr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pcr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2782 (class 0 OID 0)
-- Dependencies: 236
-- Name: pcr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pcr_id_seq OWNED BY pcr.id;


--
-- TOC entry 234 (class 1259 OID 81363)
-- Name: pcr_is_done_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pcr_is_done_by (
    id bigint NOT NULL,
    pcr_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 235 (class 1259 OID 81366)
-- Name: pcr_is_done_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pcr_is_done_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2783 (class 0 OID 0)
-- Dependencies: 235
-- Name: pcr_is_done_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pcr_is_done_by_id_seq OWNED BY pcr_is_done_by.id;


--
-- TOC entry 237 (class 1259 OID 81370)
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person (
    id bigint NOT NULL,
    person_name character varying(255) NOT NULL,
    person_full_name character varying(1024),
    person_name_bis character varying(255),
    person_comments text,
    institution_fk bigint,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 238 (class 1259 OID 81376)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2784 (class 0 OID 0)
-- Dependencies: 238
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE person_id_seq OWNED BY person.id;


--
-- TOC entry 239 (class 1259 OID 81378)
-- Name: program; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE program (
    id bigint NOT NULL,
    program_code character varying(255) NOT NULL,
    program_name character varying(1024) NOT NULL,
    coordinator_names text NOT NULL,
    funding_agency character varying(1024),
    starting_year bigint,
    ending_year bigint,
    program_comments text,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 240 (class 1259 OID 81384)
-- Name: program_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2785 (class 0 OID 0)
-- Dependencies: 240
-- Name: program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE program_id_seq OWNED BY program.id;


--
-- TOC entry 177 (class 1259 OID 81175)
-- Name: sample_is_fixed_with; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sample_is_fixed_with (
    id bigint NOT NULL,
    fixative_voc_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 178 (class 1259 OID 81178)
-- Name: sample_is_fixed_with_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_is_fixed_with_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2786 (class 0 OID 0)
-- Dependencies: 178
-- Name: sample_is_fixed_with_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sample_is_fixed_with_id_seq OWNED BY sample_is_fixed_with.id;


--
-- TOC entry 191 (class 1259 OID 81219)
-- Name: sampling; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sampling (
    id bigint NOT NULL,
    sample_code character varying(255) NOT NULL,
    date_collecte date,
    sampling_duration bigint,
    temperature double precision,
    specific_conductance double precision,
    sample_status smallint NOT NULL,
    sampling_comments text,
    date_precision_voc_fk bigint NOT NULL,
    donation_voc_fk bigint NOT NULL,
    site_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 192 (class 1259 OID 81225)
-- Name: sampling_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sampling_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2787 (class 0 OID 0)
-- Dependencies: 192
-- Name: sampling_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sampling_id_seq OWNED BY sampling.id;


--
-- TOC entry 179 (class 1259 OID 81180)
-- Name: sampling_is_done_with_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sampling_is_done_with_method (
    id bigint NOT NULL,
    sampling_method_voc_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 180 (class 1259 OID 81183)
-- Name: sampling_is_done_with_method_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sampling_is_done_with_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2788 (class 0 OID 0)
-- Dependencies: 180
-- Name: sampling_is_done_with_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sampling_is_done_with_method_id_seq OWNED BY sampling_is_done_with_method.id;


--
-- TOC entry 203 (class 1259 OID 81261)
-- Name: sampling_is_funded_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sampling_is_funded_by (
    id bigint NOT NULL,
    program_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 204 (class 1259 OID 81264)
-- Name: sampling_is_funded_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sampling_is_funded_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2789 (class 0 OID 0)
-- Dependencies: 204
-- Name: sampling_is_funded_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sampling_is_funded_by_id_seq OWNED BY sampling_is_funded_by.id;


--
-- TOC entry 201 (class 1259 OID 81256)
-- Name: sampling_is_performed_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sampling_is_performed_by (
    id bigint NOT NULL,
    person_fk bigint NOT NULL,
    sampling_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 202 (class 1259 OID 81259)
-- Name: sampling_is_performed_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sampling_is_performed_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2790 (class 0 OID 0)
-- Dependencies: 202
-- Name: sampling_is_performed_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sampling_is_performed_by_id_seq OWNED BY sampling_is_performed_by.id;


--
-- TOC entry 259 (class 1259 OID 81443)
-- Name: site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE site (
    id bigint NOT NULL,
    site_code character varying(255) NOT NULL,
    site_name character varying(1024) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    elevation bigint,
    location_info text,
    site_description text,
    site_comments text,
    municipality_fk bigint NOT NULL,
    country_fk bigint NOT NULL,
    access_point_voc_fk bigint NOT NULL,
    habitat_type_voc_fk bigint NOT NULL,
    coordinate_precision_voc_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 260 (class 1259 OID 81449)
-- Name: site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2791 (class 0 OID 0)
-- Dependencies: 260
-- Name: site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE site_id_seq OWNED BY site.id;


--
-- TOC entry 212 (class 1259 OID 81293)
-- Name: slide_is_mounted_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE slide_is_mounted_by (
    id bigint NOT NULL,
    specimen_slide_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 213 (class 1259 OID 81296)
-- Name: slide_is_mounted_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE slide_is_mounted_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2792 (class 0 OID 0)
-- Dependencies: 213
-- Name: slide_is_mounted_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE slide_is_mounted_by_id_seq OWNED BY slide_is_mounted_by.id;


--
-- TOC entry 249 (class 1259 OID 81415)
-- Name: source; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE source (
    id bigint NOT NULL,
    source_code character varying(255) NOT NULL,
    source_year bigint,
    source_title character varying(2048) NOT NULL,
    source_comments text,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 252 (class 1259 OID 81426)
-- Name: source_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2793 (class 0 OID 0)
-- Dependencies: 252
-- Name: source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE source_id_seq OWNED BY source.id;


--
-- TOC entry 250 (class 1259 OID 81421)
-- Name: source_is_entered_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE source_is_entered_by (
    id bigint NOT NULL,
    source_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 251 (class 1259 OID 81424)
-- Name: source_is_entered_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE source_is_entered_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2794 (class 0 OID 0)
-- Dependencies: 251
-- Name: source_is_entered_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE source_is_entered_by_id_seq OWNED BY source_is_entered_by.id;


--
-- TOC entry 205 (class 1259 OID 81266)
-- Name: species_is_identified_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE species_is_identified_by (
    id bigint NOT NULL,
    identified_species_fk bigint NOT NULL,
    person_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 206 (class 1259 OID 81269)
-- Name: species_is_identified_by_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE species_is_identified_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2795 (class 0 OID 0)
-- Dependencies: 206
-- Name: species_is_identified_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE species_is_identified_by_id_seq OWNED BY species_is_identified_by.id;


--
-- TOC entry 209 (class 1259 OID 81279)
-- Name: specimen; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE specimen (
    id bigint NOT NULL,
    specimen_molecular_code character varying(255),
    specimen_morphological_code character varying(255) NOT NULL,
    tube_code character varying(255) NOT NULL,
    specimen_molecular_number character varying(255),
    specimen_comments text,
    specimen_type_voc_fk bigint NOT NULL,
    internal_biological_material_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 210 (class 1259 OID 81285)
-- Name: specimen_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specimen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2796 (class 0 OID 0)
-- Dependencies: 210
-- Name: specimen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specimen_id_seq OWNED BY specimen.id;


--
-- TOC entry 211 (class 1259 OID 81287)
-- Name: specimen_slide; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE specimen_slide (
    id bigint NOT NULL,
    collection_slide_code character varying(255) NOT NULL,
    slide_title character varying(1024) NOT NULL,
    slide_date date,
    photo_folder_name character varying(1024),
    slide_comments text,
    date_precision_voc_fk bigint NOT NULL,
    storage_box_fk bigint,
    specimen_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 214 (class 1259 OID 81298)
-- Name: specimen_slide_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE specimen_slide_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2797 (class 0 OID 0)
-- Dependencies: 214
-- Name: specimen_slide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE specimen_slide_id_seq OWNED BY specimen_slide.id;


--
-- TOC entry 187 (class 1259 OID 81203)
-- Name: storage_box; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE storage_box (
    id bigint NOT NULL,
    box_code character varying(255) NOT NULL,
    box_title character varying(1024) NOT NULL,
    box_comments text,
    collection_type_voc_fk bigint NOT NULL,
    collection_code_voc_fk bigint NOT NULL,
    box_type_voc_fk bigint NOT NULL,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 188 (class 1259 OID 81209)
-- Name: storage_box_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE storage_box_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2798 (class 0 OID 0)
-- Dependencies: 188
-- Name: storage_box_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE storage_box_id_seq OWNED BY storage_box.id;


--
-- TOC entry 241 (class 1259 OID 81386)
-- Name: taxon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taxon (
    id bigint NOT NULL,
    taxon_name character varying(255) NOT NULL,
    taxon_rank character varying(255) NOT NULL,
    subclass character varying(255),
    taxon_order character varying(255),
    family character varying(255),
    genus character varying(255),
    species character varying(255),
    subspecies character varying(255),
    taxon_validity smallint NOT NULL,
    taxon_code character varying(255) NOT NULL,
    taxon_comments text,
    clade character varying(255),
    taxon_synonym character varying(255),
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint,
    taxon_full_name character varying(255)
);


--
-- TOC entry 242 (class 1259 OID 81392)
-- Name: taxon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2799 (class 0 OID 0)
-- Dependencies: 242
-- Name: taxon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_id_seq OWNED BY taxon.id;


--
-- TOC entry 261 (class 1259 OID 81451)
-- Name: user_db; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_db (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) DEFAULT NULL::character varying,
    role character varying(255) NOT NULL,
    salt character varying(255) DEFAULT NULL::character varying,
    name character varying(255) NOT NULL,
    institution character varying(255) DEFAULT NULL::character varying,
    date_of_creation timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    date_of_update timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint,
    is_active smallint NOT NULL,
    user_comments text
);


--
-- TOC entry 262 (class 1259 OID 81462)
-- Name: user_db_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_db_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2800 (class 0 OID 0)
-- Dependencies: 262
-- Name: user_db_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_db_id_seq OWNED BY user_db.id;


--
-- TOC entry 263 (class 1259 OID 81464)
-- Name: vocabulary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE vocabulary (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    vocabulary_title character varying(1024) NOT NULL,
    parent character varying(255) NOT NULL,
    voc_comments text,
    date_of_creation timestamp without time zone,
    date_of_update timestamp without time zone,
    creation_user_name bigint,
    update_user_name bigint
);


--
-- TOC entry 264 (class 1259 OID 81470)
-- Name: vocabulary_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vocabulary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2801 (class 0 OID 0)
-- Dependencies: 264
-- Name: vocabulary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vocabulary_id_seq OWNED BY vocabulary.id;


--
-- TOC entry 2243 (class 2604 OID 81479)
-- Name: chromatogram id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram ALTER COLUMN id SET DEFAULT nextval('chromatogram_id_seq'::regclass);


--
-- TOC entry 2248 (class 2604 OID 81484)
-- Name: chromatogram_is_processed_to id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram_is_processed_to ALTER COLUMN id SET DEFAULT nextval('chromatogram_is_processed_to_id_seq'::regclass);


--
-- TOC entry 2246 (class 2604 OID 81482)
-- Name: composition_of_internal_biological_material id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY composition_of_internal_biological_material ALTER COLUMN id SET DEFAULT nextval('composition_of_internal_biological_material_id_seq'::regclass);


--
-- TOC entry 2264 (class 2604 OID 81500)
-- Name: country id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY country ALTER COLUMN id SET DEFAULT nextval('country_id_seq'::regclass);


--
-- TOC entry 2239 (class 2604 OID 81475)
-- Name: dna id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna ALTER COLUMN id SET DEFAULT nextval('dna_id_seq'::regclass);


--
-- TOC entry 2240 (class 2604 OID 81476)
-- Name: dna_is_extracted_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna_is_extracted_by ALTER COLUMN id SET DEFAULT nextval('dna_is_extracted_by_id_seq'::regclass);


--
-- TOC entry 2259 (class 2604 OID 81495)
-- Name: external_biological_material id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material ALTER COLUMN id SET DEFAULT nextval('external_biological_material_id_seq'::regclass);


--
-- TOC entry 2260 (class 2604 OID 81496)
-- Name: external_biological_material_is_processed_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_processed_by ALTER COLUMN id SET DEFAULT nextval('external_biological_material_is_processed_by_id_seq'::regclass);


--
-- TOC entry 2261 (class 2604 OID 81497)
-- Name: external_biological_material_is_published_in id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_published_in ALTER COLUMN id SET DEFAULT nextval('external_biological_material_is_published_in_id_seq'::regclass);


--
-- TOC entry 2272 (class 2604 OID 81508)
-- Name: external_sequence id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence ALTER COLUMN id SET DEFAULT nextval('external_sequence_id_seq'::regclass);


--
-- TOC entry 2276 (class 2604 OID 81512)
-- Name: external_sequence_is_entered_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_entered_by ALTER COLUMN id SET DEFAULT nextval('external_sequence_is_entered_by_id_seq'::regclass);


--
-- TOC entry 2277 (class 2604 OID 81513)
-- Name: external_sequence_is_published_in id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_published_in ALTER COLUMN id SET DEFAULT nextval('external_sequence_is_published_in_id_seq'::regclass);


--
-- TOC entry 2236 (class 2604 OID 81472)
-- Name: has_targeted_taxa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY has_targeted_taxa ALTER COLUMN id SET DEFAULT nextval('has_targeted_taxa_id_seq'::regclass);


--
-- TOC entry 2247 (class 2604 OID 81483)
-- Name: identified_species id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species ALTER COLUMN id SET DEFAULT nextval('identified_species_id_seq'::regclass);


--
-- TOC entry 2252 (class 2604 OID 81488)
-- Name: institution id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY institution ALTER COLUMN id SET DEFAULT nextval('institution_id_seq'::regclass);


--
-- TOC entry 2257 (class 2604 OID 81493)
-- Name: internal_biological_material id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material ALTER COLUMN id SET DEFAULT nextval('internal_biological_material_id_seq'::regclass);


--
-- TOC entry 2256 (class 2604 OID 81492)
-- Name: internal_biological_material_is_published_in id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_published_in ALTER COLUMN id SET DEFAULT nextval('internal_biological_material_is_published_in_id_seq'::regclass);


--
-- TOC entry 2258 (class 2604 OID 81494)
-- Name: internal_biological_material_is_treated_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_treated_by ALTER COLUMN id SET DEFAULT nextval('internal_biological_material_is_treated_by_id_seq'::regclass);


--
-- TOC entry 2270 (class 2604 OID 81506)
-- Name: internal_sequence id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence ALTER COLUMN id SET DEFAULT nextval('internal_sequence_id_seq'::regclass);


--
-- TOC entry 2271 (class 2604 OID 81507)
-- Name: internal_sequence_is_assembled_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_assembled_by ALTER COLUMN id SET DEFAULT nextval('internal_sequence_is_assembled_by_id_seq'::regclass);


--
-- TOC entry 2275 (class 2604 OID 81511)
-- Name: internal_sequence_is_published_in id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_published_in ALTER COLUMN id SET DEFAULT nextval('internal_sequence_is_published_in_id_seq'::regclass);


--
-- TOC entry 2262 (class 2604 OID 81498)
-- Name: motu id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu ALTER COLUMN id SET DEFAULT nextval('motu_id_seq'::regclass);


--
-- TOC entry 2263 (class 2604 OID 81499)
-- Name: motu_is_generated_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_is_generated_by ALTER COLUMN id SET DEFAULT nextval('motu_is_generated_by_id_seq'::regclass);


--
-- TOC entry 2241 (class 2604 OID 81477)
-- Name: motu_number id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number ALTER COLUMN id SET DEFAULT nextval('motu_number_id_seq'::regclass);


--
-- TOC entry 2245 (class 2604 OID 81481)
-- Name: municipality id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipality ALTER COLUMN id SET DEFAULT nextval('municipality_id_seq'::regclass);


--
-- TOC entry 2265 (class 2604 OID 81501)
-- Name: pcr id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr ALTER COLUMN id SET DEFAULT nextval('pcr_id_seq'::regclass);


--
-- TOC entry 2266 (class 2604 OID 81502)
-- Name: pcr_is_done_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr_is_done_by ALTER COLUMN id SET DEFAULT nextval('pcr_is_done_by_id_seq'::regclass);


--
-- TOC entry 2267 (class 2604 OID 81503)
-- Name: person id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- TOC entry 2268 (class 2604 OID 81504)
-- Name: program id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY program ALTER COLUMN id SET DEFAULT nextval('program_id_seq'::regclass);


--
-- TOC entry 2237 (class 2604 OID 81473)
-- Name: sample_is_fixed_with id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_is_fixed_with ALTER COLUMN id SET DEFAULT nextval('sample_is_fixed_with_id_seq'::regclass);


--
-- TOC entry 2244 (class 2604 OID 81480)
-- Name: sampling id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling ALTER COLUMN id SET DEFAULT nextval('sampling_id_seq'::regclass);


--
-- TOC entry 2238 (class 2604 OID 81474)
-- Name: sampling_is_done_with_method id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_done_with_method ALTER COLUMN id SET DEFAULT nextval('sampling_is_done_with_method_id_seq'::regclass);


--
-- TOC entry 2250 (class 2604 OID 81486)
-- Name: sampling_is_funded_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_funded_by ALTER COLUMN id SET DEFAULT nextval('sampling_is_funded_by_id_seq'::regclass);


--
-- TOC entry 2249 (class 2604 OID 81485)
-- Name: sampling_is_performed_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_performed_by ALTER COLUMN id SET DEFAULT nextval('sampling_is_performed_by_id_seq'::regclass);


--
-- TOC entry 2278 (class 2604 OID 81514)
-- Name: site id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY site ALTER COLUMN id SET DEFAULT nextval('site_id_seq'::regclass);


--
-- TOC entry 2255 (class 2604 OID 81491)
-- Name: slide_is_mounted_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY slide_is_mounted_by ALTER COLUMN id SET DEFAULT nextval('slide_is_mounted_by_id_seq'::regclass);


--
-- TOC entry 2273 (class 2604 OID 81509)
-- Name: source id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY source ALTER COLUMN id SET DEFAULT nextval('source_id_seq'::regclass);


--
-- TOC entry 2274 (class 2604 OID 81510)
-- Name: source_is_entered_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY source_is_entered_by ALTER COLUMN id SET DEFAULT nextval('source_is_entered_by_id_seq'::regclass);


--
-- TOC entry 2251 (class 2604 OID 81487)
-- Name: species_is_identified_by id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY species_is_identified_by ALTER COLUMN id SET DEFAULT nextval('species_is_identified_by_id_seq'::regclass);


--
-- TOC entry 2253 (class 2604 OID 81489)
-- Name: specimen id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen ALTER COLUMN id SET DEFAULT nextval('specimen_id_seq'::regclass);


--
-- TOC entry 2254 (class 2604 OID 81490)
-- Name: specimen_slide id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide ALTER COLUMN id SET DEFAULT nextval('specimen_slide_id_seq'::regclass);


--
-- TOC entry 2242 (class 2604 OID 81478)
-- Name: storage_box id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box ALTER COLUMN id SET DEFAULT nextval('storage_box_id_seq'::regclass);


--
-- TOC entry 2269 (class 2604 OID 81505)
-- Name: taxon id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon ALTER COLUMN id SET DEFAULT nextval('taxon_id_seq'::regclass);


--
-- TOC entry 2284 (class 2604 OID 81515)
-- Name: user_db id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_db ALTER COLUMN id SET DEFAULT nextval('user_db_id_seq'::regclass);


--
-- TOC entry 2285 (class 2604 OID 81516)
-- Name: vocabulary id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vocabulary ALTER COLUMN id SET DEFAULT nextval('vocabulary_id_seq'::regclass);


--
-- TOC entry 2329 (class 2606 OID 81532)
-- Name: chromatogram pk_chromatogram; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT pk_chromatogram PRIMARY KEY (id);


--
-- TOC entry 2362 (class 2606 OID 81542)
-- Name: chromatogram_is_processed_to pk_chromatogram_is_processed_to; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram_is_processed_to
    ADD CONSTRAINT pk_chromatogram_is_processed_to PRIMARY KEY (id);


--
-- TOC entry 2347 (class 2606 OID 81538)
-- Name: composition_of_internal_biological_material pk_composition_of_internal_biological_material; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composition_of_internal_biological_material
    ADD CONSTRAINT pk_composition_of_internal_biological_material PRIMARY KEY (id);


--
-- TOC entry 2439 (class 2606 OID 81574)
-- Name: country pk_country; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY country
    ADD CONSTRAINT pk_country PRIMARY KEY (id);


--
-- TOC entry 2304 (class 2606 OID 81524)
-- Name: dna pk_dna; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT pk_dna PRIMARY KEY (id);


--
-- TOC entry 2310 (class 2606 OID 81526)
-- Name: dna_is_extracted_by pk_dna_is_extracted_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna_is_extracted_by
    ADD CONSTRAINT pk_dna_is_extracted_by PRIMARY KEY (id);


--
-- TOC entry 2421 (class 2606 OID 81564)
-- Name: external_biological_material pk_external_biological_material; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT pk_external_biological_material PRIMARY KEY (id);


--
-- TOC entry 2427 (class 2606 OID 81566)
-- Name: external_biological_material_is_processed_by pk_external_biological_material_is_processed_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_processed_by
    ADD CONSTRAINT pk_external_biological_material_is_processed_by PRIMARY KEY (id);


--
-- TOC entry 2431 (class 2606 OID 81568)
-- Name: external_biological_material_is_published_in pk_external_biological_material_is_published_in; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_published_in
    ADD CONSTRAINT pk_external_biological_material_is_published_in PRIMARY KEY (id);


--
-- TOC entry 2490 (class 2606 OID 81590)
-- Name: external_sequence pk_external_sequence; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT pk_external_sequence PRIMARY KEY (id);


--
-- TOC entry 2510 (class 2606 OID 81598)
-- Name: external_sequence_is_entered_by pk_external_sequence_is_entered_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_entered_by
    ADD CONSTRAINT pk_external_sequence_is_entered_by PRIMARY KEY (id);


--
-- TOC entry 2514 (class 2606 OID 81600)
-- Name: external_sequence_is_published_in pk_external_sequence_is_published_in; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_published_in
    ADD CONSTRAINT pk_external_sequence_is_published_in PRIMARY KEY (id);


--
-- TOC entry 2289 (class 2606 OID 81518)
-- Name: has_targeted_taxa pk_has_targeted_taxa; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY has_targeted_taxa
    ADD CONSTRAINT pk_has_targeted_taxa PRIMARY KEY (id);


--
-- TOC entry 2358 (class 2606 OID 81540)
-- Name: identified_species pk_identified_species; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT pk_identified_species PRIMARY KEY (id);


--
-- TOC entry 2376 (class 2606 OID 81550)
-- Name: institution pk_institution; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT pk_institution PRIMARY KEY (id);


--
-- TOC entry 2408 (class 2606 OID 81560)
-- Name: internal_biological_material pk_internal_biological_material; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT pk_internal_biological_material PRIMARY KEY (id);


--
-- TOC entry 2401 (class 2606 OID 81558)
-- Name: internal_biological_material_is_published_in pk_internal_biological_material_is_published_in; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_published_in
    ADD CONSTRAINT pk_internal_biological_material_is_published_in PRIMARY KEY (id);


--
-- TOC entry 2414 (class 2606 OID 81562)
-- Name: internal_biological_material_is_treated_by pk_internal_biological_material_is_treated_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_treated_by
    ADD CONSTRAINT pk_internal_biological_material_is_treated_by PRIMARY KEY (id);


--
-- TOC entry 2475 (class 2606 OID 81586)
-- Name: internal_sequence pk_internal_sequence; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence
    ADD CONSTRAINT pk_internal_sequence PRIMARY KEY (id);


--
-- TOC entry 2483 (class 2606 OID 81588)
-- Name: internal_sequence_is_assembled_by pk_internal_sequence_is_assembled_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_assembled_by
    ADD CONSTRAINT pk_internal_sequence_is_assembled_by PRIMARY KEY (id);


--
-- TOC entry 2506 (class 2606 OID 81596)
-- Name: internal_sequence_is_published_in pk_internal_sequence_is_published_in; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_published_in
    ADD CONSTRAINT pk_internal_sequence_is_published_in PRIMARY KEY (id);


--
-- TOC entry 2433 (class 2606 OID 81570)
-- Name: motu pk_motu; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu
    ADD CONSTRAINT pk_motu PRIMARY KEY (id);


--
-- TOC entry 2437 (class 2606 OID 81572)
-- Name: motu_is_generated_by pk_motu_is_generated_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_is_generated_by
    ADD CONSTRAINT pk_motu_is_generated_by PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 81528)
-- Name: motu_number pk_motu_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number
    ADD CONSTRAINT pk_motu_number PRIMARY KEY (id);


--
-- TOC entry 2341 (class 2606 OID 81536)
-- Name: municipality pk_municipality; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipality
    ADD CONSTRAINT pk_municipality PRIMARY KEY (id);


--
-- TOC entry 2450 (class 2606 OID 81576)
-- Name: pcr pk_pcr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT pk_pcr PRIMARY KEY (id);


--
-- TOC entry 2456 (class 2606 OID 81578)
-- Name: pcr_is_done_by pk_pcr_is_done_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr_is_done_by
    ADD CONSTRAINT pk_pcr_is_done_by PRIMARY KEY (id);


--
-- TOC entry 2459 (class 2606 OID 81580)
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pk_person PRIMARY KEY (id);


--
-- TOC entry 2463 (class 2606 OID 81582)
-- Name: program pk_program; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY program
    ADD CONSTRAINT pk_program PRIMARY KEY (id);


--
-- TOC entry 2293 (class 2606 OID 81520)
-- Name: sample_is_fixed_with pk_sample_is_fixed_with; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_is_fixed_with
    ADD CONSTRAINT pk_sample_is_fixed_with PRIMARY KEY (id);


--
-- TOC entry 2336 (class 2606 OID 81534)
-- Name: sampling pk_sampling; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling
    ADD CONSTRAINT pk_sampling PRIMARY KEY (id);


--
-- TOC entry 2297 (class 2606 OID 81522)
-- Name: sampling_is_done_with_method pk_sampling_is_done_with_method; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_done_with_method
    ADD CONSTRAINT pk_sampling_is_done_with_method PRIMARY KEY (id);


--
-- TOC entry 2370 (class 2606 OID 81546)
-- Name: sampling_is_funded_by pk_sampling_is_funded_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_funded_by
    ADD CONSTRAINT pk_sampling_is_funded_by PRIMARY KEY (id);


--
-- TOC entry 2366 (class 2606 OID 81544)
-- Name: sampling_is_performed_by pk_sampling_is_performed_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_performed_by
    ADD CONSTRAINT pk_sampling_is_performed_by PRIMARY KEY (id);


--
-- TOC entry 2521 (class 2606 OID 81602)
-- Name: site pk_site; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT pk_site PRIMARY KEY (id);


--
-- TOC entry 2397 (class 2606 OID 81556)
-- Name: slide_is_mounted_by pk_slide_is_mounted_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY slide_is_mounted_by
    ADD CONSTRAINT pk_slide_is_mounted_by PRIMARY KEY (id);


--
-- TOC entry 2496 (class 2606 OID 81594)
-- Name: source pk_source; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source
    ADD CONSTRAINT pk_source PRIMARY KEY (id);


--
-- TOC entry 2502 (class 2606 OID 81592)
-- Name: source_is_entered_by pk_source_is_entered_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source_is_entered_by
    ADD CONSTRAINT pk_source_is_entered_by PRIMARY KEY (id);


--
-- TOC entry 2374 (class 2606 OID 81548)
-- Name: species_is_identified_by pk_species_is_identified_by; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY species_is_identified_by
    ADD CONSTRAINT pk_species_is_identified_by PRIMARY KEY (id);


--
-- TOC entry 2382 (class 2606 OID 81552)
-- Name: specimen pk_specimen; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen
    ADD CONSTRAINT pk_specimen PRIMARY KEY (id);


--
-- TOC entry 2391 (class 2606 OID 81554)
-- Name: specimen_slide pk_specimen_slide; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide
    ADD CONSTRAINT pk_specimen_slide PRIMARY KEY (id);


--
-- TOC entry 2321 (class 2606 OID 81530)
-- Name: storage_box pk_storage_box; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box
    ADD CONSTRAINT pk_storage_box PRIMARY KEY (id);


--
-- TOC entry 2467 (class 2606 OID 81584)
-- Name: taxon pk_taxon; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT pk_taxon PRIMARY KEY (id);


--
-- TOC entry 2525 (class 2606 OID 81656)
-- Name: user_db pk_user_db; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_db
    ADD CONSTRAINT pk_user_db PRIMARY KEY (id);


--
-- TOC entry 2529 (class 2606 OID 81604)
-- Name: vocabulary pk_vocabulary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vocabulary
    ADD CONSTRAINT pk_vocabulary PRIMARY KEY (id);


--
-- TOC entry 2331 (class 2606 OID 81610)
-- Name: chromatogram uk_chromatogram__chromatogram_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT uk_chromatogram__chromatogram_code UNIQUE (chromatogram_code);


--
-- TOC entry 2441 (class 2606 OID 81628)
-- Name: country uk_country__country_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY country
    ADD CONSTRAINT uk_country__country_code UNIQUE (country_code);


--
-- TOC entry 2306 (class 2606 OID 81606)
-- Name: dna uk_dna__dna_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT uk_dna__dna_code UNIQUE (dna_code);


--
-- TOC entry 2423 (class 2606 OID 81626)
-- Name: external_biological_material uk_external_biological_material__external_biological_material_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT uk_external_biological_material__external_biological_material_c UNIQUE (external_biological_material_code);


--
-- TOC entry 2492 (class 2606 OID 81646)
-- Name: external_sequence uk_external_sequence__external_sequence_alignment_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT uk_external_sequence__external_sequence_alignment_code UNIQUE (external_sequence_alignment_code);


--
-- TOC entry 2494 (class 2606 OID 81644)
-- Name: external_sequence uk_external_sequence__external_sequence_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT uk_external_sequence__external_sequence_code UNIQUE (external_sequence_code);


--
-- TOC entry 2378 (class 2606 OID 81616)
-- Name: institution uk_institution__institution_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT uk_institution__institution_name UNIQUE (institution_name);


--
-- TOC entry 2410 (class 2606 OID 81624)
-- Name: internal_biological_material uk_internal_biological_material__internal_biological_material_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT uk_internal_biological_material__internal_biological_material_c UNIQUE (internal_biological_material_code);


--
-- TOC entry 2477 (class 2606 OID 81642)
-- Name: internal_sequence uk_internal_sequence__internal_sequence_alignment_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence
    ADD CONSTRAINT uk_internal_sequence__internal_sequence_alignment_code UNIQUE (internal_sequence_alignment_code);


--
-- TOC entry 2479 (class 2606 OID 81640)
-- Name: internal_sequence uk_internal_sequence__internal_sequence_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence
    ADD CONSTRAINT uk_internal_sequence__internal_sequence_code UNIQUE (internal_sequence_code);


--
-- TOC entry 2343 (class 2606 OID 81614)
-- Name: municipality uk_municipality__municipality_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipality
    ADD CONSTRAINT uk_municipality__municipality_code UNIQUE (municipality_code);


--
-- TOC entry 2452 (class 2606 OID 81630)
-- Name: pcr uk_pcr__pcr_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT uk_pcr__pcr_code UNIQUE (pcr_code);


--
-- TOC entry 2461 (class 2606 OID 81632)
-- Name: person uk_person__person_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT uk_person__person_name UNIQUE (person_name);


--
-- TOC entry 2465 (class 2606 OID 81634)
-- Name: program uk_program__program_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY program
    ADD CONSTRAINT uk_program__program_code UNIQUE (program_code);


--
-- TOC entry 2338 (class 2606 OID 81612)
-- Name: sampling uk_sampling__sample_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling
    ADD CONSTRAINT uk_sampling__sample_code UNIQUE (sample_code);


--
-- TOC entry 2523 (class 2606 OID 81650)
-- Name: site uk_site__site_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT uk_site__site_code UNIQUE (site_code);


--
-- TOC entry 2498 (class 2606 OID 81648)
-- Name: source uk_source__source_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source
    ADD CONSTRAINT uk_source__source_code UNIQUE (source_code);


--
-- TOC entry 2384 (class 2606 OID 81618)
-- Name: specimen uk_specimen__specimen_molecular_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen
    ADD CONSTRAINT uk_specimen__specimen_molecular_code UNIQUE (specimen_molecular_code);


--
-- TOC entry 2386 (class 2606 OID 81620)
-- Name: specimen uk_specimen__specimen_morphological_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen
    ADD CONSTRAINT uk_specimen__specimen_morphological_code UNIQUE (specimen_morphological_code);


--
-- TOC entry 2393 (class 2606 OID 81622)
-- Name: specimen_slide uk_specimen_slide__collection_slide_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide
    ADD CONSTRAINT uk_specimen_slide__collection_slide_code UNIQUE (collection_slide_code);


--
-- TOC entry 2323 (class 2606 OID 81608)
-- Name: storage_box uk_storage_box__box_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box
    ADD CONSTRAINT uk_storage_box__box_code UNIQUE (box_code);


--
-- TOC entry 2469 (class 2606 OID 81638)
-- Name: taxon uk_taxon__taxon_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT uk_taxon__taxon_code UNIQUE (taxon_code);


--
-- TOC entry 2471 (class 2606 OID 81636)
-- Name: taxon uk_taxon__taxon_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT uk_taxon__taxon_name UNIQUE (taxon_name);


--
-- TOC entry 2527 (class 2606 OID 81652)
-- Name: user_db uk_user_db__username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_db
    ADD CONSTRAINT uk_user_db__username UNIQUE (username);


--
-- TOC entry 2531 (class 2606 OID 81654)
-- Name: vocabulary uk_vocabulary__parent__code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vocabulary
    ADD CONSTRAINT uk_vocabulary__parent__code UNIQUE (code, parent);


--
-- TOC entry 2453 (class 1259 OID 81661)
-- Name: idx_1041853b2b63d494; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_1041853b2b63d494 ON pcr_is_done_by USING btree (pcr_fk);


--
-- TOC entry 2454 (class 1259 OID 81662)
-- Name: idx_1041853bb53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_1041853bb53cd04c ON pcr_is_done_by USING btree (person_fk);


--
-- TOC entry 2344 (class 1259 OID 81663)
-- Name: idx_10a697444236d33e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_10a697444236d33e ON composition_of_internal_biological_material USING btree (specimen_type_voc_fk);


--
-- TOC entry 2345 (class 1259 OID 81664)
-- Name: idx_10a6974454dbbd4d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_10a6974454dbbd4d ON composition_of_internal_biological_material USING btree (internal_biological_material_fk);


--
-- TOC entry 2499 (class 1259 OID 81665)
-- Name: idx_16dc6005821b1d3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_16dc6005821b1d3f ON source_is_entered_by USING btree (source_fk);


--
-- TOC entry 2500 (class 1259 OID 81666)
-- Name: idx_16dc6005b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_16dc6005b53cd04c ON source_is_entered_by USING btree (person_fk);


--
-- TOC entry 2434 (class 1259 OID 81667)
-- Name: idx_17a90ea3503b4409; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_17a90ea3503b4409 ON motu_is_generated_by USING btree (motu_fk);


--
-- TOC entry 2435 (class 1259 OID 81668)
-- Name: idx_17a90ea3b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_17a90ea3b53cd04c ON motu_is_generated_by USING btree (person_fk);


--
-- TOC entry 2367 (class 1259 OID 81669)
-- Name: idx_18fcbb8f662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_18fcbb8f662d9b98 ON sampling_is_funded_by USING btree (sampling_fk);


--
-- TOC entry 2368 (class 1259 OID 81670)
-- Name: idx_18fcbb8f759c7bb0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_18fcbb8f759c7bb0 ON sampling_is_funded_by USING btree (program_fk);


--
-- TOC entry 2298 (class 1259 OID 82838)
-- Name: idx_1dcf9af9c53b46b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_1dcf9af9c53b46b ON dna USING btree (dna_quality_voc_fk);


--
-- TOC entry 2472 (class 1259 OID 81671)
-- Name: idx_353cf66988085e0f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_353cf66988085e0f ON internal_sequence USING btree (internal_sequence_status_voc_fk);


--
-- TOC entry 2473 (class 1259 OID 81672)
-- Name: idx_353cf669a30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_353cf669a30c442f ON internal_sequence USING btree (date_precision_voc_fk);


--
-- TOC entry 2348 (class 1259 OID 81673)
-- Name: idx_49d19c8d40d80ecd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8d40d80ecd ON identified_species USING btree (external_biological_material_fk);


--
-- TOC entry 2349 (class 1259 OID 81674)
-- Name: idx_49d19c8d54dbbd4d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8d54dbbd4d ON identified_species USING btree (internal_biological_material_fk);


--
-- TOC entry 2350 (class 1259 OID 81675)
-- Name: idx_49d19c8d5be90e48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8d5be90e48 ON identified_species USING btree (internal_sequence_fk);


--
-- TOC entry 2351 (class 1259 OID 81676)
-- Name: idx_49d19c8d5f2c6176; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8d5f2c6176 ON identified_species USING btree (specimen_fk);


--
-- TOC entry 2352 (class 1259 OID 81677)
-- Name: idx_49d19c8d7b09e3bc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8d7b09e3bc ON identified_species USING btree (taxon_fk);


--
-- TOC entry 2353 (class 1259 OID 81678)
-- Name: idx_49d19c8da30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8da30c442f ON identified_species USING btree (date_precision_voc_fk);


--
-- TOC entry 2354 (class 1259 OID 81679)
-- Name: idx_49d19c8dcdd1f756; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8dcdd1f756 ON identified_species USING btree (external_sequence_fk);


--
-- TOC entry 2355 (class 1259 OID 81680)
-- Name: idx_49d19c8dfb5f790; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_49d19c8dfb5f790 ON identified_species USING btree (identification_criterion_voc_fk);


--
-- TOC entry 2311 (class 1259 OID 81681)
-- Name: idx_4e79cb8d40e7e0b3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_4e79cb8d40e7e0b3 ON motu_number USING btree (delimitation_method_voc_fk);


--
-- TOC entry 2312 (class 1259 OID 81682)
-- Name: idx_4e79cb8d503b4409; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_4e79cb8d503b4409 ON motu_number USING btree (motu_fk);


--
-- TOC entry 2313 (class 1259 OID 81683)
-- Name: idx_4e79cb8d5be90e48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_4e79cb8d5be90e48 ON motu_number USING btree (internal_sequence_fk);


--
-- TOC entry 2314 (class 1259 OID 81684)
-- Name: idx_4e79cb8dcdd1f756; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_4e79cb8dcdd1f756 ON motu_number USING btree (external_sequence_fk);


--
-- TOC entry 2332 (class 1259 OID 81685)
-- Name: idx_55ae4a3d369ab36b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_55ae4a3d369ab36b ON sampling USING btree (site_fk);


--
-- TOC entry 2333 (class 1259 OID 81686)
-- Name: idx_55ae4a3d50bb334e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_55ae4a3d50bb334e ON sampling USING btree (donation_voc_fk);


--
-- TOC entry 2334 (class 1259 OID 81687)
-- Name: idx_55ae4a3da30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_55ae4a3da30c442f ON sampling USING btree (date_precision_voc_fk);


--
-- TOC entry 2294 (class 1259 OID 81688)
-- Name: idx_5a6bd88a29b38195; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5a6bd88a29b38195 ON sampling_is_done_with_method USING btree (sampling_method_voc_fk);


--
-- TOC entry 2295 (class 1259 OID 81689)
-- Name: idx_5a6bd88a662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5a6bd88a662d9b98 ON sampling_is_done_with_method USING btree (sampling_fk);


--
-- TOC entry 2442 (class 1259 OID 81690)
-- Name: idx_5b6b99362c5b04a7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b99362c5b04a7 ON pcr USING btree (forward_primer_voc_fk);


--
-- TOC entry 2443 (class 1259 OID 81691)
-- Name: idx_5b6b99364b06319d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b99364b06319d ON pcr USING btree (dna_fk);


--
-- TOC entry 2444 (class 1259 OID 81692)
-- Name: idx_5b6b99366ccc2566; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b99366ccc2566 ON pcr USING btree (pcr_specificity_voc_fk);


--
-- TOC entry 2445 (class 1259 OID 81693)
-- Name: idx_5b6b99368b4a1710; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b99368b4a1710 ON pcr USING btree (pcr_quality_voc_fk);


--
-- TOC entry 2446 (class 1259 OID 81694)
-- Name: idx_5b6b99369d3cdb05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b99369d3cdb05 ON pcr USING btree (gene_voc_fk);


--
-- TOC entry 2447 (class 1259 OID 81695)
-- Name: idx_5b6b9936a30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b9936a30c442f ON pcr USING btree (date_precision_voc_fk);


--
-- TOC entry 2448 (class 1259 OID 81696)
-- Name: idx_5b6b9936f1694267; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5b6b9936f1694267 ON pcr USING btree (reverse_primer_voc_fk);


--
-- TOC entry 2379 (class 1259 OID 81697)
-- Name: idx_5ee42fce4236d33e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5ee42fce4236d33e ON specimen USING btree (specimen_type_voc_fk);


--
-- TOC entry 2380 (class 1259 OID 81698)
-- Name: idx_5ee42fce54dbbd4d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_5ee42fce54dbbd4d ON specimen USING btree (internal_biological_material_fk);


--
-- TOC entry 2290 (class 1259 OID 81699)
-- Name: idx_60129a315fd841ac; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_60129a315fd841ac ON sample_is_fixed_with USING btree (fixative_voc_fk);


--
-- TOC entry 2291 (class 1259 OID 81700)
-- Name: idx_60129a31662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_60129a31662d9b98 ON sample_is_fixed_with USING btree (sampling_fk);


--
-- TOC entry 2411 (class 1259 OID 81701)
-- Name: idx_69c58aff54dbbd4d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_69c58aff54dbbd4d ON internal_biological_material_is_treated_by USING btree (internal_biological_material_fk);


--
-- TOC entry 2412 (class 1259 OID 81702)
-- Name: idx_69c58affb53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_69c58affb53cd04c ON internal_biological_material_is_treated_by USING btree (person_fk);


--
-- TOC entry 2317 (class 1259 OID 81703)
-- Name: idx_7718edef41a72d48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_7718edef41a72d48 ON storage_box USING btree (collection_code_voc_fk);


--
-- TOC entry 2318 (class 1259 OID 81704)
-- Name: idx_7718edef57552d30; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_7718edef57552d30 ON storage_box USING btree (box_type_voc_fk);


--
-- TOC entry 2319 (class 1259 OID 81705)
-- Name: idx_7718edef9e7b0e1f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_7718edef9e7b0e1f ON storage_box USING btree (collection_type_voc_fk);


--
-- TOC entry 2424 (class 1259 OID 81706)
-- Name: idx_7d78636f40d80ecd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_7d78636f40d80ecd ON external_biological_material_is_processed_by USING btree (external_biological_material_fk);


--
-- TOC entry 2425 (class 1259 OID 81707)
-- Name: idx_7d78636fb53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_7d78636fb53cd04c ON external_biological_material_is_processed_by USING btree (person_fk);


--
-- TOC entry 2356 (class 1259 OID 82852)
-- Name: idx_801c3911b669f53d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_801c3911b669f53d ON identified_species USING btree (type_material_voc_fk);


--
-- TOC entry 2394 (class 1259 OID 81708)
-- Name: idx_88295540b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_88295540b53cd04c ON slide_is_mounted_by USING btree (person_fk);


--
-- TOC entry 2395 (class 1259 OID 81709)
-- Name: idx_88295540d9c85992; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_88295540d9c85992 ON slide_is_mounted_by USING btree (specimen_slide_fk);


--
-- TOC entry 2511 (class 1259 OID 81710)
-- Name: idx_8d0e8d6a821b1d3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_8d0e8d6a821b1d3f ON external_sequence_is_published_in USING btree (source_fk);


--
-- TOC entry 2512 (class 1259 OID 81711)
-- Name: idx_8d0e8d6acdd1f756; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_8d0e8d6acdd1f756 ON external_sequence_is_published_in USING btree (external_sequence_fk);


--
-- TOC entry 2387 (class 1259 OID 81712)
-- Name: idx_8da827e22b644673; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_8da827e22b644673 ON specimen_slide USING btree (storage_box_fk);


--
-- TOC entry 2388 (class 1259 OID 81713)
-- Name: idx_8da827e25f2c6176; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_8da827e25f2c6176 ON specimen_slide USING btree (specimen_fk);


--
-- TOC entry 2389 (class 1259 OID 81714)
-- Name: idx_8da827e2a30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_8da827e2a30c442f ON specimen_slide USING btree (date_precision_voc_fk);


--
-- TOC entry 2484 (class 1259 OID 81715)
-- Name: idx_9e9f85cf514d78e0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9e9f85cf514d78e0 ON external_sequence USING btree (external_sequence_origin_voc_fk);


--
-- TOC entry 2485 (class 1259 OID 81716)
-- Name: idx_9e9f85cf662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9e9f85cf662d9b98 ON external_sequence USING btree (sampling_fk);


--
-- TOC entry 2486 (class 1259 OID 81717)
-- Name: idx_9e9f85cf88085e0f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9e9f85cf88085e0f ON external_sequence USING btree (external_sequence_status_voc_fk);


--
-- TOC entry 2487 (class 1259 OID 81718)
-- Name: idx_9e9f85cf9d3cdb05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9e9f85cf9d3cdb05 ON external_sequence USING btree (gene_voc_fk);


--
-- TOC entry 2488 (class 1259 OID 81719)
-- Name: idx_9e9f85cfa30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9e9f85cfa30c442f ON external_sequence USING btree (date_precision_voc_fk);


--
-- TOC entry 2515 (class 1259 OID 81720)
-- Name: idx_9f39f8b143d4e2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9f39f8b143d4e2c ON site USING btree (municipality_fk);


--
-- TOC entry 2516 (class 1259 OID 81721)
-- Name: idx_9f39f8b14d50d031; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9f39f8b14d50d031 ON site USING btree (access_point_voc_fk);


--
-- TOC entry 2517 (class 1259 OID 81722)
-- Name: idx_9f39f8b1b1c3431a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9f39f8b1b1c3431a ON site USING btree (country_fk);


--
-- TOC entry 2518 (class 1259 OID 81723)
-- Name: idx_9f39f8b1c23046ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9f39f8b1c23046ae ON site USING btree (habitat_type_voc_fk);


--
-- TOC entry 2519 (class 1259 OID 81724)
-- Name: idx_9f39f8b1e86dbd90; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9f39f8b1e86dbd90 ON site USING btree (coordinate_precision_voc_fk);


--
-- TOC entry 2307 (class 1259 OID 81725)
-- Name: idx_b786c5214b06319d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_b786c5214b06319d ON dna_is_extracted_by USING btree (dna_fk);


--
-- TOC entry 2308 (class 1259 OID 81726)
-- Name: idx_b786c521b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_b786c521b53cd04c ON dna_is_extracted_by USING btree (person_fk);


--
-- TOC entry 2402 (class 1259 OID 81727)
-- Name: idx_ba1841a52b644673; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba1841a52b644673 ON internal_biological_material USING btree (storage_box_fk);


--
-- TOC entry 2403 (class 1259 OID 81728)
-- Name: idx_ba1841a5662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba1841a5662d9b98 ON internal_biological_material USING btree (sampling_fk);


--
-- TOC entry 2404 (class 1259 OID 81729)
-- Name: idx_ba1841a5a30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba1841a5a30c442f ON internal_biological_material USING btree (date_precision_voc_fk);


--
-- TOC entry 2405 (class 1259 OID 81730)
-- Name: idx_ba1841a5a897cc9e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba1841a5a897cc9e ON internal_biological_material USING btree (eyes_voc_fk);


--
-- TOC entry 2406 (class 1259 OID 81731)
-- Name: idx_ba1841a5b0b56b73; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba1841a5b0b56b73 ON internal_biological_material USING btree (pigmentation_voc_fk);


--
-- TOC entry 2503 (class 1259 OID 81732)
-- Name: idx_ba97b9c45be90e48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba97b9c45be90e48 ON internal_sequence_is_published_in USING btree (internal_sequence_fk);


--
-- TOC entry 2504 (class 1259 OID 81733)
-- Name: idx_ba97b9c4821b1d3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ba97b9c4821b1d3f ON internal_sequence_is_published_in USING btree (source_fk);


--
-- TOC entry 2359 (class 1259 OID 81734)
-- Name: idx_bd45639e5be90e48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_bd45639e5be90e48 ON chromatogram_is_processed_to USING btree (internal_sequence_fk);


--
-- TOC entry 2360 (class 1259 OID 81735)
-- Name: idx_bd45639eefcfd332; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_bd45639eefcfd332 ON chromatogram_is_processed_to USING btree (chromatogram_fk);


--
-- TOC entry 2286 (class 1259 OID 81736)
-- Name: idx_c0df0ce4662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_c0df0ce4662d9b98 ON has_targeted_taxa USING btree (sampling_fk);


--
-- TOC entry 2287 (class 1259 OID 81737)
-- Name: idx_c0df0ce47b09e3bc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_c0df0ce47b09e3bc ON has_targeted_taxa USING btree (taxon_fk);


--
-- TOC entry 2428 (class 1259 OID 81738)
-- Name: idx_d2338bb240d80ecd; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_d2338bb240d80ecd ON external_biological_material_is_published_in USING btree (external_biological_material_fk);


--
-- TOC entry 2429 (class 1259 OID 81739)
-- Name: idx_d2338bb2821b1d3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_d2338bb2821b1d3f ON external_biological_material_is_published_in USING btree (source_fk);


--
-- TOC entry 2507 (class 1259 OID 81740)
-- Name: idx_dc41e25ab53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dc41e25ab53cd04c ON external_sequence_is_entered_by USING btree (person_fk);


--
-- TOC entry 2508 (class 1259 OID 81741)
-- Name: idx_dc41e25acdd1f756; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dc41e25acdd1f756 ON external_sequence_is_entered_by USING btree (external_sequence_fk);


--
-- TOC entry 2299 (class 1259 OID 81658)
-- Name: idx_dna__date_precision_voc_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dna__date_precision_voc_fk ON dna USING btree (date_precision_voc_fk);


--
-- TOC entry 2300 (class 1259 OID 81657)
-- Name: idx_dna__dna_extraction_method_voc_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dna__dna_extraction_method_voc_fk ON dna USING btree (dna_extraction_method_voc_fk);


--
-- TOC entry 2301 (class 1259 OID 81660)
-- Name: idx_dna__specimen_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dna__specimen_fk ON dna USING btree (specimen_fk);


--
-- TOC entry 2302 (class 1259 OID 81659)
-- Name: idx_dna__storage_box_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_dna__storage_box_fk ON dna USING btree (storage_box_fk);


--
-- TOC entry 2339 (class 1259 OID 81742)
-- Name: idx_e2e2d1eeb1c3431a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_e2e2d1eeb1c3431a ON municipality USING btree (country_fk);


--
-- TOC entry 2398 (class 1259 OID 82839)
-- Name: idx_ea07bfa754dbbd4d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ea07bfa754dbbd4d ON internal_biological_material_is_published_in USING btree (internal_biological_material_fk);


--
-- TOC entry 2399 (class 1259 OID 82840)
-- Name: idx_ea07bfa7821b1d3f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ea07bfa7821b1d3f ON internal_biological_material_is_published_in USING btree (source_fk);


--
-- TOC entry 2363 (class 1259 OID 81743)
-- Name: idx_ee2a88c9662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ee2a88c9662d9b98 ON sampling_is_performed_by USING btree (sampling_fk);


--
-- TOC entry 2364 (class 1259 OID 81744)
-- Name: idx_ee2a88c9b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ee2a88c9b53cd04c ON sampling_is_performed_by USING btree (person_fk);


--
-- TOC entry 2415 (class 1259 OID 81745)
-- Name: idx_eefa43f3662d9b98; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eefa43f3662d9b98 ON external_biological_material USING btree (sampling_fk);


--
-- TOC entry 2416 (class 1259 OID 81746)
-- Name: idx_eefa43f382acdc4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eefa43f382acdc4 ON external_biological_material USING btree (number_of_specimens_voc_fk);


--
-- TOC entry 2417 (class 1259 OID 81747)
-- Name: idx_eefa43f3a30c442f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eefa43f3a30c442f ON external_biological_material USING btree (date_precision_voc_fk);


--
-- TOC entry 2418 (class 1259 OID 81748)
-- Name: idx_eefa43f3a897cc9e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eefa43f3a897cc9e ON external_biological_material USING btree (eyes_voc_fk);


--
-- TOC entry 2419 (class 1259 OID 81749)
-- Name: idx_eefa43f3b0b56b73; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eefa43f3b0b56b73 ON external_biological_material USING btree (pigmentation_voc_fk);


--
-- TOC entry 2480 (class 1259 OID 81750)
-- Name: idx_f6971ba85be90e48; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_f6971ba85be90e48 ON internal_sequence_is_assembled_by USING btree (internal_sequence_fk);


--
-- TOC entry 2481 (class 1259 OID 81751)
-- Name: idx_f6971ba8b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_f6971ba8b53cd04c ON internal_sequence_is_assembled_by USING btree (person_fk);


--
-- TOC entry 2371 (class 1259 OID 81752)
-- Name: idx_f8fccf63b4ab6ba0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_f8fccf63b4ab6ba0 ON species_is_identified_by USING btree (identified_species_fk);


--
-- TOC entry 2372 (class 1259 OID 81753)
-- Name: idx_f8fccf63b53cd04c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_f8fccf63b53cd04c ON species_is_identified_by USING btree (person_fk);


--
-- TOC entry 2324 (class 1259 OID 81754)
-- Name: idx_fcb2dab7206fe5c0; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fcb2dab7206fe5c0 ON chromatogram USING btree (chromato_quality_voc_fk);


--
-- TOC entry 2325 (class 1259 OID 81755)
-- Name: idx_fcb2dab7286bbca9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fcb2dab7286bbca9 ON chromatogram USING btree (chromato_primer_voc_fk);


--
-- TOC entry 2326 (class 1259 OID 81756)
-- Name: idx_fcb2dab72b63d494; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fcb2dab72b63d494 ON chromatogram USING btree (pcr_fk);


--
-- TOC entry 2327 (class 1259 OID 81757)
-- Name: idx_fcb2dab7e8441376; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fcb2dab7e8441376 ON chromatogram USING btree (institution_fk);


--
-- TOC entry 2457 (class 1259 OID 81758)
-- Name: idx_fcec9efe8441376; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fcec9efe8441376 ON person USING btree (institution_fk);


--
-- TOC entry 2627 (class 2606 OID 81759)
-- Name: internal_sequence_is_published_in fk_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_published_in
    ADD CONSTRAINT fk_ FOREIGN KEY (source_fk) REFERENCES source(id) ON DELETE CASCADE;


--
-- TOC entry 2628 (class 2606 OID 81764)
-- Name: internal_sequence_is_published_in fk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_published_in
    ADD CONSTRAINT fk_1 FOREIGN KEY (internal_sequence_fk) REFERENCES internal_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2577 (class 2606 OID 81769)
-- Name: species_is_identified_by fk_10; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY species_is_identified_by
    ADD CONSTRAINT fk_10 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2575 (class 2606 OID 81774)
-- Name: sampling_is_funded_by fk_100; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_funded_by
    ADD CONSTRAINT fk_100 FOREIGN KEY (program_fk) REFERENCES program(id);


--
-- TOC entry 2576 (class 2606 OID 81779)
-- Name: sampling_is_funded_by fk_101; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_funded_by
    ADD CONSTRAINT fk_101 FOREIGN KEY (sampling_fk) REFERENCES sampling(id) ON DELETE CASCADE;


--
-- TOC entry 2583 (class 2606 OID 81784)
-- Name: specimen_slide fk_102; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide
    ADD CONSTRAINT fk_102 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2581 (class 2606 OID 81789)
-- Name: specimen_slide fk_103; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide
    ADD CONSTRAINT fk_103 FOREIGN KEY (storage_box_fk) REFERENCES storage_box(id);


--
-- TOC entry 2582 (class 2606 OID 81794)
-- Name: specimen_slide fk_104; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen_slide
    ADD CONSTRAINT fk_104 FOREIGN KEY (specimen_fk) REFERENCES specimen(id);


--
-- TOC entry 2548 (class 2606 OID 81799)
-- Name: motu_number fk_11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number
    ADD CONSTRAINT fk_11 FOREIGN KEY (external_sequence_fk) REFERENCES external_sequence(id);


--
-- TOC entry 2547 (class 2606 OID 81804)
-- Name: motu_number fk_12; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number
    ADD CONSTRAINT fk_12 FOREIGN KEY (delimitation_method_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2546 (class 2606 OID 81809)
-- Name: motu_number fk_13; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number
    ADD CONSTRAINT fk_13 FOREIGN KEY (internal_sequence_fk) REFERENCES internal_sequence(id);


--
-- TOC entry 2545 (class 2606 OID 81814)
-- Name: motu_number fk_14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_number
    ADD CONSTRAINT fk_14 FOREIGN KEY (motu_fk) REFERENCES motu(id) ON DELETE CASCADE;


--
-- TOC entry 2560 (class 2606 OID 81819)
-- Name: composition_of_internal_biological_material fk_15; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composition_of_internal_biological_material
    ADD CONSTRAINT fk_15 FOREIGN KEY (specimen_type_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2561 (class 2606 OID 81824)
-- Name: composition_of_internal_biological_material fk_16; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composition_of_internal_biological_material
    ADD CONSTRAINT fk_16 FOREIGN KEY (internal_biological_material_fk) REFERENCES internal_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2532 (class 2606 OID 81829)
-- Name: has_targeted_taxa fk_17; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY has_targeted_taxa
    ADD CONSTRAINT fk_17 FOREIGN KEY (sampling_fk) REFERENCES sampling(id) ON DELETE CASCADE;


--
-- TOC entry 2533 (class 2606 OID 81834)
-- Name: has_targeted_taxa fk_18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY has_targeted_taxa
    ADD CONSTRAINT fk_18 FOREIGN KEY (taxon_fk) REFERENCES taxon(id);


--
-- TOC entry 2619 (class 2606 OID 81839)
-- Name: internal_sequence_is_assembled_by fk_19; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_assembled_by
    ADD CONSTRAINT fk_19 FOREIGN KEY (internal_sequence_fk) REFERENCES internal_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2621 (class 2606 OID 81844)
-- Name: external_sequence fk_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT fk_2 FOREIGN KEY (gene_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2618 (class 2606 OID 81849)
-- Name: internal_sequence_is_assembled_by fk_20; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence_is_assembled_by
    ADD CONSTRAINT fk_20 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2614 (class 2606 OID 81854)
-- Name: pcr_is_done_by fk_21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr_is_done_by
    ADD CONSTRAINT fk_21 FOREIGN KEY (pcr_fk) REFERENCES pcr(id) ON DELETE CASCADE;


--
-- TOC entry 2613 (class 2606 OID 81859)
-- Name: pcr_is_done_by fk_22; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr_is_done_by
    ADD CONSTRAINT fk_22 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2544 (class 2606 OID 81864)
-- Name: dna_is_extracted_by fk_23; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna_is_extracted_by
    ADD CONSTRAINT fk_23 FOREIGN KEY (dna_fk) REFERENCES dna(id) ON DELETE CASCADE;


--
-- TOC entry 2543 (class 2606 OID 81869)
-- Name: dna_is_extracted_by fk_24; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna_is_extracted_by
    ADD CONSTRAINT fk_24 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2584 (class 2606 OID 81874)
-- Name: slide_is_mounted_by fk_25; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY slide_is_mounted_by
    ADD CONSTRAINT fk_25 FOREIGN KEY (specimen_slide_fk) REFERENCES specimen_slide(id) ON DELETE CASCADE;


--
-- TOC entry 2585 (class 2606 OID 81879)
-- Name: slide_is_mounted_by fk_26; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY slide_is_mounted_by
    ADD CONSTRAINT fk_26 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2594 (class 2606 OID 81884)
-- Name: internal_biological_material_is_treated_by fk_27; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_treated_by
    ADD CONSTRAINT fk_27 FOREIGN KEY (internal_biological_material_fk) REFERENCES internal_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2593 (class 2606 OID 81889)
-- Name: internal_biological_material_is_treated_by fk_28; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_treated_by
    ADD CONSTRAINT fk_28 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2626 (class 2606 OID 81894)
-- Name: source_is_entered_by fk_29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source_is_entered_by
    ADD CONSTRAINT fk_29 FOREIGN KEY (source_fk) REFERENCES source(id) ON DELETE CASCADE;


--
-- TOC entry 2620 (class 2606 OID 81899)
-- Name: external_sequence fk_3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT fk_3 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2625 (class 2606 OID 81904)
-- Name: source_is_entered_by fk_30; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source_is_entered_by
    ADD CONSTRAINT fk_30 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2629 (class 2606 OID 81909)
-- Name: external_sequence_is_entered_by fk_31; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_entered_by
    ADD CONSTRAINT fk_31 FOREIGN KEY (external_sequence_fk) REFERENCES external_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2630 (class 2606 OID 81914)
-- Name: external_sequence_is_entered_by fk_32; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_entered_by
    ADD CONSTRAINT fk_32 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2605 (class 2606 OID 81919)
-- Name: motu_is_generated_by fk_33; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_is_generated_by
    ADD CONSTRAINT fk_33 FOREIGN KEY (motu_fk) REFERENCES motu(id) ON DELETE CASCADE;


--
-- TOC entry 2604 (class 2606 OID 81924)
-- Name: motu_is_generated_by fk_34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY motu_is_generated_by
    ADD CONSTRAINT fk_34 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2617 (class 2606 OID 81929)
-- Name: internal_sequence fk_35; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence
    ADD CONSTRAINT fk_35 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2616 (class 2606 OID 81934)
-- Name: internal_sequence fk_36; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_sequence
    ADD CONSTRAINT fk_36 FOREIGN KEY (internal_sequence_status_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2571 (class 2606 OID 81939)
-- Name: chromatogram_is_processed_to fk_37; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram_is_processed_to
    ADD CONSTRAINT fk_37 FOREIGN KEY (chromatogram_fk) REFERENCES chromatogram(id);


--
-- TOC entry 2572 (class 2606 OID 81944)
-- Name: chromatogram_is_processed_to fk_38; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram_is_processed_to
    ADD CONSTRAINT fk_38 FOREIGN KEY (internal_sequence_fk) REFERENCES internal_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2559 (class 2606 OID 81949)
-- Name: municipality fk_39; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipality
    ADD CONSTRAINT fk_39 FOREIGN KEY (country_fk) REFERENCES country(id);


--
-- TOC entry 2622 (class 2606 OID 81954)
-- Name: external_sequence fk_4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT fk_4 FOREIGN KEY (external_sequence_origin_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2537 (class 2606 OID 81959)
-- Name: sampling_is_done_with_method fk_40; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_done_with_method
    ADD CONSTRAINT fk_40 FOREIGN KEY (sampling_method_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2536 (class 2606 OID 81964)
-- Name: sampling_is_done_with_method fk_41; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_done_with_method
    ADD CONSTRAINT fk_41 FOREIGN KEY (sampling_fk) REFERENCES sampling(id) ON DELETE CASCADE;


--
-- TOC entry 2534 (class 2606 OID 81969)
-- Name: sample_is_fixed_with fk_42; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_is_fixed_with
    ADD CONSTRAINT fk_42 FOREIGN KEY (fixative_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2535 (class 2606 OID 81974)
-- Name: sample_is_fixed_with fk_43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_is_fixed_with
    ADD CONSTRAINT fk_43 FOREIGN KEY (sampling_fk) REFERENCES sampling(id) ON DELETE CASCADE;


--
-- TOC entry 2586 (class 2606 OID 81979)
-- Name: internal_biological_material_is_published_in fk_44; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_published_in
    ADD CONSTRAINT fk_44 FOREIGN KEY (internal_biological_material_fk) REFERENCES internal_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2587 (class 2606 OID 81984)
-- Name: internal_biological_material_is_published_in fk_45; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material_is_published_in
    ADD CONSTRAINT fk_45 FOREIGN KEY (source_fk) REFERENCES source(id) ON DELETE CASCADE;


--
-- TOC entry 2596 (class 2606 OID 81989)
-- Name: external_biological_material fk_46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT fk_46 FOREIGN KEY (sampling_fk) REFERENCES sampling(id);


--
-- TOC entry 2597 (class 2606 OID 81994)
-- Name: external_biological_material fk_47; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT fk_47 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2598 (class 2606 OID 81999)
-- Name: external_biological_material fk_48; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT fk_48 FOREIGN KEY (number_of_specimens_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2599 (class 2606 OID 82004)
-- Name: external_biological_material fk_49; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT fk_49 FOREIGN KEY (pigmentation_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2624 (class 2606 OID 82009)
-- Name: external_sequence fk_5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT fk_5 FOREIGN KEY (sampling_fk) REFERENCES sampling(id);


--
-- TOC entry 2595 (class 2606 OID 82014)
-- Name: external_biological_material fk_50; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material
    ADD CONSTRAINT fk_50 FOREIGN KEY (eyes_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2600 (class 2606 OID 82019)
-- Name: external_biological_material_is_processed_by fk_51; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_processed_by
    ADD CONSTRAINT fk_51 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2601 (class 2606 OID 82024)
-- Name: external_biological_material_is_processed_by fk_52; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_processed_by
    ADD CONSTRAINT fk_52 FOREIGN KEY (external_biological_material_fk) REFERENCES external_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2603 (class 2606 OID 82029)
-- Name: external_biological_material_is_published_in fk_53; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_published_in
    ADD CONSTRAINT fk_53 FOREIGN KEY (external_biological_material_fk) REFERENCES external_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2602 (class 2606 OID 82034)
-- Name: external_biological_material_is_published_in fk_54; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_biological_material_is_published_in
    ADD CONSTRAINT fk_54 FOREIGN KEY (source_fk) REFERENCES source(id) ON DELETE CASCADE;


--
-- TOC entry 2633 (class 2606 OID 82039)
-- Name: site fk_55; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_55 FOREIGN KEY (municipality_fk) REFERENCES municipality(id);


--
-- TOC entry 2635 (class 2606 OID 82044)
-- Name: site fk_56; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_56 FOREIGN KEY (country_fk) REFERENCES country(id);


--
-- TOC entry 2634 (class 2606 OID 82049)
-- Name: site fk_57; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_57 FOREIGN KEY (access_point_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2636 (class 2606 OID 82054)
-- Name: site fk_58; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_58 FOREIGN KEY (habitat_type_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2637 (class 2606 OID 82059)
-- Name: site fk_59; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY site
    ADD CONSTRAINT fk_59 FOREIGN KEY (coordinate_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2623 (class 2606 OID 82064)
-- Name: external_sequence fk_6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence
    ADD CONSTRAINT fk_6 FOREIGN KEY (external_sequence_status_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2556 (class 2606 OID 82069)
-- Name: sampling fk_60; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling
    ADD CONSTRAINT fk_60 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2558 (class 2606 OID 82074)
-- Name: sampling fk_61; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling
    ADD CONSTRAINT fk_61 FOREIGN KEY (donation_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2557 (class 2606 OID 82079)
-- Name: sampling fk_62; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling
    ADD CONSTRAINT fk_62 FOREIGN KEY (site_fk) REFERENCES site(id);


--
-- TOC entry 2615 (class 2606 OID 82084)
-- Name: person fk_63; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fk_63 FOREIGN KEY (institution_fk) REFERENCES institution(id);


--
-- TOC entry 2574 (class 2606 OID 82089)
-- Name: sampling_is_performed_by fk_64; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_performed_by
    ADD CONSTRAINT fk_64 FOREIGN KEY (person_fk) REFERENCES person(id);


--
-- TOC entry 2573 (class 2606 OID 82094)
-- Name: sampling_is_performed_by fk_65; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sampling_is_performed_by
    ADD CONSTRAINT fk_65 FOREIGN KEY (sampling_fk) REFERENCES sampling(id) ON DELETE CASCADE;


--
-- TOC entry 2549 (class 2606 OID 82099)
-- Name: storage_box fk_66; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box
    ADD CONSTRAINT fk_66 FOREIGN KEY (collection_type_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2550 (class 2606 OID 82104)
-- Name: storage_box fk_67; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box
    ADD CONSTRAINT fk_67 FOREIGN KEY (collection_code_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2551 (class 2606 OID 82109)
-- Name: storage_box fk_68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storage_box
    ADD CONSTRAINT fk_68 FOREIGN KEY (box_type_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2588 (class 2606 OID 82114)
-- Name: internal_biological_material fk_69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT fk_69 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2632 (class 2606 OID 82119)
-- Name: external_sequence_is_published_in fk_7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_published_in
    ADD CONSTRAINT fk_7 FOREIGN KEY (source_fk) REFERENCES source(id) ON DELETE CASCADE;


--
-- TOC entry 2592 (class 2606 OID 82124)
-- Name: internal_biological_material fk_70; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT fk_70 FOREIGN KEY (pigmentation_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2589 (class 2606 OID 82129)
-- Name: internal_biological_material fk_71; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT fk_71 FOREIGN KEY (eyes_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2591 (class 2606 OID 82134)
-- Name: internal_biological_material fk_72; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT fk_72 FOREIGN KEY (sampling_fk) REFERENCES sampling(id);


--
-- TOC entry 2590 (class 2606 OID 82139)
-- Name: internal_biological_material fk_73; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY internal_biological_material
    ADD CONSTRAINT fk_73 FOREIGN KEY (storage_box_fk) REFERENCES storage_box(id);


--
-- TOC entry 2565 (class 2606 OID 82144)
-- Name: identified_species fk_74; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_74 FOREIGN KEY (identification_criterion_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2564 (class 2606 OID 82149)
-- Name: identified_species fk_75; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_75 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2566 (class 2606 OID 82154)
-- Name: identified_species fk_76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_76 FOREIGN KEY (external_sequence_fk) REFERENCES external_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2569 (class 2606 OID 82159)
-- Name: identified_species fk_77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_77 FOREIGN KEY (external_biological_material_fk) REFERENCES external_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2568 (class 2606 OID 82164)
-- Name: identified_species fk_78; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_78 FOREIGN KEY (internal_biological_material_fk) REFERENCES internal_biological_material(id) ON DELETE CASCADE;


--
-- TOC entry 2563 (class 2606 OID 82169)
-- Name: identified_species fk_79; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_79 FOREIGN KEY (taxon_fk) REFERENCES taxon(id);


--
-- TOC entry 2631 (class 2606 OID 82174)
-- Name: external_sequence_is_published_in fk_8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY external_sequence_is_published_in
    ADD CONSTRAINT fk_8 FOREIGN KEY (external_sequence_fk) REFERENCES external_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2567 (class 2606 OID 82179)
-- Name: identified_species fk_80; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_80 FOREIGN KEY (specimen_fk) REFERENCES specimen(id) ON DELETE CASCADE;


--
-- TOC entry 2562 (class 2606 OID 82847)
-- Name: identified_species fk_801c3911b669f53d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_801c3911b669f53d FOREIGN KEY (type_material_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2570 (class 2606 OID 82184)
-- Name: identified_species fk_81; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identified_species
    ADD CONSTRAINT fk_81 FOREIGN KEY (internal_sequence_fk) REFERENCES internal_sequence(id) ON DELETE CASCADE;


--
-- TOC entry 2580 (class 2606 OID 82189)
-- Name: specimen fk_82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen
    ADD CONSTRAINT fk_82 FOREIGN KEY (specimen_type_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2579 (class 2606 OID 82194)
-- Name: specimen fk_83; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY specimen
    ADD CONSTRAINT fk_83 FOREIGN KEY (internal_biological_material_fk) REFERENCES internal_biological_material(id);


--
-- TOC entry 2539 (class 2606 OID 82199)
-- Name: dna fk_84; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT fk_84 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2541 (class 2606 OID 82204)
-- Name: dna fk_85; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT fk_85 FOREIGN KEY (dna_extraction_method_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2542 (class 2606 OID 82209)
-- Name: dna fk_86; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT fk_86 FOREIGN KEY (specimen_fk) REFERENCES specimen(id);


--
-- TOC entry 2538 (class 2606 OID 82214)
-- Name: dna fk_87; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT fk_87 FOREIGN KEY (dna_quality_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2540 (class 2606 OID 82219)
-- Name: dna fk_88; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dna
    ADD CONSTRAINT fk_88 FOREIGN KEY (storage_box_fk) REFERENCES storage_box(id);


--
-- TOC entry 2611 (class 2606 OID 82224)
-- Name: pcr fk_89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_89 FOREIGN KEY (gene_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2578 (class 2606 OID 82229)
-- Name: species_is_identified_by fk_9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY species_is_identified_by
    ADD CONSTRAINT fk_9 FOREIGN KEY (identified_species_fk) REFERENCES identified_species(id) ON DELETE CASCADE;


--
-- TOC entry 2612 (class 2606 OID 82234)
-- Name: pcr fk_90; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_90 FOREIGN KEY (pcr_quality_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2607 (class 2606 OID 82239)
-- Name: pcr fk_91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_91 FOREIGN KEY (pcr_specificity_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2608 (class 2606 OID 82244)
-- Name: pcr fk_92; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_92 FOREIGN KEY (forward_primer_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2610 (class 2606 OID 82249)
-- Name: pcr fk_93; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_93 FOREIGN KEY (reverse_primer_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2606 (class 2606 OID 82254)
-- Name: pcr fk_94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_94 FOREIGN KEY (date_precision_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2609 (class 2606 OID 82259)
-- Name: pcr fk_95; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pcr
    ADD CONSTRAINT fk_95 FOREIGN KEY (dna_fk) REFERENCES dna(id);


--
-- TOC entry 2554 (class 2606 OID 82264)
-- Name: chromatogram fk_96; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT fk_96 FOREIGN KEY (chromato_primer_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2553 (class 2606 OID 82269)
-- Name: chromatogram fk_97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT fk_97 FOREIGN KEY (chromato_quality_voc_fk) REFERENCES vocabulary(id);


--
-- TOC entry 2552 (class 2606 OID 82274)
-- Name: chromatogram fk_98; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT fk_98 FOREIGN KEY (institution_fk) REFERENCES institution(id);


--
-- TOC entry 2555 (class 2606 OID 82279)
-- Name: chromatogram fk_99; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY chromatogram
    ADD CONSTRAINT fk_99 FOREIGN KEY (pcr_fk) REFERENCES pcr(id);


--
-- TOC entry 2753 (class 0 OID 0)
-- Dependencies: 9
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2020-02-27 15:11:39

--
-- PostgreSQL database dump complete
--

