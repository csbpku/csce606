/*path_finder.js*/
// Contains all google api calls
// Please add any javscript/jquery code
// in this file


/*------------------------------Globals----------------------------------------*/
//global variables
/*global google*/
/*global $*/
var map;

/*-----------------------------Functions-----------------------------------------*/
// This function is first when user loads the page
function initMap() {
    var tamuCenter = {lat: 30.6187199, lng: -96.3364829};
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: tamuCenter,
      mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
            position: google.maps.ControlPosition.TOP_RIGHT
        }
    });
}

function geocodeAddress(geocoder, resultsMap, address, callback) {
  geocoder.geocode({'address': address}, function(results, status) {
    
    if (status === 'OK') {
      if (results[0]) {
          callback(results[0].geometry.location);
        } else {
          alert("No results found");
        }
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function drawRoute(from, to){
    var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        var geocoder = new google.maps.Geocoder();
        geocodeAddress(geocoder,map,from,function(fromaddr){
          alert(fromaddr);
          SourceCordinates = fromaddr
          geocodeAddress(geocoder,map,to,function(toaddr){
            alert(toaddr);
            destinationCordinates = toaddr
            directionsService.route({
              origin: new google.maps.LatLng(SourceCordinates.lat(), SourceCordinates.lng()),
              destination: new google.maps.LatLng(destinationCordinates.lat(), destinationCordinates.lng()),
              travelMode: 'DRIVING'
              }, function(response, status) {
                                              if (status === 'OK') {
                                                directionsDisplay.setDirections(response);
                                              } else {
                                                window.alert('Directions request failed due to ' + status);
                                              }
            });
            });
        });
}
// Layer populater
$(document).ready(function() {
    
    $('#pathFinderForm').submit(function(event) {
        $('#path_finder').modal('hide');
        drawRoute("Evans Library","Texas A&M University");
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });
});