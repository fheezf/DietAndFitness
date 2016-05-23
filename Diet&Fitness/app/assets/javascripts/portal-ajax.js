// CÃ³digo adaptado desde https://github.com/wycats/rack-offline
// Almacena y recupera la lista de origamis en el LocalStorage, ademÃ¡s de generar
// el html necesario para inyectarlo en el DOM.
// Incluye el almacenamiento de imÃ¡genes en el localStore
// No incluye la lÃ³gica para mostrar la pÃ¡gina de un Origami, ni elimina elementos del
// localStore, etc...


$(document).on('pageinit', function(){   

  // Almacena en el local storage la imagen cuya url se pasa como parÃ¡metro
  function saveImageLocal(key, url){
    var nimg = new Image();
    nimg.src =url;
    nimg.onload = function(){
      var canvas = document.createElement('canvas');
      var context = canvas.getContext('2d');
      context.canvas.height=nimg.height;
      context.canvas.width=nimg.width;
      context.drawImage(nimg, 0,0,nimg.width, nimg.height);
      var data = canvas.toDataURL("image/png");
      localStorage.setItem(key, data); 
    };
  }
  
  // Construye la lista de origamis en el DOM con los datos json que recibe en 'data'

  function incluye_dietas_favoritos(){
    $('#diets').html('');
    $.ajax({
          type: "GET",
          url: "/diets.json",
          data: {"user_id": window.location.search.substring(9)},
          error: function(){
			        alert( "No se ha podido establecer conexión con el servidor");
          },
          success: function(msg){
              for (var dieta in msg){
		        	  if (msg[dieta].punctuation < 0) {
                  var id="rojo";
                  var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-minus";
                }else{
                  var id="verde";
                  var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-plus";
                }
                var auxdata = localStorage[msg[dieta].id+"-thumb-diet"];
                $('#diets').append(" <li class='cdieta' id="+msg[dieta].id+" ><a href='muestra_dieta.html', data-ajax='false' > <img src='"+auxdata+"' alt='"+msg[dieta].title+"' /> <h3>"+msg[dieta].title+"</h3><button id='"+id+"' class='"+clase+"'></button>"+msg[dieta].punctuation+" </a></li> ");
              }
          $('#diets').listview().listview('refresh');
          }
    })
  }

   function incluye_ejercicios_favoritos(){
    $('#fitnesses').html('');
    $.ajax({
          type: "GET",
          url: "/fitnesses.json",
          data: {"user_id": window.location.search.substring(9)},
          error: function(){
			        alert( "No se ha podido establecer conexión con el servidor");
          },
          success: function(msg){
              for (var ejercicio in msg){
                if (msg[ejercicio].punctuation < 0) {
                  var id="rojo";
                  var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-minus";
                }else{
                  var id="verde";
                  var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-plus";
                }
		        	  console.log('resp: ' + msg[ejercicio].title);
                var auxdata = localStorage[msg[ejercicio].id+"-thumb-ejercicio"];
                $('#fitnesses').append(" <li class='cejercicio' id="+msg[ejercicio].id+" ><a href='muestra_ejercicio.html', data-ajax='false' > <img src='"+auxdata+"' alt='"+msg[ejercicio].title+"' /> <h3>"+msg[ejercicio].title+"</h3><button id='"+id+"' class='"+clase+"'></button>"+msg[ejercicio].punctuation+" </a></li> ");
              }
          $('#fitnesses').listview().listview('refresh');
          }
    })
  }

  function incluye_dietas_no_favoritos(data){
    $('#diets').html('');
    for (var dieta in data){
      if (data[dieta].punctuation < 0) {
        var id="rojo";
        var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-minus";
      }else{
        var id="verde";
        var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-plus";
      }
      var auxdata = localStorage[data[dieta].id+"-thumb-diet"];
      $('#diets').append(" <li class='cdieta' id="+data[dieta].id+" ><a href='muestra_dieta.html', data-ajax='false' > <img src='"+auxdata+"' alt='"+data[dieta].title+"' /> <h3>"+data[dieta].title+"</h3><button id='"+id+"' class='"+clase+"'></button>"+data[dieta].punctuation+" </a></li> ");
    }
    $('#diets').listview().listview('refresh');
  }

  function incluye_ejercicios_no_favoritos(data){
    $('#fitnesses').html('');
    for (var ejercicio in data){
      if (data[ejercicio].punctuation < 0) {
        var id="rojo";
        var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-minus";
      }else{
        var id="verde";
        var clase="btn-punctuation ui-btn ui-corner-all ui-btn-inline ui-btn-icon-notext ui-icon-plus";
      }
      var auxdata = localStorage[data[ejercicio].id+"-thumb-ejercicio"];
      $('#fitnesses').append(" <li class='cejercicio' id="+data[ejercicio].id+" ><a href='muestra_ejercicio.html', data-ajax='false' > <img src='"+auxdata+"' alt='"+data[ejercicio].title+"' /> <h3>"+data[ejercicio].title+"</h3><button id='"+id+"' class='"+clase+"'></button>"+data[ejercicio].punctuation+"  </a></li> ");
    }
    $('#fitnesses').listview().listview('refresh');
  }


  //  Declaramos una funciÃ³n que recibe un objeto js, 
  //  lo almacena en el local storage y actualiza el html 
  var actualizaOrigamis = function(diets, fitnesses) {
    localStorage.diets = JSON.stringify(diets);
    localStorage.fitnesses = JSON.stringify(fitnesses);
    for (var dieta in diets) {
      saveImageLocal(diets[dieta].id+"-thumb-diet",diets[dieta].imagen.imagen.thumb.url,80);
      saveImageLocal(diets[dieta].id+"-org-diet",diets[dieta].imagen.imagen.url);
    }
    for (var ejercicio in fitnesses) {
      saveImageLocal(fitnesses[ejercicio].id+"-thumb-ejercicio",fitnesses[ejercicio].imagen.imagen.thumb.url,80);
      saveImageLocal(fitnesses[ejercicio].id+"-org-ejercicio",fitnesses[ejercicio].imagen.imagen.url);
    }
    if (window.location.pathname == "/diets")
        if (window.location.search.length > 0) 
          $("#diets").html(incluye_dietas_favoritos()); // sÃ³lo favoritos
        else
          $("#diets").html(incluye_dietas_no_favoritos(diets)); // todos*/
    else
        if (window.location.search.length > 0)  
          $("#fitnesses").html(incluye_ejercicios_favoritos()); // sÃ³lo favoritos  
        else
           $("#fitnesses").html(incluye_ejercicios_no_favoritos(fitnesses)); // todos*/
  }

  // flag para no machacar al servidor si ya estÃ¡ actualizando
  var updating = false;

  // funciÃ³n para actualizar origamis desde el servidor
  var actualizaDesdeServidor = function() {
    // no machacamos al servidor si ya estamos en ello
    if(updating) return;

    updating = true;

    $.mobile.loading( 'show');
    $.getJSON("/diets.json?").done( function(json) {
        $.getJSON("/fitnesses.json?").done( function(json2) {
          console.log("url search: " + window.location.search.substring(1));
          actualizaOrigamis(json,json2);
        }).fail(function() {
         console.log( "error al acceder al servidor" );
         }).always(function() {
         $.mobile.loading( 'hide');
         updating = false;
         console.log( "complete" );
        });
     });
  }

  // Actualizarmos el html si tenemos origamis en el localStorage.
  // Si no estamos 'online', al menos se mostrarÃ¡ lo que tenemos en el storage
  if(localStorage.diets) 
    if(localStorage.fitnesses)    
      actualizaOrigamis(JSON.parse(localStorage.diets), JSON.parse(localStorage.fitnesses));
  

  // si el usuario entra 'online' desde 'offline'
  // accedemos al servidor para atualizar los origamis
  $(window).on("online", actualizaDesdeServidor);

  // Si el usuario estÃ¡ online. Actualizar la lista ahora
  if(window.navigator.onLine) actualizaDesdeServidor();
})
