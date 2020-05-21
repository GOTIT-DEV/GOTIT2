/*
 * This file file is part of the QueryBuilderBundle.
 *
 * It is a free software, included in a bigger project. You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 *
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes.
 */

import { dtconfig } from "../../lehnaspeciessearch/js/datatables_utils.js";

// Initializing the first table query block
$(document).ready(function () {
  // Filling the menu with all the tables in the database
  $.getJSON("init", function (init_data) {
    $("#initial-fields").multiselect({
      includeSelectAllOption: true,
      allSelectedText: "All fields selected",
      nonSelectedText: "No field(s) selected",
      numberDisplayed: 7,
      buttonWidth: 225,
    });

    // Making sure these buttons are disabled on reload
    document.getElementById("add-join").disabled = true;
    document.getElementById("submit-button").disabled = true;
    document.getElementById("getSqlButton").disabled = true;

    // Init tooltips for initial block
    $('[data-toggle="tooltip"]').tooltip();

    // Init menu for choosing the first table
    $("#initial-table")
      .empty()
      .append('<option selected="true" disabled>Choose table</option>')
      .prop("selectedIndex", 0);

    // Making sure we have a list with the tables sorted by alphabetical order
    let table_list = [];
    $.each(init_data, function (key, _entry) {
      table_list.push(key);
    });
    let sorted_table_list = table_list.sort();

    // Adding every single table to the dropdown
    $.each(sorted_table_list, function (_key, entry) {
      $("#initial-table").append(
        $("<option></option>").attr("value", entry).text(entry)
      );
    });

    // Redbuilding the dropdown with the new info in it
    $("#initial-table").selectpicker("refresh");

    // Initialization of the query builder
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
    $(".reset").click(function () {
      let target = $(this).data("target");
      $(target).queryBuilder("reset");
    });

    // Hiding what's in the div, then showing it when the switchbox is triggered
    document.getElementById("initial-applied-constraints").style.display =
      "none";
    $("#initial-constraints-switchbox").change(function () {
      $("#initial-applied-constraints").toggle("slow");
    });

    // What occurs when you choose a table and/or change it
    $("#initial-table").change(function (event) {
      let target_table = event.target.value;
      let table_data = init_data[target_table];

      // Init query-builder with fields and filters
      $("#initial-query-builder").queryBuilder(
        "setFilters",
        true,
        table_data.filters
      );

      // Init list of fields ( without the dateCre, userCre, dateMaj, userMaj)

      var items = table_data.filters.filter(function (item) {
        return !(item.label.endsWith("Cre") || item.label.endsWith("Maj"));
      });

      $("#initial-fields").empty();

      $.each(items, function (item) {
        $("#initial-fields").append(
          $("<option></option>")
            .attr("value", items[item].label)
            .text(items[item].label)
        );
      });

      $("#initial-fields").multiselect("rebuild");
      $("#initial-fields").multiselect("selectAll", false);
      $("#initial-fields").multiselect("updateButtonText");

      // Enables the plus button to add a join block when the first table is chosen (Disabled by default)

      document.getElementById("add-join").disabled = false;
      document.getElementById("submit-button").disabled = false;
    });
  });
});

// Init possible JOINs
const joins = ["Inner Join", "Left Join"];

/**
 * Function called when the "plus" button is clicked (using mustache.js)
 */
function addJoin(block_id) {
  // Making template's block with mustache.js
  let newBlock = Mustache.render($("#form-block-template").html(), {
    id: block_id,
  });

  $("#add-constraints").append(newBlock);

  newBlock = $("#form-block-" + block_id);

  // Query builder initialization
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

  $("[data-toggle='toggle']").bootstrapToggle("destroy");
  $("[data-toggle='toggle']").bootstrapToggle();
  newBlock.find(".join-applied-constraints").hide();
  newBlock.find("#join-constraints-switchbox").change(function () {
    newBlock.find(".join-applied-constraints").toggle("slow");
  });

  $('[data-toggle="tooltip"]').tooltip();

  document.getElementById("add-join").disabled = true;
  document.getElementById("submit-button").disabled = true;

  return newBlock;
}

let new_block_id = 0;

/**
 * when you click on the plus button.
 * Choosing what join to make between a table chosen previously and an adjacent table, the fields to return and the constraints to apply.
 *
 */
$("#add-join").click(function () {
  $.getJSON("init", function (init_data) {
    // Adding 1 at each click on add-join

    new_block_id += 1;

    // Adding a block of query
    let newBlock = addJoin(new_block_id);

    // Filling the menu containing the possible joins
    let dropdown = newBlock.find("#join-type").empty().prop("selectedIndex", 0);

    $.each(joins, function (index, value) {
      dropdown.append($("<option></option>").attr("value", value).text(value));
    });

    dropdown.selectpicker("refresh");

    // Previous tables available when you choose a new table to make joins
    let all_adj_tables = $(".adjacent-tables")
      .map(function () {
        return $(this).val();
      })
      .get();

    let first_selection = $("#initial-table").val();

    all_adj_tables.push(first_selection);
    all_adj_tables = [...new Set(all_adj_tables)];
    all_adj_tables = all_adj_tables.sort();

    newBlock
      .find("#former-table")
      .empty()
      .append(
        '<option selected="true" disabled>Choose one previous table</option>'
      )
      .prop("selectedIndex", 0);

    $.each(all_adj_tables, function (index, value) {
      if (value != "") {
        newBlock
          .find("#former-table")
          .append($("<option></option>").attr("value", value).text(value));
      }
    });

    newBlock
      .find("#former-table")
      .val(newBlock.find("#former-table").find("option:enabled:first").val());

    // When you select or change the value of the previous table you want to select
    newBlock
      .find("#former-table")
      .change(function (event) {
        let target_table = event.target.value;
        var table_data = init_data[target_table];

        // Init the menu
        newBlock
          .find("#adjacent-tables")
          .empty()
          .append(
            '<option selected="true" disabled>Choose adjacent table</option>'
          )
          .prop("selectedIndex", 0);

        // Making sure we have a list of adjacent tables sorted by alphabetical order
        let adj_tables_list = [];
        $.each(table_data.relations, function (key, _entry) {
          adj_tables_list.push(key);
        });
        let sorted_adj_tables_list = adj_tables_list.sort();

        $.each(sorted_adj_tables_list, function (_key, value) {
          newBlock
            .find("#adjacent-tables")
            .append($("<option></option>").attr("value", value).text(value));
        });

        newBlock.find("#adjacent-tables").selectpicker("refresh");

        // Disabling the plus button and the submit button when the former table is changed and therefore no adjacent table is selected
        document.getElementById("add-join").disabled = true;
        document.getElementById("submit-button").disabled = true;
      })
      .selectpicker("refresh")
      .change();

    // When you click to select/or change an adjacent table
    newBlock.find(".adjacent-tables").change(function (event) {
      let target_table = event.target.value;
      let table_data = init_data[target_table];

      // Init query-builder with fields and filters of the selected table
      newBlock
        .find(".collapsed-query-builder")
        .queryBuilder("setFilters", true, table_data.filters);

      // Init list of fields
      newBlock.find(".table-selects").empty();

      var items = table_data.filters.filter(function (item) {
        return !(item.label.endsWith("Cre") || item.label.endsWith("Maj"));
      });

      $.each(items, function (item) {
        newBlock
          .find(".table-selects")
          .append(
            $("<option></option>")
              .attr("value", items[item].label)
              .text(items[item].label)
          );
      });
      newBlock.find(".table-selects").multiselect("rebuild");
      newBlock.find(".table-selects").multiselect("updateButtonText");

      document.getElementById("add-join").disabled = false;
      document.getElementById("submit-button").disabled = false;
    });

    newBlock.find(".table-selects").multiselect({
      includeSelectAllOption: true,
      allSelectedText: "All fields selected",
      nonSelectedText: "No field(s) selected",
      numberDisplayed: 7,
      buttonWidth: "225",
    });

    newBlock.find(".table-selects").multiselect("rebuild");
    newBlock.find(".table-selects").multiselect("updateButtonText");

    $(function () {
      newBlock.find(".remove").click(function () {
        newBlock.find(".form-block").remove();
        alert(
          "Removed Join Block Successfully!\nBe warned : you might need to make changes accordingly on the remaining Join Blocks!"
        );
      });
    });
  });
});

document.getElementById("clear").onclick = function () {
  location.reload(true);
};

/**
 * 3 Fonctions : they read and convert the form's fields filled into JSON when SEARCH is clicked
 */

$.get("init", function (data) {
  $("#main-form").submit(function (event) {
    event.preventDefault();
    let data_initial = get_form_initial();
    let data_join_blocks = get_form_block_data(data);

    var jsonData = { initial: data_initial, joins: data_join_blocks };

    // fot the button GetSQL
    $("#getSqlButton").attr("disabled", false);

    $.ajax({
      url: "query", //query_test
      type: "POST",
      data: jsonData,
      dataType: "json",
      success: function (response) {
        $("#contentModalQuery").html(response.dql);
        $("#contentModalQuerySql").html(response.sql);
        $("#result-container").html(response.results);
        $("#result-table").dataTable(
          Object.assign({ dom: "lfrtipB", responsive: true }, dtconfig)
        );
      },
    });
  });
  // End of callback associated with the "Search" button
});

// Get the information about the first table chosen, the constraints on it, fields to show
function get_form_initial() {
  var table1 = document.getElementById("initial-table");
  var table = table1.options[table1.selectedIndex].value;

  // Constraints
  if ($("#initial-constraints-switchbox").is(":checked") == true) {
    var constraintsTable1 = $(".collapsed-query-builder")
      .eq(0)
      .queryBuilder("getRules");
  } else {
    var constraintsTable1 = null;
  }

  // Checked inputs

  var fieldsSelected = $("#initial-fields").find("option:selected");
  var fields = [];
  fieldsSelected.each(function () {
    fields.push($(this).val());
  });

  return { table, constraintsTable1, fields };
}

// Get the information about the templates' blocks
function get_form_block_data(init_data) {
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

/* Function to copy the SQL query to the clipboard */

function copySQLFunction() {
  let hiddenSQL = document.createElement("textarea"); // Init a new hidden textarea
  hiddenSQL.value = document.getElementById("contentModalQuerySql").innerHTML; // Setting the value of the textarea to the SQL Query

  // Making sure we won't see the textarea on the page and making sure we cannot write in it anyway
  hiddenSQL.setAttribute("readonly", "");
  hiddenSQL.style.position = "absolute";
  hiddenSQL.style.left = "-9999px";

  document.querySelector("body").appendChild(hiddenSQL);
  hiddenSQL.select(); // Selecting the text
  document.execCommand("copy"); // Copying what is in the textarea
  document.body.removeChild(hiddenSQL);
  alert("COPIED TO CLIPBOARD:\n" + hiddenSQL.value); // Alert showing just to check we copied the right text
}

document.getElementById("copySQL").onclick = function () {
  copySQLFunction();
};

/**
 * Functions for the scroll up button
 */

// Get the button
var mybutton = document.getElementById("myBtn");

// When the user scrolls down 30px from the top of the document, shows the button
window.onscroll = function () {
  scrollFunction();
};

function scrollFunction() {
  if (document.body.scrollTop > 30 || document.documentElement.scrollTop > 30) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scrolls to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

document.getElementById("myBtn").onclick = function () {
  topFunction();
};

let myModal = document.getElementById("logigal-database-model");

// Get the image and insert it inside the modal - use its "alt" text as a caption
let dbImg = document.getElementById("logical-db-img");
let myModalImg = document.getElementById("db-img");
let captionText = document.getElementById("caption");
dbImg.onclick = function () {
  myModal.style.display = "block";
  myModalImg.src = this.src;
  captionText.innerHTML = this.alt;
};

let closeImg = document.getElementsByClassName("close")[0];

closeImg.onclick = function () {
  myModal.style.display = "none";
};

window.onclick = function (event) {
  if (event.target == modal) {
    myModal.style.display = "none";
  }
};
