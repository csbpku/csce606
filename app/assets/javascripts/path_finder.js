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

function drawRoute(){
    var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        directionsService.route({
          origin: new google.maps.LatLng(30.51953606, -96.41673369),
          destination: new google.maps.LatLng(30.51999039,-96.4167104),
          travelMode: 'DRIVING'
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
        
}
// Layer populater
$(document).ready(function() {
    
    $('#pathFinderForm').submit(function(event) {
        $('#path_finder').modal('hide');
        drawRoute();
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });
});