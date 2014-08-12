$(function(){
  $("textarea").keyup(function(e) {
    var desiredHeight = this.scrollHeight +
                        parseFloat($(this).css("borderTopWidth")) +
                        parseFloat($(this).css("borderBottomWidth"));
    while($(this).outerHeight() < desiredHeight) {
      $(this).height($(this).height()+1);
    };
  });
})
