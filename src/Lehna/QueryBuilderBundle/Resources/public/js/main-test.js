/*
 * This file file is part of the QueryBuilderBundle.
 *
 * It is a free software, included in a bigger project. You can use it and modify it under the terms of the GNU General Public License (Version 3 or later).
 * This software is distributed without any warranty.
 *
 * Authors : Thierno Diallo, Maud Ferrer and Elsa Mendes.
 */
import { initFirstTable, initFirstQueryBuilder, initFirstFields, initJoinBlock, copySQLFunction, scrollFunction, topFunction } from './form.js'

const joins = ["Inner Join", "Left Join"];
let mybutton = document.getElementById("myBtn");

$(document).ready(_ => {
  // calling necessary functions
  // binding the blocks together

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
    initFirstFields();

    // Hiding what's in the div, then showing it when the switchbox is triggered
    document.getElementById("initial-applied-constraints").style.display =
      "none";
    $("#initial-constraints-switchbox").change(_ => {
      $("#initial-applied-constraints").toggle("slow");
    });

    initJoinBlock(joins);
    initResults(ini_data);

    //Button to reload the page / clear the form
    document.getElementById("clear").on("click", _ => {
      location.reload(true);
    });
  })

  // When the user scrolls down 30px from the top of the document, shows the button
  window.onscroll(_ => {
    scrollFunction(mybutton);
  });


  // Button to scroll back to the top the page 
  document.getElementById("myBtn").onclick(_ => {
    topFunction(); 
  });
  

  // Zoom in the image, scroll in / out to adjust zoom
  $("#logical-db-img").elevateZoom({ scrollZoom: true }); // testing

  // To enable the copy SQL button after the search button is clicked
  document.getElementById("copySQL").onclick(_ => {
    copySQLFunction();
  });

})


