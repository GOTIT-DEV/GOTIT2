1) Dans les contraintes : il est fortement conseillé de ne pas faire de requête avec les élements dateCre, dateMaj, userCre et userMaj; le seul format des dates (classe DateTime) supporté est Y-m-d soit par exemple 2020-04-03.

2) Bouton 'ADD GROUP' du queryBuilder : problèmes de priorité au niveau requêtes sur les conditions ('AND'/'OR'); il est conseillé de faire uniquement des 'ADD RULE' pour avoir des résultats concordant avec la requête. 

3) QueryBuilderController : les requêtes ont été créées sans prendre en considération les possibles injections SQL, il convient donc que l'utilisateur écrive des choses censées dans les espaces reservés à la saisie de valeurs pour les contraintes dans le formulaire. 