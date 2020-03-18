/* choose first table and constraints on it*/
$(document).ready(function () {
  let dropdown = $('#first-table');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Choose table</option>');
  dropdown.prop('selectedIndex', 0);


  $.getJSON("init", function (data) {
    $.each(data, function (key, entry) {
      dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })
  });

  $('#first-table').click(function () {
    var showData = $('#show-data');
  
    var liste = document.getElementById("first-table");
    let target_table = $(liste).val();
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



/*$.getJSON('init', function (data) {
  let n = $( "input:checked" ).val();
  let table_data2 = data[n];
  console.log(table_data2);

});*/


/* relation between tables */
joints = [
  'inner join',
  'left join',
  'right join',
  'cross join',
  'self join',
  'full join'
];


/* choosing table among others already chosen, joins, adjacent tables*/
$('#add-joint').click(function () {
  let menu_tables = $('.previous-table:last > option');
  let adj_table = $('.adjacent-tables').eq(-1).find(':selected').text();

  console.log(menu_tables); 
  addJoint();
  let dropdown = $('.joints').eq(-1);
  let dropdown2 = $('.previous-table').eq(-1);

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Choose joint</option>');
  dropdown.prop('selectedIndex', 0);

  dropdown2.empty();


  if (menu_tables.length == 0) {
    dropdown2.append('<option selected="true" disabled>Choose one previous table</option>');
    dropdown2.prop('selectedIndex', 0);
    let first_selection = $('#first-table').find(':selected').text(); 
    dropdown2.append($('<option></option>').attr('value', first_selection).text(first_selection));
  }
  else {
    $.each(menu_tables, function (key, entry) {
      dropdown2.append($('<option></option>').attr('value', entry.value).text(entry.value));
    });
    dropdown2.append($('<option></option>').attr('value', adj_table).text(adj_table));
  }




  $.each(joints, function (index, value) {
    dropdown.append($('<option></option>').attr('value', value).text(value));

  });


  /* json data for adjacent tables*/
  $('.previous-table').eq(-1).change(function () {
    let dropdown = $('.adjacent-tables').eq(-1);

    dropdown.empty();

    dropdown.append('<option selected="true" disabled>Choose adjacent table</option>');
    dropdown.prop('selectedIndex', 0);

    var texte = $('.previous-table').eq(-1).find(":selected").text();

    $.getJSON("init", function (data) {

      var texte2 = data[texte];
      $.each(texte2.relations, function (key, value) {
        dropdown.append($('<option></option>').attr('value', key).text(key));
      });
    })
  });


  /* filters for table 2 */
  $('.new-constraints').click(function () {
    if($(this).is(":checked")==false){
      return;
    }
    var showData = $('.show-data2').eq(-1);

    var texte = $('.adjacent-tables').eq(-1).find(':selected').text();


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



/*
function removeDiv() {
  var node = document.getElementById("addConstraints");
  if (node.parentNode) {
    node.parentNode.removeChild(node);}
}*/







function addJoint() {
  var cont = $('.add-constraints').eq(-1);
  var temp = document.getElementsByTagName("template")[0];
  var clon = temp.content.cloneNode(true);
  cont.append(clon);
}

function getTable() {
  console.log("test");
  var table_result = $('#first-table').val();
  if($('#first-constraints').is(":checked")==true){
    var result = $('.builder-basic').eq(0).queryBuilder('getRules');
    if (!$.isEmptyObject(result)) {
      alert(JSON.stringify(result, null, 2));
  }
  };
}


$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(qb_config => {
      console.log(qb_config);

    })
})

