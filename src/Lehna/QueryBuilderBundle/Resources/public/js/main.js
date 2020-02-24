
$(document).ready(_ => {
  fetch("init")
    .then(response => response.json())
    .then(builders => {
      console.log(builders);
      let qbuilder_block = $("#builder-basic")
      
      // Set to table "Commune"
      qbuilder_block.queryBuilder({filters: builders.Commune.filters});

      $("#main-form").submit(event => {
        event.preventDefault()
        $(this).find("button[type='submit']").button('loading')
        console.log(qbuilder_block[0].queryBuilder.getSQL('questioon_mark'))
        console.log(qbuilder_block[0].queryBuilder.getRules())
        fetch("parser-test", {
          method: 'POST', 
          body: JSON.stringify(qbuilder_block[0].queryBuilder.getRules()),
          headers: new Headers({ 'Content-Type': 'application/json'}) ,
          credentials: 'include'
        }).then(response => response.json())
        .then(json => console.log(json))
      })
    })
})
