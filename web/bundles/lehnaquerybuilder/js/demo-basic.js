
/* example 
var rules_basic = {
  condition: 'AND',
  rules: [{
    id: 'price',
    operator: 'less',
    value: 10.25
  }, {
    condition: 'OR',
    rules: [{
      id: 'category',
      operator: 'equal',
      value: 2
    }, {
      id: 'category',
      operator: 'equal',
      value: 1
    }]
  }]
};
*/

var rules_basic = {
  condition: 'AND',
  rules: [{}, {
    condition: 'OR',
    rules: [{}, {
      }]
  }]
};



$('#builder-basic').queryBuilder({
  plugins: ['bt-tooltip-errors'],
  
  filters:  [ 
    {
    id: "id",
    label: "id",
    type: "integer"
  },
  {
    id: "dateCre",
    label: "dateCre",
    type: "datetime"
  }],

  // rules: rules_basic
});

// à voir comment utiliser $('#builder-basic').queryBuilder('setFilters', true, [ ])


$('#btn-reset').on('click', function() {
  $('#builder-basic').queryBuilder('reset');
});

$('#btn-set').on('click', function() {
  $('#builder-basic').queryBuilder('setRules', rules_basic);
});

$('#btn-get').on('click', function() {
  var result = $('#builder-basic').queryBuilder('getRules');
  
  if (!$.isEmptyObject(result)) {
    alert(JSON.stringify(result, null, 2));
  }
});



