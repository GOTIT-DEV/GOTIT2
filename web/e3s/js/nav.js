$(".nav-left .menu-entry.active ul:first").slideDown(0)

$(".nav-left .menu-entry>a").click(ev => {
  let target = $(event.currentTarget)

  if(target.attr("href") === "#"){
    event.preventDefault()
  }
  let entry_elt = target.parent('li.menu-entry');

  if (entry_elt.hasClass('active')) {
    entry_elt.removeClass('active active-sm')
    $('ul:first', entry_elt).slideUp()
  } else {
    $(".nav-left .menu-entry.active")
      .removeClass("active")
      .find('ul:first')
      .slideUp("fast")
    entry_elt.addClass("active")
    $('ul:first', entry_elt).slideDown("fast")
  }
})


$('#menu_toggle').click(ev => {
  $('.nav-left').toggleClass("nav-sm")
})