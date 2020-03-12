
import { fetchCurrentUser } from './utils.js'
import { dtconfig, linkify } from './datatables_utils.js'


let lastQuery = {}
let detailsTable = null
let dtbuttons = null
let detailsFormData = null

/**
 * Initialize result table
 * @param {String} tableId DOM table ID
 */
export function initDataTable(tableId) {
  uiWaitResponse()
  // Don't try to initialize if already init
  if (!$.fn.DataTable.isDataTable(tableId)) {
    fetchCurrentUser()
      .then(response => response.json())
      .then(user => {
        dtbuttons = (user.role === 'ROLE_INVITED') ? [] : dtconfig.buttons
        // Init DataTable
        const table = $(tableId)
        let dataTable = table.DataTable({
          autoWidth: false,
          responsive: true,
          ajax: {
            "url": Routing.generate("motu-query"),
            "dataSrc": "rows",
            "type": "POST",
            "data": _ => {
              return $(ids.form).serialize()
            }
          },
          language: dtconfig.language[table.data('locale')],
          dom: "lfrtipB",
          buttons: dtbuttons,
          columns: [{
            data: "taxname",
            render: linkify("referentieltaxon_show", {
              col: 'id',
              _locale: table.data('locale')
            })
          }, {
            data: "methode"
          }, {
            data: "motu_title",
          }, {
            data: "nb_seq"
          }, {
            data: "nb_motus"
          }, {
            data: "id",
            render: (data, type, row) =>
              Mustache.render($("#details-form-template").html(), row)
          }],
          drawCallback: _ => {
            // Toggle UI loading done
            uiReceivedResponse()
            // Init tooltips
            $('[data-toggle="tooltip"]').tooltip()
            // Init detail forms
            $(".details-form").on('submit', event => {
              event.preventDefault();
              detailsFormData = $(event.target).serializeArray()
              lastQuery.criteres.forEach(crit => {
                detailsFormData.push({
                  name: 'criteres[]',
                  value: crit
                })
              })
              detailsFormData.push({
                name: 'niveau',
                value: lastQuery.niveau
              })
              // Init details table if it is not already done
              if (!$.fn.DataTable.isDataTable(ids.details))
                detailsTable = initModalTable()
              else
                detailsTable.ajax.reload()
              $("#modal-container .modal").modal('show');
            });
          }
        }).on('xhr', _ => {
          // Keep track of last query parameters
          lastQuery = dataTable.ajax.json().query
        })

        // Init form submit event
        $(ids.form).submit(event => {
          event.preventDefault()
          uiWaitResponse()
          dataTable.ajax.reload()
        })
      })
  }
}


/**
 * Toggle UI loading mode
 */
function uiWaitResponse() {
  $(ids.form).find("button[type='submit']").button('loading')
}

/**
 * Toggle UI loading done
 */
function uiReceivedResponse() {
  $(ids.form).find("button[type='submit']").button('reset')
}