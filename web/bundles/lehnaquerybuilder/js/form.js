/*
 * This file file is part of the QueryBuilderBundle.
 *
 * It is a free software, included in a bigger project. You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 *
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes.
 */


/**
 * Initializing the dropdown containing all tables 
 * @param {Oject} init_data 
 */
export function initFirstTable(init_data) {

  // Making sure we have a list of tables sorted by alphabetical order
  let sorted_table_list = [];
  $.each(init_data, (key, _entry) => {
    sorted_table_list.push(key);
  });
  sorted_table_list.sort();

  // Init the initial table dropdown
  $("#initial-table")
    .empty()
    .append('<option selected="true" disabled>Choose table</option>')
    .prop("selectedIndex", 0);

  // Adding every single table to the dropdown
  $.each(sorted_table_list, (_key, entry) => {
    $("#initial-table").append(
      $("<option></option>").attr("value", entry).text(entry)
    );
  });

  // Redbuilding the dropdown with the new info in it
  $("#initial-table").selectpicker("refresh");

  // Init tooltip for the dropdown
  $("#initial-table").parent().tooltip({ title: "Select the Initial Table" });
}



/**
 * Initializing the first query builder
 */
export function initFirstQueryBuilder() {

  // Init the query builder for the initial block 
  $("#initial-query-builder").queryBuilder({
    plugins: ["bt-tooltip-errors"],
    filters: [
      {
        id: "empty",
        label: "empty",
        type: "integer",
      },
    ],
  });

  // Init the reset button for this query builder
  $(".reset").click(_ => {
    let target = $(this).data("target");
    $(target).queryBuilder("reset");
  });
}

/**
 * Initializing the dropdown containing the first fields and the first query builder according to the choice of initial table
 * @param {Object} init_data 
 */
export function initFirstFields(init_data) {

  // What occurs when you choose a table and/or change it
  document.getElementById("initial-table").onchange = function (event) {
    let target_table = event.target.value;
    let table_data = init_data[target_table];

    // Init query-builder with fields and filters
    $("#initial-query-builder").queryBuilder(
      "setFilters",
      true,
      table_data.filters
    );

    // Init list of fields ( without the dateCre, userCre, dateMaj, userMaj)
    let items = table_data.filters.filter((field) => {
      return !(field.label.endsWith("Cre") || field.label.endsWith("Maj"));
    });

    // Init the dropdown containing the initial fields related to the chosen table
    $("#initial-fields").empty();
    $.each(items, (field) => {
      $("#initial-fields").append(
        $("<option></option>")
          .attr("value", items[field].label)
          .text(items[field].label)
      );
    });

    // Init the tooltip for the initial table dropdown
    $("#initial-fields").parent().tooltip({ title: "Select the Fields (all selected by default)" });

    // Making sure the dropdown works
    $("#initial-fields").multiselect("rebuild");
    $("#initial-fields").multiselect("selectAll", false);
    $("#initial-fields").multiselect("updateButtonText");

    // Enables the plus button to add a join block when the first table is chosen (Disabled by default)
    document.getElementById("add-join").disabled = false;
    document.getElementById("submit-button").disabled = false;
  };
}


/**
 * Function called when the "plus" button is clicked (using Mustache.js)
 * @param {Number} block_id containing the current join block id
 * @return {String} 
 */
function addJoin(block_id) {

  // Making template's block with mustache.js
  let newBlock = Mustache.render($("#form-block-template").html(), {
    id: block_id,
  });

  // Pushing the new block to the div containing all the blocks
  $("#add-constraints").append(newBlock);

  // creating the new block
  newBlock = $("#form-block-" + block_id);

  // Query builder initialization for join blocks
  newBlock.find(".collapsed-query-builder").queryBuilder({
    plugins: ["bt-tooltip-errors"],
    filters: [
      {
        id: "empty",
        label: "empty",
        type: "integer",
      },
    ],
  });

  // Reset button
  newBlock.find(".reset").click(function () {
    let target = $(this).data("target");
    $(target).queryBuilder("reset");
  });


  // Init switchobox buttons
  $("[data-toggle='toggle']").bootstrapToggle("destroy");
  $("[data-toggle='toggle']").bootstrapToggle();

  // Targeting the collapsed block of query builder
  newBlock.find(".join-applied-constraints").hide();
  newBlock.find("#join-constraints-switchbox").change(function () {
    newBlock.find(".join-applied-constraints").toggle("slow");
  });

  // Making sure those are disabled on reload
  document.getElementById("add-join").disabled = true;
  document.getElementById("submit-button").disabled = true;

  return newBlock;
}

let new_block_id = 0;
/**
 * Init a join block each time you click on the plus button. 
 * @param {Array} joinType containing all the joins possible
 * @param {Object} init_data containing all the data in the form
 */
export function initJoinBlock(joinType, init_data) {

  // After each time the user clicks on the add join button
  document.getElementById("add-join").onclick = function() {

    // Adding 1 at each click 
    new_block_id += 1;

    // Adding a block of query
    let newBlock = addJoin(new_block_id);

    // Filling the menu containing the possible joins
    newBlock.find("#join-type").empty().prop("selectedIndex", 0);
    $.each(joinType, (_index, value) => {
      newBlock.find("#join-type").append($("<option></option>").attr("value", value).text(value));
    });

    // Making sure the dropdown is initialized correctly
    newBlock.find("#join-type").selectpicker("refresh");

    // Previous tables available when you choose a new table to make joins
    let all_adj_tables = $(".adjacent-tables")
      .map(function () {
        return $(this).val();
      })
      .get();
    let first_selection = document.getElementById("initial-table").value;
    all_adj_tables.push(first_selection);
    all_adj_tables = [...new Set(all_adj_tables)];
    all_adj_tables.sort();

    // Init the dropdown containing all the previously chosen tables
    newBlock
      .find("#former-table")
      .empty()
      .append(
        '<option selected="true" disabled>Choose one previous table</option>'
      )
      .prop("selectedIndex", 0);
    $.each(all_adj_tables, (_index, value) => {
      if (value != "") {
        newBlock
          .find("#former-table")
          .append($("<option></option>").attr("value", value).text(value));
      }
    });

    // Making sure the first table in the dropdown is always selected
    newBlock
      .find("#former-table")
      .val(newBlock.find("#former-table").find("option:enabled:first").val());

    // When you select or change the value of the previous table you want to select
    newBlock
      .find("#former-table")
      .change(event => {
        let target_table = event.target.value;
        let table_data = init_data[target_table];

        // Init the menu
        newBlock
          .find("#adjacent-tables")
          .empty()
          .append(
            '<option selected="true" disabled>Choose adjacent table</option>'
          )
          .prop("selectedIndex", 0);

        // Making sure we have a list of adjacent tables sorted by alphabetical order
        let sorted_adj_tables_list = [];
        $.each(table_data.relations, (key, _entry) => {
          sorted_adj_tables_list.push(key);
        });
        sorted_adj_tables_list.sort();

        $.each(sorted_adj_tables_list, (_key, value) => {
          newBlock
            .find("#adjacent-tables")
            .append($("<option></option>").attr("value", value).text(value));
        });

        newBlock.find("#adjacent-tables").selectpicker("refresh");

        // Disabling the plus button and the submit button when the former table is changed and therefore no adjacent table is selected
        document.getElementById("add-join").disabled = true;
        document.getElementById("submit-button").disabled = true;

        if (newBlock.find(".highlight-div")) {
          newBlock.removeClass("highlight-div");
        }
      })
      .selectpicker("refresh")
      .change();

    // When you click to select/or change an adjacent table
    newBlock.find(".adjacent-tables").change((event) => {
      let target_table = event.target.value;
      let table_data = init_data[target_table];

      // Init query-builder with the fields of the selected table and adequate filters
      newBlock
        .find(".collapsed-query-builder")
        .queryBuilder("setFilters", true, table_data.filters);

      // Init dropdown containing the fields related to the chosen adjacent table
      newBlock.find(".table-selects").empty();
      let items = table_data.filters.filter((field) => {
        return !(field.label.endsWith("Cre") || field.label.endsWith("Maj"));
      });
      $.each(items, (field) => {
        newBlock
          .find(".table-selects")
          .append(
            $("<option></option>")
              .attr("value", items[field].label)
              .text(items[field].label)
          );
      });

      // Making sure the dropdown is built correctly
      newBlock.find(".table-selects").multiselect("rebuild");
      newBlock.find(".table-selects").multiselect("updateButtonText");

      // Making sure the buttons are enabled after an adjacent table is chosen
      document.getElementById("add-join").disabled = false;
      document.getElementById("submit-button").disabled = false;
    });

    // Init the dropdown when the add-join button is clicked
    newBlock.find(".table-selects").multiselect({
      includeSelectAllOption: true,
      allSelectedText: "All fields selected",
      nonSelectedText: "No field(s) selected",
      numberDisplayed: 7,
      buttonWidth: "225",
    });
    newBlock.find(".table-selects").multiselect("rebuild");
    newBlock.find(".table-selects").multiselect("updateButtonText");

    // Init tooltips for the dropdowns
    $("#former-table").parent().tooltip({ title: "Select a previously chosen Table" });
    $("#join-type").parent().tooltip({ title: "Choose a JOIN Type" });
    $("#adjacent-tables").parent().tooltip({ title: "Select an Adjacent Table to the Former Table currently selected" });
    $(".table-selects").parent().tooltip({ title: "Select the Fields (none selected by default)" });
    

    // Remove Join button to give the user the possibility to remove a join block
    newBlock.find(".remove").click(_ => {
      newBlock.find(".form-block").remove();
      if (newBlock.find(".highlight-div")) {
        newBlock.removeClass("highlight-div");
      }

      // The alert is there to guide the user on why there are highlighted blocks
      alert(
        "Removed Join Block Successfully!\nBe warned : you might need to make changes in the higlighted blocks!"
      );
      let blockList = document.getElementsByClassName("form-block-id");
      let suppressedJoinId = newBlock.find(".form-block").prevObject[0].id;
      $.each(blockList, (item) => {
        if (blockList[item].id > suppressedJoinId) {
          document.getElementById(blockList[item].id).className +=
            " highlight-div";
        }
      });
    });
  };
}



/**
 * Get information contained in the initial block
 * @return {Object}
 */
export function get_form_initial() {
  let table1 = document.getElementById("initial-table");
  let initialTable = table1.options[table1.selectedIndex].value;

  // Constraints
  if ($("#initial-constraints-switchbox").is(":checked") == true) {
    var constraintsTable1 = $(".collapsed-query-builder")
      .eq(0)
      .queryBuilder("getRules");
  } else {
    var constraintsTable1 = null;
  }

  // Checked inputs
  let fieldsSelected = $("#initial-fields").find("option:selected");
  let initialFields = [];
  fieldsSelected.each(function () {
    initialFields.push($(this).val());
  });

  return { initialTable, constraintsTable1, initialFields };
}


/**
 * Get the information contained in each join block
 * @param {Object} init_data 
 * @return {Array} 
 */
export function get_form_block_data(init_data) {
  let block_list = $(".form-block");
  let data = block_list
    .map(function () {
      let block = $(this);
      let adj_table = block.find("#adjacent-tables").val();
      let formerT = block.find("#former-table").val();
      let idJoin = block.find("#join-type").val();
      let selectedFields = block.find(".table-selects option:selected");
      let fields = [];
      selectedFields.each(function () {
        fields.push($(this).val());
      });

      // Obtaining the source field and target field
      let relationAdj = init_data[formerT].relations[adj_table];
      let sourceField = relationAdj.from;
      let targetField = relationAdj.to;

      // Constraints
      if (block.find("#join-constraints-switchbox").is(":checked") == true) {
        var constraintsTable2 = block
          .find(".collapsed-query-builder")
          .queryBuilder("getRules");
      } else {
        var constraintsTable2 = null;
      }

      return {
        formerTable: formerT,
        join: idJoin,
        adjacent_table: adj_table,
        sourceField: sourceField,
        targetField: targetField,
        constraints: constraintsTable2,
        fields: fields,
      };
    })
    .toArray();

  return data;
}

/**
 * Displaying the "scroll to the top" button 
 */
export function scrollFunction() {
  if (document.body.scrollTop > 30 || document.documentElement.scrollTop > 30) {
    document.getElementById("myBtn").style.display = "block";
  } else {
    document.getElementById("myBtn").style.display = "none";
  }
}

/**
 * Scrolling to the top of the form
 */
export function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

