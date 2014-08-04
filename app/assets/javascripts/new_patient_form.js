$(function(){

  var calculateAge = function(dateString){
    var today = new Date();
    var birthDate = new Date(dateString);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  var calculateBirthyear = function(ageString){
    var today = new Date();
    var age = parseInt(ageString,10);
    var birthyear = today.getFullYear() - age;
    return birthyear;
  };

  var form = $("form#new_patient");
  if(form.length){
    var ageField = form.find("input#patient_age");
    var birthdayField = form.find("input#patient_birthday");
    var birthyearField = form.find("input#patient_birthyear");
    var birthdayUnknownField = form.find("input#patient_birthday_unknown");

    birthdayField.on('input', function(event){
      var age = calculateAge(birthdayField.val());
      if(isNaN(age)){
        ageField.val("").prop("disabled", false);
      } else {
        ageField.val(age).prop("disabled", true);
      }
    });

    ageField.on('input', function(event){
      var age = ageField.val();
      var birthyear = calculateBirthyear(age);
      if(isNaN(birthyear)) {
        birthdayField.prop("disabled", false);
        birthyearField.val("");
      } else {
        var januaryFirstInBirthyear = birthyear.toString()+"-01-01";
        birthdayField.prop("disabled", true);
        birthyearField.val(januaryFirstInBirthyear);
      }
    });

    birthdayUnknownField.on('click', function(event){
      var checked = birthdayUnknownField.prop('checked');
      if(checked){
        birthdayField.val("").prop("disabled", true);
        ageField.val("").prop("disabled", true);
        birthyearField.val("");
      } else {
        birthdayField.prop("disabled", false);
        ageField.prop("disabled", false);
      }
    });


  }
});
