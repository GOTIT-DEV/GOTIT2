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
$(document).ready(function () {
  let dropdown = $('#get-data2');

dropdown.empty();

dropdown.append('<option selected="true" disabled>Tables</option>');
dropdown.prop('selectedIndex', 0);


$.getJSON("init", function (data) {
  $.each(data, function (key, entry) {
    dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(entry.human_readable_name));
  })
});
});

/* json data for adjacent tables*/
$(document).ready(function () {
  let dropdown = $('#get-data4');

dropdown.empty();

dropdown.append('<option selected="true" disabled>Relations</option>');
dropdown.prop('selectedIndex', 0);

$.getJSON("init", function (data) {
  $.each(data, function (key, entry) {
    $.each(entry.relations, function(key, value) {
  dropdown.append($('<option></option>').attr('value', entry.human_readable_name).text(key));
});
  })
});
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

$.each(jointures, function(index, value) {
  console.log(value);
  dropdown.append($('<option></option>').attr('value', value).text(value));
  
});
});

/* filters for each table */
$('#getdata').click(function () {
  var showData = $('#show-data');

  var liste, texte;
  liste = document.getElementById("get-data");
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





$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(qb_config => {
      console.log(qb_config);

    })
})



