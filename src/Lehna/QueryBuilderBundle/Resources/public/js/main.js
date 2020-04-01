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



  // Filling the menu with all the tables in the database
  $.getJSON("init", function (init_data) {
    // Init menu for choosing the first table
    let dropdown = $('#first-table');
    dropdown.empty()
      .append('<option selected="true" disabled>Choose table</option>')
      .prop('selectedIndex', 0);

    $.each(init_data, function (key, entry) {
      dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })

    //initialization of the query builder 
    $('#initial-table-constraints').queryBuilder({
      plugins: ['bt-tooltip-errors'],
      filters: [
        {
          id: "empty",
          label: "empty",
          type: "integer"
        }]
    })
    $('.reset').click(function () {
      let target = $(this).data('target')
      $(target).queryBuilder('reset')
    })

    // what occurs when you choose a table and maybe change it 
    $('#first-table').change(function (event) {
      let target_table = event.target.value
      let table_data = init_data[target_table];

      // Init query-builder with fields and filters
      $('#initial-table-constraints').queryBuilder('setFilters', true, table_data.filters);

      // Init list of fields
      $("#first-table-selects").empty()

      var items = table_data.filters.map(function (item) {
        return Mustache.render(
          '<li><input type="checkbox" name="my_form" value="{{label}}" checked/><label>{{label}}</label></li>',
          item
        )
      })

      $("#first-table-selects").html(items.join(''))
    });
  });
});


// Init possible joints
joints = [
  'inner join',
  'left join',
  'right join',
  'cross join',
  'full join'
];


/**
 * Adding a full block of query:
 * - choice of a table previously queried
 * - choice of joint
 * - choice of adjacent table of the new chosen table
 * - possibility to choose specific fields to return and constraints to apply
 */
function addJoint(block_id) {
  let newBlock = Mustache.render(
    $("#form-block-template").html(),
    { id: block_id }
  )

  $('#add-constraints').append(newBlock);

  newBlock = $("#form-block-" + block_id)

  // query builder initialization 
  newBlock.find(".builder-basic").queryBuilder({
    plugins: ['bt-tooltip-errors'],
    filters: [{
        id: "empty",
        label: "empty",
        type: "integer"
    }]
  })
  //reset buttom
  newBlock.find('.reset').click(function () {
    let target = $(this).data('target')
    $(target).queryBuilder('reset')
  })

  return newBlock
}




let new_block_id = 0
// Choosing what joint to make between a table chosen previously and an adjacent table, the fields to return and the constraints to apply
$('#add-joint').click(function () {

  $.getJSON('init', function (init_data) {
    // add 1 at each click on add-joint
    new_block_id += 1

    // Adding a block of query
    let newBlock = addJoint(new_block_id)

    // Filling the menu containing the possible joints
    let dropdown = newBlock
      .find('.joints')
      .empty()
      .append('<option selected="true" disabled>Choose join</option>')
      .prop('selectedIndex', 0);


    $.each(joints, function (index, value) {
      dropdown.append($('<option></option>').attr('value', value).text(value));

    });


  
    //previous tables 

    let all_adj_tables = $(".adjacent-tables").map(function(){
      return $(this).val()
    }).get()

    let first_selection = $('#first-table').val()

    all_adj_tables.push(first_selection)
    all_adj_tables = [... new Set(all_adj_tables)]

    let dropdown2 = newBlock.find('.previous-table').empty()
        dropdown2.append('<option selected="true" disabled>Choose one previous table</option>')
                  .prop('selectedIndex', 0)
                  $.each(all_adj_tables, function (index, value) {
                    dropdown2.append($('<option></option>').attr('value', value).text(value));
              
                  });


    //when you select or change the value of the previous table you want to select 
    newBlock.find(".previous-table").change(function (event) {
      let target_table = event.target.value
      // Init the menu 
      let dropdown = newBlock
        .find('.adjacent-tables')
        .empty()
        .append('<option selected="true" disabled>Choose adjacent table</option>')
        .prop('selectedIndex', 0);

      var table_data = init_data[target_table];
      $.each(table_data.relations, function (key, value) {
        dropdown.append($('<option></option>').attr('value', key).text(key));
      });
    })

    //when you click to select an adjacent table 
    newBlock.find(".adjacent-tables").change(function (event) {
      let target_table = event.target.value
      let table_data = init_data[target_table];


      // Init query-builder with fields and filters of the selected table 
      newBlock.find('.builder-basic').queryBuilder('setFilters', true, table_data.filters);

      // Init list of fields
      let selects_block = newBlock.find(".table-selects")
      selects_block.empty()
      var items = table_data.filters.map(function (item) {
        return Mustache.render(
          '<li><input type="checkbox" name="my_form2" value="{{label}}"/><label>{{label}}</label></li>',
          item
        )
      })
      selects_block.html(items.join(''))
    })
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
 * Read and convert the form's fields into json when SEARCH is clicked 
 */

$.get("init", function (data) {

  $("#submit-button").click(function () {
    let data_initial = get_form_initial()
    let data_join_blocks = get_form_block_data(data)

    var jsonData = { "initial": data_initial, "joins": data_join_blocks };

    $.ajax({
      url: 'query', //query_test
      type: 'POST',
      data: jsonData,
      dataType: 'json',
      success: function (response) {
        console.log(response);
      }
    });
  })
  // fin du callback associé au bouton Search
})


function get_form_initial() {

  var table1 = document.getElementById("first-table");
  var table = table1.options[table1.selectedIndex].value;
  if ($('#first-constraints').is(":checked") == true) {
    var constraintsTable1 = $('.builder-basic').eq(0).queryBuilder('getRules');
  }
  else { var constraintsTable1 = null };
  var fields = []
  $('input:checked[name=my_form]').each(function () {
    fields.push($(this).val());
  });


  return { table, constraintsTable1, fields }

}


function get_form_block_data(init_data) {

  let block_list = $(".formBlock")
  let data = block_list.map(function () {
    let block = $(this)
    let adj_table = block.find("#adjacent-tables_id").val()
    let formerT = block.find("#formerTable").val()
    let idJoin = block.find("#joint_table").val()

    var relationAdj = init_data[formerT].relations[adj_table]

    var sourceField = relationAdj.from
    var targetField = relationAdj.to


    if ($('#second_constraints').is(":checked") == true) {
      var constraintsTable2 = $('.builder-basic').eq(-1).queryBuilder('getRules');
    }
    else { var constraintsTable2 = null; };

    var fields = []
    $('input:checked[name=my_form2]').each(function () {
      fields.push($(this).val());
    });


    return { 'formerTable': formerT, 'join': idJoin, 'adjacent_table': adj_table, 'sourceField': sourceField, 'targetField': targetField, 'constraints': constraintsTable2, 'fields': fields }
  }).toArray()
  return data
}







// Init the page with the JSON form containing the info of the database
$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(qb_config => {
      console.log(qb_config);
    })
})



/**
 * functions for the scroll up button
 */


//Get the button
var mybutton = document.getElementById("myBtn");

// When the user scrolls down 50px from the top of the document, show the button
window.onscroll = function () { scrollFunction() };

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


