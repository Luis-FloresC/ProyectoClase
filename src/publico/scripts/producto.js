
var tabla;

function mostrar(idProducto)
{
  $.post("../ajax/producto.php?op=mostrar",{codproducto : idProducto}, function(data, status)
  {
    var info = JSON.parse(data);		
 
    //var action = 'addProducto';
    $('#idproducto').val(info.idProducto);
    $('#nombreproducto').val(info.nombreProducto);
    $('#descripcionproducto').val(info.descripcionProducto);
    $('#cantidadexistencia').val(info.cantidadExistencia);
    $('#idcategoria').val(info.idCategoria);
    $('#idestado').val(info.idEstado);
    $('#precioestandar').val(info.precioEstandar);
    $('#precioventa').val(info.precioVenta);
    $('#idmodelo').val(info.idModelo); 

  

   })
}

function eliminarFila(idProducto)
{

  Swal.fire({
    title: 'Eliminar Producto',
    text: "¿Está Seguro de eliminar el Producto?",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, deseo Eliminarlo!'
  }).then((result) => {
    if (result.isConfirmed) {
      $.post("../ajax/producto.php?op=eliminar", {codproducto : idProducto}, function(e)
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
					url: '../ajax/producto.php?op=listar',
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


function limpiar()
{
  $('#idproducto').val("");
  $('#nombreproducto').val("");
  $('#descripcionproducto').val("");
  $('#cantidadexistencia').val("");
  $('#idcategoria').val("");
  $('#idestado').val("");
  $('#precioestandar').val("");
  $('#precioventa').val("");
  $('#idmodelo').val(""); 
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
  
 

//Función que se ejecuta al inicio
function init(){
	
	listar();

}


    $('nav ul li').click(function() {
      $('nav ul li ul').slideUp();
      $(this).children('ul').slideToggle();
    });
  
    // Guardar Cliente
    $('#btn_crear_producto').click(function(e) {
      e.preventDefault();
      var action = 'addProducto';
      var codproducto = $('#idproducto').val();
      var nombreproducto = $('#nombreproducto').val();
      var descripcionproducto = $('#descripcionproducto').val();
      var cantidadexistencia = $('#cantidadexistencia').val();
      var idcategoria = $('#idcategoria').val();
      var idestado = $('#idestado').val();
      var precioest = $('#precioestandar').val();
      var preciovent = $('#precioventa').val();
      var codmodelo = $('#idmodelo').val();
      $.ajax({
        url: '../ajax/producto.php',
        type: 'POST',
        async: true,
        data: {action:action,codproducto:codproducto,nombreproducto:nombreproducto,descripcionproducto:descripcionproducto,cantidadexistencia:cantidadexistencia,idcategoria:idcategoria,idestado:idestado,precioest:precioest,preciovent:preciovent,codmodelo:codmodelo},
        success: function(response) {
        if (response != 0) {
          try {

          var info = JSON.parse(response);

          
          Swal.fire({
            position: 'center',
            title: info.msj,
            showConfirmButton: true
          })

          if(info.msj == "Producto registrado con éxito...")
          {
         //   location.reload();
         tabla.ajax.reload();
            limpiar();
          }
          else
          {
            location.reload();
          }
         
      /*    bootbox.confirm(info.msj, function(result)
          { // confirmamos con una pregunta si queremos eliminar
              if(result)
              {
                  location.reload();
              }
              else
              {
                location.reload();
              }
          })*/
          
            //var info = JSON.parse(response);
          /*  swal(" producto guardado con Éxito! ", {
              icon: "success",
            })
            .then((value) => {
              $(location).attr("href","producto.php");
            }); */
           // console.log(response);
          }
          catch(err) {

            alert(response);
      /*      swal("Error al guardar producto ", {
              icon: "error",
            })
            .then((value) => {
              $(location).attr("href","producto.php");
            });*/
            console.log(err);
            //alert("Venta Realizada con exito...");
  
          }
            
        }else {
          console.log('no hay datos');
        }
        },
        error: function(error) {
          // location.reload();
        }
      });
    });


    $('#btn_editar_producto').click(function(e) {
      e.preventDefault();
      var action = 'editarProducto';
      var codproducto = $('#idproducto').val();
      var nombreproducto = $('#nombreproducto').val();
      var descripcionproducto = $('#descripcionproducto').val();
      var cantidadexistencia = $('#cantidadexistencia').val();
      var idcategoria = $('#idcategoria').val();
      var idestado = $('#idestado').val();
      var precioest = $('#precioestandar').val();
      var preciovent = $('#precioventa').val();
      var codmodelo = $('#idmodelo').val();
      $.ajax({
        url: '../ajax/producto.php',
        type: 'POST',
        async: true,
        data: {action:action,codproducto:codproducto,nombreproducto:nombreproducto,descripcionproducto:descripcionproducto,cantidadexistencia:cantidadexistencia,idcategoria:idcategoria,idestado:idestado,precioest:precioest,preciovent:preciovent,codmodelo:codmodelo},
        success: function(response) {
        if (response != 0) {
          try {

            
          var info = JSON.parse(response);

          Swal.fire({
            position: 'center',
            title: info.msj,
            showConfirmButton: true
          })
          
          if(info.msj == "Producto actualizado con éxito...")
          {
            tabla.ajax.reload();
            limpiar();
          //  location.reload();
          }
          else
          {
            tabla.ajax.reload();
            limpiar();
           
          }

      /*    bootbox.confirm(info.msj, function(result)
          { // confirmamos con una pregunta si queremos eliminar
              if(result)
              {
                  location.reload();
              }
              else
              {
                location.reload();
              }
          })*/
          
            //var info = JSON.parse(response);
          /*  swal(" producto guardado con Éxito! ", {
              icon: "success",
            })
            .then((value) => {
              $(location).attr("href","producto.php");
            }); */
           // console.log(response);
          }
          catch(err) {

            alert(response);

            console.log(err);

  
          }
            
        }else {
          console.log('no hay datos');
        }
        },
        error: function(error) {
          // location.reload();
        }
      });
    });

    init();
  }); // fin ready

  
  