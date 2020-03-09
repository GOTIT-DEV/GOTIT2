
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



$('#btn-set').on('click', function() {
  $('#builder-basic').queryBuilder('setRules', rules_basic);
});

/*

var filtersValues;
$.getJSON('init.json', function(data) {
  filtersValues = data."_embedded".filters;
});



















$(function() {
  var $reportTemplate = $('#report-template'),
      $fieldsInUseWarning = $('#fields-in-use-warning');
      $inspectionTemplateCommonFields = $('#inspection-template-common-fields');
      
  $builder = $('#builder')
  

  .queryBuilder({
    operators: [
      'specific-date', 'date-range', 'time-range', 
      'any', 'none', 
      'includes', 'include-all-of', 'include-any-of', 'includes-any-of', 
      'excludes', 'excludes-all-of', 'missing-all-of', 'missing-any-of', 
      'yes', 'no', 
      'have', 'dont-have', 
      'must', 'must-not',
      'has', 'has-not',
      'is', 'is-not',
      'does', 'does-not',
      'can-be',
      'signed-off', 'not-signed-off'
    ].map(function(operator) {
        return {
          type: operator,
          nb_inputs: 1,
          apply_to: null,
          multiple: true
        };
    }),
    lang: {
      add_rule: "Field",
      add_group: "AND / OR",
      operators: {
        any: 'Any',
        none: 'None',
        includes: 'Includes',
        'include-all-of': 'Include All Of',
        'include-any-of': 'Include Any Of',
        'includes-any-of': 'Includes Any Of',
        excludes: 'Excludes',
        'excludes-all-of': 'Excludes All Of',
        'missing-all-of': 'Missing All Of',
        'missing-any-of': 'Missing Any Of',
        'specific-date': 'Of a Specific Date',
        'date-range': 'Within a Date Range',
        'time-range': 'Within a Time Range',
        have: 'Have',
        'dont-have': 'Don\'t Have',
        must: 'Must',
        'must-not': 'Must Not',
        yes: 'Yes',
        no: 'No',
        has: 'Has',
        'has-not': 'Has Not',
        'is': 'Is',
        'is-not': 'Is Not',
        'does': 'Does',
        'does-not': 'Does Not',
        'can-be': 'Can Be',
        'signed-off': 'Signed Off',
        'not-signed-off': 'Not Signed Off'
      }
    },
    plugins: [
      'sortable'
    ],
    templates: {
      operatorSelect: '\
        {{ var optgroup = null; }} \
        <select class="form-control" name="{{= it.rule.id }}_operator"> \
          {{~ it.operators: operator }} \
            {{? optgroup !== operator.optgroup }} \
              {{? optgroup !== null }}</optgroup>{{?}} \
              {{? (optgroup = operator.optgroup) !== null }} \
                <optgroup label="{{= it.translate(it.settings.optgroups[optgroup]) }}"> \
              {{?}} \
            {{?}} \
            <option value="{{= operator.type }}" {{? operator.icon}}data-icon="{{= operator.icon}}"{{?}}>{{= it.translate("operators", operator.type) }}</option> \
          {{~}} \
          {{? optgroup !== null }}</optgroup>{{?}} \
        </select>',
        
      rule: '\
        <div id="{{= it.rule_id }}" class="rule-container"> \
          <div class="rule-header"> \
            <div class="btn-group pull-right rule-actions"> \
              <button type="button" class="btn btn-sm btn-danger" data-delete="rule"> \
                <i class="{{= it.icons.remove_rule }}"></i> \
              </button> \
            </div> \
          </div> \
          {{? it.settings.display_errors }} \
            <div class="error-container"><i class="{{= it.icons.error }}"></i></div> \
          {{?}} \
          <div class="filter-operator-wrapper"> \
            <div class="rule-filter-container"></div> \
            <div class="rule-operator-container"></div> \
            <label> \
              <input type="checkbox" value="Allow Configuring On Query" /> Allow configuring on Query? \
            </label> \
          </div> \
          <div class="rule-value-container"></div> \
        </div>',
        
      group: '\
        <div id="{{= it.group_id }}" class="rules-group-container"> \
          <div class="rules-group-header"> \
            <div class="btn-group pull-right group-actions"> \
              <button type="button" class="btn btn-sm btn-success" data-add="rule"> \
                <strong><i class="{{= it.icons.add_rule }}"></i> {{= it.translate("add_rule") }}</strong> \
              </button> \
              {{? it.settings.allow_groups===-1 || it.settings.allow_groups>=it.level }} \
                <button type="button" class="btn btn-sm btn-success" data-add="group"> \
                  <strong><i class="{{= it.icons.add_group }}"></i> {{= it.translate("add_group") }}</strong> \
                </button> \
              {{?}} \
              {{? it.level>1 }} \
                <button type="button" class="btn btn-sm btn-danger" data-delete="group"> \
                  <i class="{{= it.icons.remove_group }}"></i> \
                </button> \
              {{?}} \
            </div> \
            <div class="btn-group group-conditions"> \
              {{~ it.conditions: condition }} \
                <label class="btn btn-sm btn-default"> \
                  <input type="radio" name="{{= it.group_id }}_cond" value="{{= condition }}"> {{= it.translate("conditions", condition) }} \
                </label> \
              {{~}} \
            </div> \
            {{? it.settings.display_errors }} \
              <div class="error-container"><i class="{{= it.icons.error }}"></i></div> \
            {{?}} \
          </div> \
          <div class=rules-group-body> \
            <div class=rules-list></div> \
          </div> \
        </div>'
    },
    default_filter: 'note-date-time',
    filters: [
      {
        id: 'note-date-time',
        label: 'Note Date/Time',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'note-date-time' },
        input: getRuleValueContainer,
        input_event: 'dp.change',
        operators: ['specific-date', 'date-range', 'time-range'],
        valueGetter: function(rule) {
          var values = [];
          
          rule.$el.find('.rule-value-container input:checked')
                    .closest('div')
                    .find(':input')
                    .each(function () {
                      values.push(this.value);
                    });
          
          return values;
        },
        valueSetter: function(rule, value) {
          if (value[0])
    		    rule.$el.find('.rule-value-container input[value="' + value[0] + '"]').prop('checked', 'true');
          
    		  if (value.length > 1) {
            var index = 0;
            
            rule.$el
              .find('.rule-value-container input:checked')
              .closest('div')
              .find(':input, select')
              .each(function() {
              if (index > 0) {
                  this.value = value[index];
                }
                index++;
              });
          }
        },
        validation: {
          allow_empty_value: true,
          callback: validateDateTime
        }
      },
      {
        id: 'update-date-time',
        label: 'Update Date/Time',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'note-date-time' },
        input: getRuleValueContainer,
        input_event: 'dp.change',
        operators: ['specific-date', 'date-range', 'time-range'],
        default_operator: 'date-range',
        valueGetter: function(rule) {
          var values = [];
          
          rule.$el.find('.rule-value-container input:checked')
                    .closest('div')
                    .find(':input')
                    .each(function () {
                      values.push(this.value);
                    });
          
          return values;
        },
        valueSetter: function(rule, value) {
          if (value[0])
    			  rule.$el.find('.rule-value-container input[value="' + value[0] + '"]').prop('checked', 'true');
          
    		  if (value.length > 1) {
      			var index = 0;
      			
      			rule.$el
        			.find('.rule-value-container input:checked')
        			.closest('div')
        			.find(':input, select')
        			.each(function() {
        			  if (index > 0) {
                  this.value = value[index];
        			  }
        			  index++;
        			});
    		  }  
        },
        validation: {
          allow_empty_value: true,
          callback: validateDateTime
        }
      },
      {
        id: 'tags',
        label: 'Tags',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'tags' },
        input: getRuleValueContainer,
        operators: ['any', 'none', 'include-all-of', 'include-any-of', 'missing-all-of', 'missing-any-of'],
        valueGetter: function(rule) {
          if (rule.operator.type == "any" || rule.operator.type == "none")
            return rule.operator.type == 'any';
            
          var values = rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input').val();
          
          if (values) {
            values = values.split(',').map(function (element) {
              return "/api/tagValues/" + element;
            });
          }
          
          return values;
        },
        valueSetter: function(rule, value) {
          if (value.length > 0) {
      			value = value.map(function (element) {
      			  return element.split("/").pop();
      			});
              
      			rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input')[0].selectize.setValue(value);
    		  }
        },
        validation: {
          allow_empty_value: true
        }
      },
      {
        id: 'note-contents',
        label: 'Note Contents',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'note-contents' },
        input: getRuleValueContainer,
        operators: ['includes', 'excludes'],
        valueGetter: function(rule) {
          var text = rule.$el.find('.rule-value-container .' + rule.operator.type + ' input').val(),
              settings = rule.$el.find('.rule-value-container .' + rule.operator.type + ' > label > input');
              
          var settingsJSON = {
            'case-sensitive': settings[0].checked,
            'whole-word': settings[1].checked,
            'wildcards': settings[2].checked
          };
          
          return [text, settingsJSON];
        },
        valueSetter: function(rule, value) {
    		  rule.$el.find('.rule-value-container .' + rule.operator.type + ' input')[0].value = value[0];
          
    		  if (value[1]['case-sensitive'])
    			  rule.$el.find('.rule-value-container .' + rule.operator.type + ' > label > input')[0].checked = true;
            
    		  if (value[1]['whole-word'])
    			  rule.$el.find('.rule-value-container .' + rule.operator.type + ' > label > input')[1].checked = true;
            
    		  if (value[1]['wildcards'])
    			  rule.$el.find('.rule-value-container .' + rule.operator.type + ' > label > input')[2].checked = true;
        },
        validation: {
          allow_empty_value: true,
        },
        default_operator: 'includes'
      },
      {
        id: 'created-by',
        label: 'Created By',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'users' },
        input: getRuleValueContainer,
        operators: ['includes-any-of', 'excludes-all-of'],
        valueGetter: function(rule) {
          var values = rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input').val();
          
          if (values) {
            values = values.split(',').map(function (element) {
              return "/api/logBookUsers/" + element;
            });
          }
          
          return values;
        },
        valueSetter: function(rule, value) {
          value = value.map(function (element) {
    			  return element.split("/").pop();
    		  });
            
    		  rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input')[0].selectize.setValue(value);
        },
        validation: {
          allow_empty_value: true
        },
        default_operator: 'includes-any-of'
      },
      {
        id: 'updated-by',
        label: 'Updated By',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'users' },
        input: getRuleValueContainer,
        operators: ['includes-any-of', 'excludes-all-of'],
        valueGetter: function(rule) {
          var values = rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input').val();
          
          if (values) {
            values = values.split(',').map(function (element) {
              return "/api/logBookUsers/" + element;
            });
          }
          
          return values;
        },
        valueSetter: function(rule, value) {
          value = value.map(function (element) {
    			  return element.split("/").pop();
    		  });
            
          rule.$el.find('.rule-value-container .' + rule.operator.type + ' > input')[0].selectize.setValue(value);
        },
        validation: {
          allow_empty_value: true
        },
        default_operator: 'includes-any-of'
      },
      {
        id: 'turnover',
        label: 'Turnover',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'turnover' },
        input: getRuleValueContainer,
        operators: ['yes', 'no'],
        valueGetter: function(rule) {
          return rule.operator.type == 'yes';
        },
        validation: {
          allow_empty_value: true
        },
        default_operator: 'yes'
      },
      {
        id: 'attachments',
        label: 'Attachments',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'attachments' },
        input: getRuleValueContainer,
        operators: ['any', 'none', 'have', 'dont-have'],
        valueGetter: function(rule) {
          if (rule.operator.type == 'any' || rule.operator.type == 'none')
            return rule.operator.type == 'any';
            
          var checked = rule.$el.find('.rule-value-container .' + rule.operator.type + ' input:checked'),
              values = [];
            
          checked.each(function (index, element) {
            var inputValues = [];
            
            $(this).closest('label')
                   .find('input')
                   .each(function (index, element) {
                     inputValues.push(this.value);
                   });
                   
            values.push(inputValues);
          });
          
          return values;
        },
        valueSetter: function(rule, value) {
          for (var i = 0; i < value.length; i++) {
      			rule.$el
      			  .find('.rule-value-container .' + rule.operator.type + ' input[value="' + value[i][0] + '"]')
      			  .prop('checked', 'true')
      				.siblings('input')[0].value = value[i][1];
    		  }
        },
        validation: {
          allow_empty_value: true,
          callback: function (value, rule) {
      			var moreThan, lessThan;
                  
      			for (var i = 0; i < value.length; i++) {
      			  switch (value[i][0]) {
        				case "More Than":
        				  value[i][1] = parseInt(value[i][1], 10);
        				  moreThan = value[i][1];
        				  break;
        				case "Less Than":
        				  value[i][1] = parseInt(value[i][1], 10);
        				  lessThan = value[i][1];
        				  break;
        				case "Exactly":
        				  value[i][1] = parseInt(value[i][1], 10);
        				  break;
      			  }
      			}	
              
      			if (!isNaN(moreThan) && !isNaN(lessThan) && ((rule.operator.type == 'have' && moreThan > lessThan) || (rule.operator.type == 'dont-have' && lessThan > moreThan)))
      				return "More Than and Less Than must create a valid range";
      
      			return true;
    		  }
        },
        default_operator: 'any'
      },
      {
        id: 'comments',
        label: 'Comments',
        optgroup: 'Default Fields',
        data: { htmlTemplateId: 'comments' },
        input: getRuleValueContainer,
        input_event: 'dp.change',
        operators: ['any', 'none', 'must', 'must-not'],
        valueGetter: function(rule) {
          if (rule.operator.type == 'any' || rule.operator.type == 'none')
            return rule.operator.type == 'any';
  
          var checked = rule.$el.find('.rule-value-container .' + rule.operator.type + ' input:checked'),
              values = [];
              
          checked.each(function (index, element) {
            var inputValues = [];
            $(this).closest('div')
                   .find('input')
                   .each(function (index, element) {
                     inputValues.push(this.value);
                   });
                   
            values.push(inputValues);
          });
          
          return values;
        },
        valueSetter: function(rule, value) {
          for (var i = 0; i < value.length; i++) {
      			var inputs = rule.$el
      			  .find('.rule-value-container .' + rule.operator.type + ' input[value="' + value[i][0] + '"]')
      				.closest('div')
      				.find('input');
      								           
      			inputs[0].checked = true;
              
      			switch (value[i][0]) {
      			  case "Text":
        				inputs[1].value = value[i][1];
        				break;
      			  case "From User":
        				value[i][1] = value[i][1].map(function(element) {
        				  return element.split("/").pop();
        				});
        				inputs[1].selectize.setValue(value[i][1]);
      				  break;
      			  case "Between Times":
        				inputs[1].value = value[i][1];
        				inputs[2].value = value[i][2];
        				break;
      			}
    		  }
        },
        validation: {
          allow_empty_values: true,
          callback: function(value, rule) {
            for (var i = 0; i < value.length; i++) {
      			  switch (value[i][0]) {
      				case "From User":
      				  value[i].splice(2, 1);
      				  value[i][1] = value[i][1] ? value[i][1].split(',').map(function(element) {
      					  return "/api/logBookUsers/" + element;
      				  }) : null;
      				  break;
      
      				case "Between Times":
      				  if (Date.parse(value[i][1]) > Date.parse(value[i][2])) {
        					var x = value[i][1];
        					value[i][1] = value[i][2];
        					value[i][2] = x;
      				  }
      				  break;
      			  }
      			}
      
      			return true;
          }
        },
        default_operator: 'any'
      }
    ]
  })

});

function getRuleValueContainer(rule, name) {
 var templateContent = $('#' + rule.filter.data.htmlTemplateId).clone().prop('content'),
     inspectionTemplateCommonFields = 
       rule.filter.data.logBookTemplateType == 'Inspection' ? 
       $inspectionTemplateCommonFields.clone().prop('content') : '';

 return $(templateContent.children)
  .each(function() {
    $(this).toggleClass('hide', !$(this).hasClass(rule.operator.type) || 
                                (this.hasAttribute('data-template-segment-only') && rule.filter.optgroup == 'Default Fields'))
           .find('input:radio')
           .attr('name', rule.id);
  })
  .wrapAll('<div class=' + rule.filter.data.htmlTemplateId + '></div>')
  .parent()
  .append(inspectionTemplateCommonFields)
  .prop('outerHTML');
}

function validateDateTime(value, rule) {
  var checkedValue = rule.$el.find('.rule-value-container .' + rule.operator.type + ' input:checked').val();
  if (!checkedValue)
    value.length = 0;
    
  var selection = value[0];
    
  switch (selection) {
    case 'Number of Days Ago':
      value[1] = parseInt(value[1], 10);
      break;
      
    case 'Between Days Ago':
      value[1] = parseInt(value[1], 10);
      value[2] = parseInt(value[2], 10);
        
      if (value[1] < value[2]) {
        var x = value[1];
        value[1] = value[2];
        value[2] = x;
      }
      break;
      
    case 'Between Dates':
    case 'Between Dates/Times':
      if (Date.parse(value[1]) > Date.parse(value[2])) {
        var x = value[1];
        value[1] = value[2];
        value[2] = x;
      }
      break;
  }
  
  return true;
}


*/
