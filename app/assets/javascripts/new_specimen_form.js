$(function(){
  var form = $("form#new_specimen");
  var regex = new RegExp(/(20\d{2})-(QT-)?(\d*)/);
  if(form.length){
    var pathologyNumberField = $("#specimen_pathology_number");
    var prefixField = $("<span class='input-prefix'>Prefix</span>");
    var inputFacade = $("<input id='specimen_pathology_number_fake_input' type='text'></input>");
    pathologyNumberField.wrap("<div class='fake-input'></div>");
    inputFacade.insertBefore(pathologyNumberField);
    prefixField.insertBefore(inputFacade);
    inputFacade.focus();
    pathologyNumberField.hide();

    function setFacade(){
      var matches = pathologyNumberField.val().match(regex);
      if(matches){
        var year = matches[1];
        var id = matches[3];
        prefixField.text(year+"-QT-");
        inputFacade.val(id);
      } else {
        prefixField.hide();
        inputFacade.val(pathologyNumberField.val());
      }
    }
    setFacade();

    function setPathologyInputField(){
      var fullText = "";
      if(prefixField.is(":hidden")){
        fullText = inputFacade.val();
      } else {
        fullText = prefixField.text() + inputFacade.val();
      }
      pathologyNumberField.val(fullText);
    }

    function splitOutPrefix(){
      if(prefixField.is(":hidden")){
        var matches = inputFacade.val().match(regex);
        if(matches){
          var year = matches[1];
          var id = matches[3];
          prefixField.text(year+"-QT-").show();
          inputFacade.val(id);
        }
      }
    }

    function reactToBackspace(event){
      if(event.which === 8 && prefixField.is(":visible") && inputFacade.val() === ""){
        prefixField.text("").hide();
      }
    }

    function reactToInput(){
      splitOutPrefix();
      setPathologyInputField();
    }
    reactToInput();
    inputFacade.on('input', reactToInput);
    inputFacade.keydown(reactToBackspace);
  }

});
