$(function(){
  // The simple select boxes first
  $("form#new_patient select#patient_gender").chosen();
  $("form#new_patient select#patient_district").chosen();

  // Now the harder part: inputs that have data-chose-values
  var copyAttributes = function(actors){
    var $from = $(actors.from);
    var $to = $(actors.to);
    $.each(["id","name","class"], function(index,attribute){
      var existingValue = $from.attr(attribute);
      if(attribute == "id"){
        existingValue = "select_for_" + existingValue;
      }
      $to.attr(attribute, existingValue);
    });
  };
  var deactivate = function(value_element,visible_element){
    // chosen has a value element: the original select box and
    // a visible element: the .chosen-container div
    visible_element = visible_element || value_element;
    value_element.attr('name', "fallback_" + value_element.attr('name'));
    visible_element.hide();
  };
  var activate = function(value_element,visible_element){
    visible_element = visible_element || value_element;
    var matchdata = /^fallback_(.*)$/.exec(value_element.attr('name'));
    if(matchdata) {
      value_element.attr('name', matchdata[1]);
    }
    visible_element.show();
  };

  $('input[data-chosen-values]').each(function(index,input){
    var fancyInput = true;
    var $input = $(input);
    var $label = $("label[for='"+input['id']+"']");
    var $wrapper = $input.wrap('<div>').parent();

    var $toggleLink = $("<a href='#' class='chosen-toggle' tabindex='-1'>");
    $toggleLink.insertAfter($label);

    var values = $input.data('chosen-values');
    var $select = $("<select>");
    $.each(values, function(index,value) {
      $select.append($("<option></option>").text(value));
    });
    $select.insertAfter($input);
    copyAttributes({from: $input, to: $select});
    $select.chosen({create_option: true, skip_no_results: true});
    var $combobox = $wrapper.find(".chosen-container");

    var updateUI = function(){
      if(fancyInput){
        deactivate($input);
        activate($select,$combobox);
        $toggleLink.text("Simple Input");
      } else {
        activate($input);
        deactivate($select,$combobox);
        $toggleLink.text("Fancy Input");
      }
    };
    updateUI();

    $toggleLink.on("click", function(event){
      fancyInput = !fancyInput;
      updateUI();
      event.preventDefault();
    });
  });
});
