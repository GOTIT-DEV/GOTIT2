# GOTIT2-0
=======
# GOTIT (Gene, Occurence and Taxa in Integrative Taxonomy) : A Symfony project created on 03/12/2018 - Dev version 2.0.0 

## Update July 2020

* Internalization & upgrade of the database : 

    * English naming version of database objects (table and field names) to facilitate customized SQL queries and development by third-parties

    * Linking species taxa to first description literature for tracing back original species descriptions : [taxon]taxon_full_name

    * Added additional fields for enabling queries of type localities and type specimens : [identified_species]material_type


* Update Symfony framework v3 to v4.4 (LTS) 

* Addition of new features to the interface :

    * new "Export to CSV" button to download list of records

    * new "back to" button to the edit form

    * modification of selection list by an auto-complete field in the edit and new forms to improve access speed 

    * new "back to relative entity" button in the show form

    * new sortable bootgrid columns in all list of records

    * new link to the internal sequence from a chromatogram

* New QueryBUilderBundle to help user perform SQL queries on the database