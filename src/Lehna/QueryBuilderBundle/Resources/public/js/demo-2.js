var rules_basic2 = {
  condition: 'AND',
  rules: [{}, {
    condition: 'OR',
    rules: [{}, {
      }]
  }]
};

$('.builder-basic').eq(1).queryBuilder({
  plugins: ['bt-tooltip-errors'],

  filters:  [ 
    {
    id: "empty",
    label: "empty",
    type: "integer"
  }],

  // rules: rules_basic2
});


