$(function(){

  var calculateAgeFromDate = function(dateString){
    var today = new Date();
    var birthDate = new Date(dateString);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  var calculateAgeFromYear = function(yearString){
    var today = new Date();
    var birthyear = parseInt(yearString,10);
    var age = today.getFullYear() - birthyear;
    return age;
  };

  var calculateBirthyear = function(ageString){
    var today = new Date();
    var age = parseInt(ageString,10);
    var birthyear = today.getFullYear() - age;
    return birthyear;
  };

  var form = $("form#new_patient,form[id^=edit_patient_]");
  if(form.length){
    var ageField = form.find("input#patient_age");
    var birthdayField = form.find("input#patient_birthday");
    var birthyearField = form.find("input#patient_birthyear");
    var birthdayUnknownField = form.find("input#patient_birthday_unknown");

    var checkBirthdayField = function(event){
      var age = calculateAgeFromDate(birthdayField.val());
      if(isNaN(age)){
        ageField.val("").prop("disabled", false);
        birthdayUnknownField.prop("disabled", false);
      } else {
        ageField.val(age).prop("disabled", true);
        birthyearField.val("");
        birthdayUnknownField.prop("disabled", true);
      }
    };
    birthdayField.on('input', checkBirthdayField);

    var checkAgeField = function(){
      var age = ageField.val();
      var birthyear = calculateBirthyear(age);
      if(isNaN(birthyear)) {
        birthdayField.prop("disabled", false);
        birthyearField.val("");
        birthdayUnknownField.prop("disabled", false);
      } else {
        birthdayField.prop("disabled", true);
        birthyearField.val(birthyear);
        birthdayUnknownField.prop("disabled", true);
      }
    };
    ageField.on('input', checkAgeField);

    var checkBirthdayUnknownField = function(){
      var checked = birthdayUnknownField.prop('checked');
      if(checked){
        birthdayField.val("").prop("disabled", true);
        ageField.val("").prop("disabled", true);
        birthyearField.val("");
      } else {
        birthdayField.prop("disabled", false);
        ageField.prop("disabled", false);
      }
    }
    birthdayUnknownField.on('click', checkBirthdayUnknownField);

    var checkBirthyearField = function(){
      var age = calculateAgeFromYear(birthyearField.val());
      if (!isNaN(age)) {
        ageField.val(age).prop('disabled', false);
        birthdayField.val("").prop('disabled', true);
        birthdayUnknownField.prop('checked', false).prop('disabled', true);
      }
    }

    // Initialize with values already in place
    if (birthdayField.val() != "") {
      checkBirthdayField();
    } else if (birthyearField.val() != "") {
      checkBirthyearField();
    } else if (birthdayUnknownField.prop('checked')) {
      checkBirthdayUnknownField();
    }
  }
});
