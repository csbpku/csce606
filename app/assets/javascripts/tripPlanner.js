/*tripPlanner.js*/
// Contains all google api calls
// Please add any javscript/jquery code
// in this file

//global variables
/*global google*/

// This function is first when user loads the page
function initMap() {
    var tamuCenter = {lat: 30.6187199, lng: -96.3364829};
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: tamuCenter,
    	mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
            position: google.maps.ControlPosition.TOP_RIGHT
        }
    });
}