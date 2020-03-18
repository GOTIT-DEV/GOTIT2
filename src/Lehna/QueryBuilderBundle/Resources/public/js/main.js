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
  
      $('#builder-basic').queryBuilder('setFilters',true, table_data.filters);
      
  
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
  let dropdown = $('.joints');
  let dropdown2 = $('.previous-table');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Choose joint</option>');
  dropdown.prop('selectedIndex', 0);

  dropdown2.empty();

  dropdown2.append('<option selected="true" disabled>Choose one previous table</option>');
  dropdown2.prop('selectedIndex', 0);

  $.getJSON("init", function (data) {
    $.each(data, function (key, entry) {
      dropdown2.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })
  });

  $.each(joints, function (index, value) {
    dropdown.append($('<option></option>').attr('value', value).text(value));

  });
  /* json data for adjacent tables*/
  $('.previous-table').onchange(function () {
    let dropdown = $('.adjacent-tables');
    console.log("test");
    dropdown.empty();

    dropdown.append('<option selected="true" disabled>Choose adjacent table</option>');
    dropdown.prop('selectedIndex', 0);

    var liste, texte;
    liste = document.getElementsByClassName("previous-table");
    console.log(liste[-1]);
    let lastElement = liste[length-1];
    texte = lastElement.options[lastElement.selectedIndex].text;

    $.getJSON("init", function (data) {
      var texte2 = data[texte];
      console.log(texte2.relations);
      $.each(texte2.relations, function (key, value) {
        dropdown.append($('<option></option>').attr('value', key).text(key));
      });
    })
  });
  /* filters for table 2 */
  $('.new-constraints').change(function () {
    var showData = $('#show-data2');

    var liste = document.getElementsByClassName("adjacent-tables");
    let lastElement = liste[length-1];
    texte = lastElement.options[lastElement.selectedIndex].text;

    $.getJSON('init', function (data) {

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
  var cont = document.getElementById("add-constraints");
  var temp = document.getElementsByTagName("template")[0];
  var clon = temp.content.cloneNode(true);
  cont.appendChild(clon);
}

function getTable() {
  console.log("test");
  var table_result = $('#first-table').val();
  console.log(table_result);
  if($('#first-constraints').is(":checked")==true){
    var result = $('#builder-basic').queryBuilder('getRules');
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






