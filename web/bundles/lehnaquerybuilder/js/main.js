/* json data for choosing the first table*/
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
});

/* json data for choosing table among others already chosen*/
$('#get-data2').click(function () {
  let dropdown = $('#get-data2');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Tables</option>');
  dropdown.prop('selectedIndex', 0);

  var liste, texte;
  liste = document.getElementById("get-data");
  texte = liste.options[liste.selectedIndex].text;

  $.getJSON("init", function (data) {
    var texte2 = data[texte];
    console.log(texte2.human_readable_name);
    dropdown.append($('<option></option>').attr('value', texte2.human_readable_name).text(texte2.human_readable_name));
  });
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

/* relation between tables */
jointures = [
  'inner join',
  'left join',
  'right join',
  'cross join',
  'self join',
  'full join'
];

$(document).ready(function () {
  let dropdown = $('#get-data3');

  dropdown.empty();

  dropdown.append('<option selected="true" disabled>Joins</option>');
  dropdown.prop('selectedIndex', 0);

  $.each(jointures, function (index, value) {
    dropdown.append($('<option></option>').attr('value', value).text(value));

  });
});

/* filters for table 1*/
$('#getdata').click(function () {
  var showData = $('#show-data');

  var liste = document.getElementById("get-data");
  let target_table = $(liste).val()
  console.log(target_table)
  $.getJSON('init', function (data) {
    let table_data = data[target_table]
    console.log(table_data)

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