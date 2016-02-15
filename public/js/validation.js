$(document).ready(function(){

  $('#contactForm').validate({

    rules:{

      name: "required",
      email: {
        required: true,
        email: true
      },
      message: "required"
    },

    messages:{
      name: "Името е задолжително поле",
      email: {
        required: "Е-маил адресата е задолжително поле",
        email: "Внесете валидна е-маил адреса (name@example.com)"
      },
      message: "Пораката е задолжително поле"
    },
    highlight: function(element){
      $(element).closest('.form-group').addClass('has-error');
    },
    unhighlight: function(element) {
      $(element).closest('.form-group').removeClass('has-error');
    },
    errorElement: 'span',
    errorClass: 'validation-message'
  });

});