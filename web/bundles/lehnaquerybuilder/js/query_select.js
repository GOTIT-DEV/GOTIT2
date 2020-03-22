/** SpeciesSelector
 * Class to handle dynamic loading of species on genus selection in forms
 */
export class QuerySelector {

    /**
     * Constructor
     * @param {string} formId Form selector in DOM
     * @param {string} toggleId Checkbox selector to toggle genus/species selection
     */
    constructor(formId, toggleId = null) {
      this.form = $(formId)
  
      this.urls = {
        tableChosen: Routing.generate('firstTable')
      }
  
      // Main container
      this.selector = this.form.find(".firstChosen-selector")
      // Select inputs
      this.tableChosen = this.selector.find('.firstChosen2-select')
  
      
    }
  
    /**
     * Handle Promise and spinners visibility during AJAx querying
     * @param {boolean} waiting True while AJAX query running
     */
    
  
    get whichTable() {
      return {
        tableChosen: this.tableChosen.val()
      }
    }
  
  
  }