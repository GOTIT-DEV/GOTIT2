
$(document).ready(() => {
  $("#grid-basic").bootgrid({
    caseSensitive: false,
    padding: 2,
    rowCount: [5, 10, 25, 50, -1],
    formatters: {
      "showEntity": function (column, entities, value) {
        return "<a href=\"" + entities.dbName + "/" + entities.id + " \" class=\"btn btn-sm\" ><span class=" + "\"glyphicon glyphicon-eye-open\"></span></a>";
      }
    }
  });
})
