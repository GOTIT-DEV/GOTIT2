/* choose first table and constraints on it*/
$(document).ready(function () {
  let dropdown = $('#get-data');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Choose table</option>');
  dropdown.prop('selectedIndex', 0);


  $.getJSON("init", function (data) {
    $.each(data, function (key, entry) {
      dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })
  });

  $('#get-data').click(function () {
    var showData = $('#show-data');
  
    var liste = document.getElementById("get-data");
    let target_table = $(liste).val()
    $.getJSON('init', function (data) {
      let table_data = data[target_table]
  
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
jointures = [
  'inner join',
  'left join',
  'right join',
  'cross join',
  'self join',
  'full join'
];

/* choosing table among others already chosen, joins, adjacent tables*/
$('#get-addDiv').click(function () {
  let dropdown = $('#get-data3');
  let dropdown2 = $('#get-data2');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Joins</option>');
  dropdown.prop('selectedIndex', 0);

  dropdown2.empty();

  dropdown2.append('<option selected="true" disabled>Joins</option>');
  dropdown2.prop('selectedIndex', 0);

  $.getJSON("init", function (data) {
    $.each(data, function (key, entry) {
      dropdown2.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
    })
  });

  $.each(jointures, function (index, value) {
    dropdown.append($('<option></option>').attr('value', value).text(value));

  });
  /* json data for adjacent tables*/
  $('#get-data4').click(function () {
    let dropdown = $('#get-data4');

    dropdown.empty();

    dropdown.append('<option selected="true" disabled>Relations</option>');
    dropdown.prop('selectedIndex', 0);

    var liste, texte;
    liste = document.getElementById("get-data2");
    texte = liste.options[liste.selectedIndex].text;

    $.getJSON("init", function (data) {
      var texte2 = data[texte];
      console.log(texte2.relations);
      $.each(texte2.relations, function (key, value) {
        dropdown.append($('<option></option>').attr('value', key).text(key));
      });
    })
  });
  /* filters for table 2 */
  $('#getconstraints').click(function () {
    var showData = $('#show-data2');

    var liste, texte;
    liste = document.getElementById("get-data4");
    texte = liste.options[liste.selectedIndex].text;

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







function addDiv() {
  var cont = document.getElementById("addContraints");
  var temp = document.getElementsByTagName("template")[0];
  var clon = temp.content.cloneNode(true);
  cont.appendChild(clon);
}

function getTable() {
  console.log("test");
  var table_result = $('#get-data').val();
  console.log(table_result);
  if($('#getdata').is(":checked")==true){
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



