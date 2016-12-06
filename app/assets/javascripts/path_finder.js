/*path_finder.js*/
// Contains all google api calls
// Please add any javscript/jquery code
// in this file


/*------------------------------Globals----------------------------------------*/
//global variables
var map;
/*-----------------------------Functions-----------------------------------------*/
// This function is first when user loads the page
function reInitMap() {
    var tamuCenter = {lat: 30.6187199, lng: -96.3364829};
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: tamuCenter,
      mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
            position: google.maps.ControlPosition.TOP_RIGHT
        }
    });
    var input1 = document.getElementById('from_from');
    var input2 = document.getElementById('from_to');
    var autocomplete1 = new google.maps.places.Autocomplete(input1);
    var autocomplete2 = new google.maps.places.Autocomplete(input2);
    autocomplete1.bindTo('bounds', map);
    autocomplete2.bindTo('bounds', map);
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
      alert('Could not find the guiven location.');
    }
  });
}

function draw_Route(from, to, mode){
    reInitMap();
    var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        directionsDisplay.setMap(map);
        var geocoder = new google.maps.Geocoder();
        
        geocodeAddress(geocoder,map,from,function(fromaddr){
          SourceCordinates = fromaddr
          geocodeAddress(geocoder,map,to,function(toaddr){
            destinationCordinates = toaddr
            directionsService.route({
            origin: new google.maps.LatLng(parseFloat(fromaddr.lat()), parseFloat(fromaddr.lng())),
            destination: new google.maps.LatLng(parseFloat(toaddr.lat()),parseFloat(toaddr.lng())),
            travelMode: mode
            }, function(response, status) {
            if (status=='OK') {
              directionsDisplay.setDirections(response);
            } else {
              window.alert('Directions request failed');
            }
            });
        });
    });
}
        
// Layer populater
$(document).ready(function() {
    
    
    $('#pathFinderForm #bike_route').click(function(event) {
        $('#pathFinderForm #bike_route').css("background","#cc7272");
        $('#pathFinderForm #car_route').css("background","white");
        $('#pathFinderForm #walk_route').css("background","white");
        var from = $('#from_from').val();
        var to = $('#from_to').val();
        draw_Route(from,to,'BICYCLING')
    });
    
    $('#pathFinderForm #walk_route').click(function(event) {
        $('#pathFinderForm #walk_route').css("background","#cc7272");
        $('#pathFinderForm #car_route').css("background","white");
        $('#pathFinderForm #bike_route').css("background","white");
        var from = $('#from_from').val();
        var to = $('#from_to').val();
        draw_Route(from,to,'WALKING')
    });

    $('#pathFinderForm #car_route').click(function(event) {
        $('#pathFinderForm #car_route').css("background","#cc7272");
        $('#pathFinderForm #walk_route').css("background","white");
        $('#pathFinderForm #bike_route').css("background","white");
        var from = $('#from_from').val();
        var to = $('#from_to').val();
        draw_Route(from,to,'DRIVING')
    });
});