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
    id: "empty",
    label: "empty",
    type: "integer"
  }],

  // rules: rules_basic
});


$('.reset').on('click', function() {
  var target = $(this).data('target');

  $('#builder-'+target).queryBuilder('reset');
});


$('#btn-reset').on('click', function() {
  $('#builder-basic').queryBuilder('reset');
});

$('#btn-set').on('click', function() {
  $('#builder-basic').queryBuilder('setRules', rules_basic);
});



