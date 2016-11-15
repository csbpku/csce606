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
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });
});