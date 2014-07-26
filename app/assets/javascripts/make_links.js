$(function(){
  $('*[data-link-to]').each(function(index,element){
    $(element).css('cursor','pointer').on("click", function(event){
      event.preventDefault();
      window.location.href = $(this).data("link-to");
    });
  });
});
