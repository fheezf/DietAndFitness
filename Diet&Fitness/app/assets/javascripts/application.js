// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.mobile
//= require_tree .

var appCache = window.applicationCache;

function handleCacheEvent(e) {
  var estatus = function() {switch (appCache.status) {
    case appCache.UNCACHED: // UNCACHED == 0
      return 'UNCACHED';
      break;
    case appCache.IDLE: // IDLE == 1
      return 'IDLE';
      break;
    case appCache.CHECKING: // CHECKING == 2
      return 'CHECKING';
      break;
    case appCache.DOWNLOADING: // DOWNLOADING == 3
      return 'DOWNLOADING';
      break;
    case appCache.UPDATEREADY:  // UPDATEREADY == 4
      return 'UPDATEREADY';
      break;
    case appCache.OBSOLETE: // OBSOLETE == 5
      return 'OBSOLETE';
      break;
    default:
      return 'UKNOWN CACHE STATUS';
      break;
  };}
  console.log("Evento Cache: " + estatus());
}

function handleCacheError(e) {
  console.log('Error: fallo en la actualizaciÃ³n de la Cache');
};

// Fired after the first cache of the manifest.
appCache.addEventListener('cached', handleCacheEvent, false);

// Checking for an update. Always the first event fired in the sequence.
appCache.addEventListener('checking', handleCacheEvent, false);

// An update was found. The browser is fetching resources.
appCache.addEventListener('downloading', handleCacheEvent, false);

// The manifest returns 404 or 410, the download failed,
// or the manifest changed while the download was in progress.
appCache.addEventListener('error', handleCacheError, false);

// Fired after the first download of the manifest.
appCache.addEventListener('noupdate', handleCacheEvent, false);

// Fired if the manifest file returns a 404 or 410.
// This results in the application cache being deleted.
appCache.addEventListener('obsolete', handleCacheEvent, false);

// Fired for each resource listed in the manifest as it is being fetched.
appCache.addEventListener('progress', handleCacheEvent, false);

// Fired when the manifest resources have been newly redownloaded.
//appCache.addEventListener('updateready', handleCacheEvent, false);
appCache.addEventListener('updateready', function(e){

  if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
     if (confirm('Está disponible nueva versión del Portal. ¿Desea cargarlo?')) {
       window.location.reload(); 
       console.log("swap de cache");
      } 

  }}, false);
