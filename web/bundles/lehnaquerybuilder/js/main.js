
function myFunction() {
    document.getElementById("collapseTables").collapse();
    document.getElementById("newconstraints").append("<div class=\"col-xs-12 btn-group pull-left group-actions\"> <button class=\"btn btn-xs btn-basic collapsed\" onclick=\"myFunction()\" type=\"button\" data-toggle=\"collapse\"  aria-expanded=\"true\" aria-controls=\"collapseTables\"> <i class=\"glyphicon glyphicon-plus-sign\" style=\"font-size:25px\" ></i> </button></div>");
}



$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(builders => {
      console.log(builders);

    })
})
