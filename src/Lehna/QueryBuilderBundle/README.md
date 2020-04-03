# GOTIT2 - v2.x of GOTIT
GOTIT is a software package that facilitates the monitoring of species samples taken at collection stations, both for the management of occurrence data and for the molecular analysis of these species. The initial web interface is currently accessible on [https://gotit.cnrs.fr/index.htm](https://gotit.cnrs.fr/index.htm).

This prototype is an enhancement of the web interface to allow, via the **Query Builder** bundle, flexible queries on the database to allow collaborators not using SQL to view and export the results of custom queries.


## Bundle Features

### Formulary
>
>![picture](./Capture_interface.png)
>
>-`How queries work` : 
>
>For each selected table, the user can put **constraints** and **select the fields** to be displayed for the query result. 
>
>For the first chosen table, even if the user does not check the constraints, all fields are selected by default. 
>
>Next, you can make **joints** (left,right,full join ...) between a previously selected table and one of its adjacent tables by pressing the **+** button. Constraints can also be added. 
>
>-`The Constraints`: 
>
>The **JQuery Query Builder** module allows to define constraints and logical links (AND,OR ...). It uses the fields of the selected adjacent table. Link: [https://querybuilder.js.org/](https://querybuilder.js.org/)
>
>We used it because the structure fits well.
 The constraints are made for a single table. So we reused several times queryBuilder blocks and we manipulated it to introduce fields according to the chosen table. 

### Results 

>The user can get a summary of the SQL and DQL query.
> 
>Also, he can donwload the results.
>
>![picture](./Capture2_interface.png)


## Treeview of files created for the *Query Builder* bundle


 * [src]()
    * [Lehna]()
      * [QueryBuilderBundle]()
        * [Controller]()
          * [DefaultController.php]()
        * [Resources]()
            * [public/js]()
              * [main.js]()
            * [views]()
              * [base.queries.html.twig]()
              * [form.html.twig]()
              * [index.html.twig]()
              * [results.html.twig]()
        * [Services]()
          * [QueryBuilderService.php]()
        * [LehnaQueryBuilderBundle.php]()
  * [web]()
    * [e3s]()
      * [vendors]()
          * [queryBuilder]()
              * [.js / .css]()
         

 
 ## General file operation 
 

- **DefaultController.php** allows you to make requests to the server using the information retrieved with **main.js**. 

- The script **main.js** contains the code that :
>- describes the behaviors on the html page. 
>- reads the **JSON** (loaded when the page is loaded) which describes the links in the database. This way, there is no round trip to the server each time the user chooses tables and/or fields. 
>- makes the link to the **DefaultController.php** when clicking on **SEARCH**. **The JS script summarizes the information entered in the form.**

- The **views** folder contains the **html.twig** files that make up the user interface. The index consists of **form** and **results**. Thus, the user constitutes his form and then gets his result by clicking on SEARCH. 



## Tools used 

>- Framework Symfony (version 3.4) 
>- Programming languages used in Symfony: 
>  *Javascript, CSS, HTML, PHP, Twig.html*
>- Computational architecture: 
> *Ajax, MVC (controller)*
>- ORM Doctrine 
>- JSON file summarizing the database 
>- *jQuery QueryBuilder* tool adapted 
>- Mustache.JS, DataTable module 

## RoadMap 

>- Increment others joints ( right join, full join and cross join )
>- Implement a French version of the page 
>- Make the fields available in english 
>- Allow more advanced queries ( with order by ...)


#### To test the web interface code ( Symfony )
 
```
$ docker start gotit-db ## launch database

$ php bin/console server:run ## start server

```