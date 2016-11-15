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

// Layer populater
$(document).ready(function() {
    
    $('#pathFinderForm').submit(function(event) {
        $('#path_finder').modal('hide');
         var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        directionsService.route({
          origin: "Harvey R. Bright Building, College Station, TX 77840, USA",
          destination: "200 S College St #1530, Charlotte, NC 28202, USA",
          travelMode: 'DRIVING'
        }, function(response, status) {
          if (status === 'OK') {
            directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
        
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });
});