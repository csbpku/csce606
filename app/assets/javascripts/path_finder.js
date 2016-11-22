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

function draw_Bike_Walk_Route(from, to,mode){
    var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        var geocoder = new google.maps.Geocoder();
        
        geocodeAddress(geocoder,map,from,function(fromaddr){
          SourceCordinates = fromaddr
          geocodeAddress(geocoder,map,to,function(toaddr){
            destinationCordinates = toaddr
            if(mode==1){
            directionsService.route({
            origin: new google.maps.LatLng(parseFloat(fromaddr.lat()), parseFloat(fromaddr.lng())),
            destination: new google.maps.LatLng(parseFloat(toaddr.lat()),parseFloat(toaddr.lng())),
            travelMode: 'BICYCLING'
            }, function(response, status) {
            if (status=='OK') {
              directionsDisplay.setDirections(response);
            } else {
              window.alert('Directions request failed due to ' + status);
            }
            });
          }
          else{
              directionsService.route({
            origin: new google.maps.LatLng(parseFloat(fromaddr.lat()), parseFloat(fromaddr.lng())),
            destination: new google.maps.LatLng(parseFloat(toaddr.lat()),parseFloat(toaddr.lng())),
            travelMode: 'WALKING'
            }, function(response, status) {
            if (status=='OK') {
              directionsDisplay.setDirections(response);
            } else {
              window.alert('Directions request failed due to ' + status);
            }
            });
          }
        });
    });
}
        
function drawRoute(origin,destination){
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
        // stop the form from submitting the normal way and refreshing the page
        
        event.preventDefault();
        
    });
    
    $('#pathFinderForm #bike_route').click(function(event) {
        $('#pathFinderForm #bike_route').css("background","#cc7272");
        
        $('#pathFinderForm #walk_route').css("background","white");
        var from = $('#from_from').val();
        var to = $('#from_to').val();
        draw_Bike_Walk_Route(from,to,1)
    });
    
    $('#pathFinderForm #walk_route').click(function(event) {
        $('#pathFinderForm #walk_route').css("background","#cc7272");
        $('#pathFinderForm #bike_route').css("background","white");
        var from = $('#from_from').val();
        var to = $('#from_to').val();
        draw_Bike_Walk_Route(from,to,2)
    });
});