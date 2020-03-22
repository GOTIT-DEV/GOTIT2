/* 
 * This file file is part of the QueryBuilderBundle.
 * 
 * It is a free software, included in a bigger project. You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 * 
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes. 
*/ 


// Initializing the first query block
$(document).ready(function () {
  
  // Init menu for choosing the first table
  let dropdown = $('#first-table');
  dropdown.empty();
  dropdown.append('<option selected="true" disabled>Choose table</option>');
  dropdown.prop('selectedIndex', 0);

  // Filling the menu with all the tables in the database
  $.getJSON("init", function (data) {
    $.each(data, function (key, entry) {
      dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })
  });

  // Choosing the fields you want to return and the constraints to apply
  $('#first-table').click(function () {
    
    // Init list of fields
    var showData = $('#show-data');
    var liste = document.getElementById("first-table");
    let target_table = $(liste).val();

    // Init query-builder with fields and filters
    $.getJSON('init', function (data) {

      let table_data = data[target_table];
      $('.builder-basic').eq(0).queryBuilder('setFilters',true, table_data.filters);
      
      var items = table_data.filters.map(function (item) {
        return item.label;
      });

      showData.empty();
  
      if (items.length) {
        var content = '<input type="checkbox" >' + items.join('</input><br><input type="checkbox" >') + '</input><br>';
        var list = $('<ul />').html(content);
        showData.append(list);

      }
    });
  });
});


// Init possible joints
joints = [
  'inner join',
  'left join',
  'right join',
  'cross join',
  'self join',
  'full join'
];


/**
 * Adding a full block of query:
 * - choice of a table previously queried
 * - choice of joint
 * - choice of adjacent table of the new chosen table
 * - possibility to choose specific fields to return and constraints to apply
 */
function addJoint() {
  var cont = $('.add-constraints').eq(-1);
  var temp = document.getElementsByTagName("template")[0];
  var clon = temp.content.cloneNode(true);
  cont.append(clon);
}


// Choosing what joint to make between a table chosen previously and an adjacent table, the fields to return and the constraints to apply
$('#add-joint').click(function () {

  // Init menus for previously chosen tables and adjacent tables
  let menu_tables = $('.previous-table:last > option');
  let adj_table = $('.adjacent-tables').eq(-1).find(':selected').text();

  // Adding a block of query
  addJoint();

  // Filling the menus (Previously chosen tables, Joints and Adjacent tables)
  let dropdown = $('.joints').eq(-1);
  let dropdown2 = $('.previous-table').eq(-1);
  dropdown.empty();
  dropdown.append('<option selected="true" disabled>Choose joint</option>');
  dropdown.prop('selectedIndex', 0);
  dropdown2.empty();
 
  // Filling the menu of the previous tables for the first added block
  if (menu_tables.length == 0) {
    dropdown2.append('<option selected="true" disabled>Choose one previous table</option>');
    dropdown2.prop('selectedIndex', 0);
    let first_selection = $('#first-table').find(':selected').text(); 
    dropdown2.append($('<option></option>').attr('value', first_selection).text(first_selection));
  }
  // Filling the menu of the previous tables for the second added block and after
  else {
    $.each(menu_tables, function (key, entry) {
      dropdown2.append($('<option></option>').attr('value', entry.value).text(entry.value));
    });
    dropdown2.append($('<option></option>').attr('value', adj_table).text(adj_table));
  }

  // Filling the menu containing the possible joints
  $.each(joints, function (index, value) {
    dropdown.append($('<option></option>').attr('value', value).text(value));

  });


  // Filling the menu containing the adjacent tables of the new chosen table
  $('.previous-table').eq(-1).change(function () {

    // Init the menu 
    let dropdown = $('.adjacent-tables').eq(-1);
    dropdown.empty();
    dropdown.append('<option selected="true" disabled>Choose adjacent table</option>');
    dropdown.prop('selectedIndex', 0);

    var texte = $('.previous-table').eq(-1).find(":selected").text();

    // Filling the menu dynamically
    $.getJSON("init", function (data) {

      var texte2 = data[texte];
      $.each(texte2.relations, function (key, value) {
        dropdown.append($('<option></option>').attr('value', key).text(key));
      });
    })
  });


  // Choosing the fields you want to return and the constraints to apply for each new query
  $('.new-constraints').click(function () {

    if($(this).is(":checked")==false){
      return;
    }

    // Init the fields of the chosen adjacent table
    var showData = $('.show-data2').eq(-1);
    var texte = $('.adjacent-tables').eq(-1).find(':selected').text();

    // Init a block of query-builder with the menu of fields and the filters to apply 
    $.getJSON('init', function (data) {
      
      $('.builder-basic').eq(-1).queryBuilder({
        plugins: ['bt-tooltip-errors'],
      
        filters:  [ 
          {
          id: "empty",
          label: "empty",
          type: "integer"
        }],
      
        // rules: rules_basic2
      });

      $('.builder-basic').eq(-1).queryBuilder('setFilters',true, data[texte].filters);

      $('.reset').on('click', function() {
        var target = $(this).data('target');
      
        $('.builder-'+target).eq(-1).queryBuilder('reset');
      });

      var items = data[texte].filters.map(function (item) {
        return item.label;
      });
      showData.empty();

      if (items.length) {
        var content = '<input type="checkbox" >' + items.join('</input><br><input type="checkbox" >') + '</input><br>';
        var list = $('<ul />').html(content);
        showData.append(list);
      }
    });
  });
});


// This function will maybe be used later (to remove a full block of query)
/*
function removeDiv() {
  var node = document.getElementById("addConstraints");
  if (node.parentNode) {
    node.parentNode.removeChild(node);}
}*/

/**
 * Returning the recap of the constraint(s) to apply for the first query-builder.
 */
function getTable() {
  
  if($('#first-constraints').is(":checked")==true){
    var result = $('.builder-basic').eq(0).queryBuilder('getRules');
    if (!$.isEmptyObject(result)) {
      alert(JSON.stringify(result, null, 2));
    }
  };
}

// Init the page with the JSON form containing the info of the database
$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(qb_config => {
      console.log(qb_config);
    })
})



//Get the button
var mybutton = document.getElementById("myBtn");

// When the user scrolls down 50px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}
