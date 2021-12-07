
var tabla;

function mostrar(idCliente)
{
  console.log("Hola");
  
  console.log("AQUI");
  $.get("../Clientes/CargarDatos/1",{id : idCliente}, function(data, status)
  {
    var info = JSON.parse(data);		
    console.log(data);
    console.log("AQUI");
 
    //var action = 'addProducto';
    $('#id').val(info.id);
    $('#txtDni').val(info.dni);
    $('#cmbEstado').val(info.estado);
    $('#nom_cliente').val(info.nombre);
    $('#ape_cliente').val(info.apellido);
    $('#gen_cliente').val(info.genero);
    $('#fechnac_cliente').val(info.fecha);
  

   })
   
}

function eliminarFila(idCliente)
{

  Swal.fire({
    title: 'Eliminar Cliente',
    text: "¿Está Seguro de eliminar el Cliente?",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, deseo Eliminarlo!'
  }).then((result) => {
    if (result.isConfirmed) {
      $.post("../ajax/clientes.php?op=eliminar", {id : idCliente}, function(e)
      {
        var result = e;
        Swal.fire(
          'Eliminado!',
          result,
          'success'
        )
        tabla.ajax.reload();
      });
      
    }
  })

/*	bootbox.confirm("¿Está Seguro de eliminar el Empleado?", function(result)
	{ // confirmamos con una pregunta si queremos eliminar
        if(result)
        {
            $.post("../ajax/empleado.php?op=eliminar", {codproducto : idProducto}, function(e)
            {
	            bootbox.alert(e);
	            tabla.ajax.reload();
            });
        }
        
    })*/
}

function listar()
{
	tabla=$('#tbllistado').dataTable(
	{
		"lengthMenu": [ 5, 10, 25, 75, 100],//mostramos el menú de registros a revisar
		"aProcessing": true,//Activamos el procesamiento del datatables
	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
	    dom: '<Bl<f>rtip>',//Definimos los elementos del control de tabla
	    buttons: [		          
		            'copyHtml5',
		            'excelHtml5',
		            'csvHtml5',
		            'pdf'
		        ],
		"ajax":
				{
					url: '../ajax/clientes.php?op=listar',
					type : "get",
					dataType : "json",						
					error: function(e){
						console.log(e.responseText);	
					}
				},
		"language": {
            "lengthMenu": "Mostrar : _MENU_ registros",
            "buttons": {
            "copyTitle": "Tabla Copiada",
            "copySuccess": {
                    _: '%d líneas copiadas',
                    1: '1 línea copiada'
                }
            }
        },
		"bDestroy": true,
		"iDisplayLength": 5,//Paginación
	    "order": [[ 0, "desc" ]]//Ordenar (columna,orden)
	}).DataTable();
}

$(document).ready(function(){
  $('.btnMenu').click(function(e) {
    e.preventDefault();
    if($('nav').hasClass('viewMenu')) {
      $('nav').removeClass('viewMenu');
    }else {
      $('nav').addClass('viewMenu');
    }
  });

  function init(){
	
    listar();
  
  }

  $('nav ul li').click(function() {
    $('nav ul li ul').slideUp();
    $(this).children('ul').slideToggle();
  });

  // Guardar Cliente
  $('#btn_crear_cliente1').click(function(e) {
    e.preventDefault();
    var action = 'addCliente';
    var dni = $('#dni_cliente').val();
    var estado = $('#estado').val();
    var nombre = $('#nom_cliente').val();
    var apellido = $('#ape_cliente').val();
    var genero = $('#gen_cliente').val();
    var fechaNacimiento = $('#fechnac_cliente').val();
    $.ajax({
      url: '../ajax/clientes.php',
      type: 'POST',
      async: true,
      data: {action:action,dni:dni,nombre:nombre,apellido:apellido,genero:genero,fechaNacimiento:fechaNacimiento,estado:estado},
      success: function(response) {
        
        var info = JSON.parse(response);
        bootbox.confirm(info.msj, function(result)
        { // confirmamos con una pregunta si queremos eliminar
            if(result)
            {
                location.reload();
            }
            else
            { 
              location.reload();
            }
        })
      },
      error: function(error) {
        // location.reload();
      }
    });
  });


  $('#btn_Editar_cliente1').click(function(e) {
    e.preventDefault();
    var action = 'editar';
    var id = $('#id').val();
    var dni = $('#dni_cliente').val();
    var estado = $('#estado').val();
    var nombre = $('#nom_cliente').val();
    var apellido = $('#ape_cliente').val();
    var genero = $('#gen_cliente').val();
    var fechaNacimiento = $('#fechnac_cliente').val();
    $.ajax({
      url: '../ajax/clientes.php',
      type: 'POST',
      async: true,
      data: {action:action,id:id,dni:dni,nombre:nombre,apellido:apellido,genero:genero,fechaNacimiento:fechaNacimiento,estado:estado},
      success: function(response) {
        
        var info = JSON.parse(response);
        bootbox.confirm(info.msj, function(result)
        { // confirmamos con una pregunta si queremos eliminar
            if(result)
            {
                location.reload();
            }
            else
            { 
              location.reload();
            }
        })
      },
      error: function(error) {
        // location.reload();
      }
    });
  });


  init();
}); // fin ready


