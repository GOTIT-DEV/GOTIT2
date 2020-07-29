
$.fn.queryBuilder.define(
  "date-inputmask",
  function (options) {
    if (!jQuery.fn.inputmask) {
      $.fn.queryBuilder.constructor.utils.error(
        "MissingLibrary",
        'jQuery Inputmask is required to use "date-inputmask" plugin. Get it here: https://github.com/RobinHerbots/Inputmask'
      );
    }

    let Selectors = $.fn.queryBuilder.constructor.selectors;

    this.on("afterCreateRuleInput", function (e, rule) {
      if (rule.filter.type === "date") {
        rule.$el
          .find(Selectors.value_container)
          .find("input")
          .prop("placeholder", options.placeholder)
          .inputmask(options);
      }
      if (rule.filter.type === "datetime") {
        rule.$el
          .find(Selectors.value_container)
          .find("input")
          .prop("placeholder", "YYYY-MM-DD hh:mm:ss")
          .inputmask({
            mask: "9999-99-99 99:99:99",
            placeholder: "YYYY-MM-DD hh:mm:ss",
            regex: "[1-2]\\d{3}-[0-1]\\d-[0-3]\\d [0-2]\\d:[0-5]\\d:[0-5]\\d",
            shiftPositions: false,
            tabThrough: true,
          });
      }
    });
  },
  {
    mask: "9999-99-99",
    placeholder: "YYYY-MM-DD",
    regex: "[1-2]\\d{3}-[0-1]\\d-[0-3]\\d",
    shiftPositions: false,
    tabThrough: true,
  }
);
