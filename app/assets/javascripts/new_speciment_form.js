$(function(){
  var form = $("form#new_specimen");
  if(form.length){
    var pathologyNumberField = $("#specimen_pathology_number");
    var prefixField = $("<span class='input-prefix'>2014-QT-</span>");
    pathologyNumberField.wrap("<div class='fake-input'></div>");
    prefixField.insertBefore(pathologyNumberField);
    pathologyNumberField.focus();
  }
});
