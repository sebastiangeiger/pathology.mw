$(function(){
  var doCentering = function(){
    var toCenter = $('.vertically-centered');
    if(toCenter.length){
      toCenter = toCenter.first();
      var available = $(window).height() - $('.top-bar').height() - toCenter.height();
      var goldenRatio = (1+Math.sqrt(5))/2.0;
      var above = 0;
      var below = 0;
      if(available > 0){
        var above = available / (1+goldenRatio);
        var below = above * goldenRatio;
        toCenter.css('margin-top', above);
        toCenter.css('margin-bottom', below);
      }
      toCenter.css('margin-top', above);
      toCenter.css('margin-bottom', below);
    }
  };
  doCentering();
  window.onresize = doCentering;
});
