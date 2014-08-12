$(function(){
  var copyAttributes = function(attributes, actors){
    var $from = $(actors.from);
    var $to = $(actors.to);
    $.each(attributes, function(index,attribute){
      $to.attr(attribute, $from.attr(attribute));
    });
  };
  $('input[data-chosen-values]').each(function(index,input){
    var $input = $(input);
    var values = $input.data('chosen-values');
    var $select = $("<select>");
    $.each(values, function(index,value) {
      $select.append($("<option></option>").text(value));
    });
    $select.insertAfter($input).
      chosen({create_option: true, skip_no_results: true});
    copyAttributes(["name", "id", "class"], {from: $input, to: $select});
    $input.attr('name', "fallback_" + $input.attr('name')).hide();
  });
});
