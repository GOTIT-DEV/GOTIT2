var rules_basic = {
  condition: 'AND',
  rules: [{}, {
    condition: 'OR',
    rules: [{}, {
      }]
  }]
};



$('.builder-basic').eq(0).queryBuilder({
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

  $('.builder-'+target).eq(0).queryBuilder('reset');
});
