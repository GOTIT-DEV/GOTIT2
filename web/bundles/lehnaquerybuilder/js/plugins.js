$.fn.queryBuilder.define('date-inputmask', function(options) {
  if (!jQuery.fn.inputmask) {
    $.fn.queryBuilder.constructor.utils.error(
      'MissingLibrary',
      'jQuery Inputmask is required to use "date-inputmask" plugin. Get it here: https://github.com/RobinHerbots/Inputmask');
 } 

 var Selectors = $.fn.queryBuilder.constructor.selectors;

 this.on('afterCreateRuleInput', function(e, rule) {
 if (rule.filter.type === "date") {
   rule.$el.find(Selectors.value_container).find('input')
     .prop("placeholder", options.placeholder)
     .inputmask(options);
 }
 });
},{
 mask : "9999-99-99",
 placeholder : "YYYY-MM-DD",
 regex: "[1-2]\\d{3}-[0-1]\\d-[0-3]\\d",
 shiftPositions: false,
 tabThrough: true,
})