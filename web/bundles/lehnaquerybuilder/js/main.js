
$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(builders => {
      console.log(builders);
      let qbuilder_block = $(".query-builder")
      
      // Set to table "Boite"
      qbuilder_block.queryBuilder({filters: builders.chromatogram.filters});

      $("#main-form").submit(event => {
        event.preventDefault()
        $(this).find("button[type='submit']").button('loading')

        // let formData = new FormData(event.target)
        fetch("parser-test", {
          method: 'POST', 
          body: JSON.stringify(qbuilder_block[0].queryBuilder.getRules()),
          headers: new Headers({ 'Content-Type': 'application/json'}) ,
          credentials: 'include'
        }).then(response => console.log(response.json()))
      })
    })
})
