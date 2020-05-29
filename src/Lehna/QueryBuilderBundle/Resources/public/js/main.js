/*
 * This file file is part of the QueryBuilderBundle.
 *
 * It is a free software, included in a bigger project. You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 *
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes.
 */
import { initFirstTable, initFirstQueryBuilder, initFirstFields, initJoinBlock, scrollFunction, topFunction } from './form.js'
import { initResults, copySQLFunction } from './results.js'

const joinType = ["Inner Join", "Left Join"];
let mybutton = document.getElementById("myBtn");


$(document).ready(_ => {

  $.getJSON("init", function (init_data) {

    // Making sure these buttons are disabled on reload
    document.getElementById("add-join").disabled = true;
    document.getElementById("submit-button").disabled = true;
    document.getElementById("getSqlButton").disabled = true;

    // Init initial fields multiselect
    $("#initial-fields").multiselect({
      includeSelectAllOption: true,
      allSelectedText: "All fields selected",
      nonSelectedText: "No field(s) selected",
      numberDisplayed: 7,
      buttonWidth: 225,
    });

    initFirstTable(init_data);
    initFirstQueryBuilder();
    initFirstFields(init_data);

    // Hiding what's in the div, then showing it when the switchbox is triggered
    document.getElementById("initial-applied-constraints").style.display =
      "none";
    $("#initial-constraints-switchbox").change(_ => {
      $("#initial-applied-constraints").toggle("slow");
    });

    initJoinBlock(joinType, init_data);
    initResults(init_data);

  })
  
  // Zoom in the image, scroll in / out to adjust zoom
  $("#logical-db-img").elevateZoom({ scrollZoom: true }); // testing

  // To enable the copy SQL button after the search button is clicked
  document.getElementById("copySQL").onclick = function() {
    copySQLFunction();
  };

    // When the user scrolls down 30px from the top of the document, shows the button
  window.onscroll = function () {
    scrollFunction(mybutton);
  };


  // Button to scroll back to the top the page 
  document.getElementById("myBtn").onclick = function () {
    topFunction(); 
  };

  //Button to reload the page / clear the form
  document.getElementById("clear").onclick = function () {
    location.reload(true);
  };

})

