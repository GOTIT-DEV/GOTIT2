
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
    
    filters: [{
      id: 'name',
      label: 'Name',
      type: 'string'
    }, {
      id: 'category',
      label: 'Category',
      type: 'integer',
      input: 'select',
      values: {
        1: 'Books',
        2: 'Movies',
        3: 'Music',
        4: 'Tools',
        5: 'Goodies',
        6: 'Clothes'
      },
      operators: ['equal', 'not_equal', 'in', 'not_in', 'is_null', 'is_not_null']
    }, {
      id: 'in_stock',
      label: 'In stock',
      type: 'integer',
      input: 'radio',
      values: {
        1: 'Yes',
        0: 'No'
      },
      operators: ['equal']
    }, {
      id: 'price',
      label: 'Price',
      type: 'double',
      validation: {
        min: 0,
        step: 0.01
      }
    }, {
      id: 'id',
      label: 'Identifier',
      type: 'string',
      placeholder: '____-____-____',
      operators: ['equal', 'not_equal'],
      validation: {
        format: /^.{4}-.{4}-.{4}$/
      }
    }],
  
    rules: rules_basic2
  });
  
  $('#btn-reset').on('click', function() {
    $('#builder-basic-2').queryBuilder('reset');
  });
  
  $('#btn-set').on('click', function() {
    $('#builder-basic-2').queryBuilder('setRules', rules_basic2);
  });
  
  $('#btn-get').on('click', function() {
    var result = $('#builder-basic-2').queryBuilder('getRules');
    
    if (!$.isEmptyObject(result)) {
      alert(JSON.stringify(result, null, 2));
    }
  });