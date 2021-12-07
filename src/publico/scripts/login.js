$("#frmAcceso").on('submit',function(e)
{
    e.preventDefault();
    loginf=$("#loginf").val();
    clavef=$("#clavef").val();
    var resul =""
    $.post("../ajax/Usuario.php?op=verificar",
        {"loginf":loginf,"clavef":clavef},
        function(data)
    {
        resul = data;
        var tx = resul.indexOf("null");
        if (tx === -1)
        {
            $(location).attr("href","menu.php");
        }
        else
        {
            bootbox.alert("Usuario y/o Contraseña incorrectos...");
        }
    });
   
})

(function () {
    'use strict'; 
   window.addEventListener('load', function () {
         // Fetch all the forms we want to apply custom Bootstrap validation styles to
         var forms = document.getElementsByClassName('needs-validation');
         // Loop over them and prevent submission
         var validation = Array.prototype.filter.call(forms, function (form) {
           form.addEventListener('submit', function (event) {
             if (form.checkValidity() === false) {
               event.preventDefault();
               event.stopPropagation();
             }
   form.classList.add('was-validated');
      }, false);
      });
     }, false);
    })();