/*tripPlanner.js*/
// Contains all google api calls
// Please add any javscript/jquery code
// in this file

//global variables
/*global google*/
/*global $*/
var map;
// This function is first when user loads the page
function initMapUtil() {
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

var icons = {
  Building: {
    icon: 'assets/markers/schools.png'
  },
  Parking: {
    icon: 'assets/markers/automotive.png'
  },
  Bikes: {
    icon: 'assets/markers/automotive.png'
  },

};

function createMarker(latlng, type){
 if (map == undefined)
  {
    initMapUtil();   
  }
   var marker = new google.maps.Marker({
      map: map,
      position: latlng,
      title: type,
      icon: {url: icons[type].icon, scaledSize: new google.maps.Size(20,20)}
   });
}

function displayMarkers(data)
{
    console.log(data);
    bikesData = data['bikes']
    buildingsData = data['buildings']
    if (bikesData){
      for (i = 0; i < bikesData.points.length; i++){
      var latlng = new google.maps.LatLng(bikesData.points[i].lat, bikesData.points[i].lon);

      createMarker(latlng, bikesData.objtype);
   }}
   if (buildingsData){
    for (i = 0; i < buildingsData.points.length; i++){
      var latlng = new google.maps.LatLng(buildingsData.points[i].lat, buildingsData.points[i].lon);

      createMarker(latlng, buildingsData.objtype);
   }}
}
// Layer populater
$(document).ready(function() {

    // process the form
    $('#searchForm').submit(function(event) {

        
        // process the form
        $.ajax({
            type        : 'GET', // define the type of HTTP verb we want to use (POST for our form)
            url         : '/dropPins', // the url where we want to POST
            data        : $('#searchForm').serializeArray(), // our data object
            dataType    : 'json', // what type of data do we expect back from the server
            encode      : true,
            success     : function(data){ displayMarkers(data)}
        })
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });
});