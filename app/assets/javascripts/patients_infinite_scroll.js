$(function(){
  $("<div id='loading-indicator' class='text-center'></div>").insertAfter("table#patients");
  $("#patients .page").infinitescroll({
    loading: {
      finishedMsg: "Congratulations, you've reached the end of the internet.",
      finished: makeLinks,
      msgText: "",
      speed: 'fast',
      selector: "#loading-indicator"
    },
    navSelector: "nav.pagination", // selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]", // selector for the NEXT link (to page 2)
    itemSelector: "#patients tbody tr"}) // selector for all items you'll retrieve

})
