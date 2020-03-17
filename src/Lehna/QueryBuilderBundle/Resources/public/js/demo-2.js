var rules_basic2 = {
  condition: 'AND',
  rules: [{}, {
    condition: 'OR',
    rules: [{}, {
      }]
  }]
};

$('#builder-basic-2').queryBuilder({
plugins: ['bt-tooltip-errors'],

filters:  [ 
  {
  id: "empty",
  label: "empty",
  type: "integer"
}],

// rules: rules_basic2
});



$('#btn-reset').on('click', function() {
$('#builder-basic-2').queryBuilder('reset');
});

$('#btn-set').on('click', function() {
$('#builder-basic-2').queryBuilder('setRules', rules_basic2);
});
