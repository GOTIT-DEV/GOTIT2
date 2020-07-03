/*
 * This file file is part of the QueryBuilderBundle.
 *
 * It is a free software, included in a bigger project. 
 * You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 *
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes.
 */

import {
  initFirstTable,
  initFirstQueryBuilder,
  initFirstFields,
  initJoinBlock,
  scrollFunction,
  topFunction,
} from "./form.js";
import { initResults, copySQLFunction } from "./results.js";

const joinType = ["Inner Join", "Left Join"];

$(document).ready((_) => {
  $.getJSON("init", function (init_data) {
    // Making sure these buttons are disabled on reload
    document.getElementById("add-join").disabled = true;
    document.getElementById("submit-button").disabled = true;
    document.getElementById("getSqlButton").disabled = true;

    $("#initial-constraints-switchbox").bootstrapToggle("off");

    initFirstTable(init_data);
    initFirstQueryBuilder();
    initFirstFields(init_data);

    // Hiding what's in the div, then showing it when the switchbox is triggered
    document.getElementById("initial-query-builder").style.display = "none";
    $("#initial-constraints-switchbox").change((_) => {
      $("#initial-query-builder").slideToggle("fast");
      $("#initial-cc-reset").slideToggle("fast");
    });

    initJoinBlock(joinType, init_data);
    initResults(init_data);
  });

  // Zoom in the image, scroll in / out to adjust zoom
  $("#logical-db-img").elevateZoom({
    scrollZoom: true,
    zoomWindowWidth: 420,
    zoomWindowHeight: 345,
    zoomWindowPosition: 0,
    zoomWindowOffetx: -725,
    zoomWindowOffety: 0,
    zoomLevel: 3
  })

  // To enable the copy SQL button after the search button is clicked
  $("#copySQL").click(copySQLFunction)

  // When the user scrolls down 30px from the top of the document, the "scroll to the top" button is displayed
  window.onscroll = function () {
    scrollFunction();
  };

  // Button to scroll back to the top the page
  $("#myBtn").click(topFunction)

  // Button to reload the page / clear the form
  $("#clear").click(() => location.reload(true))
});
