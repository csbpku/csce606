/*tripPlanner.js*/
// Contains all google api calls
// Please add any javscript/jquery code
// in this file


/*------------------------------Globals----------------------------------------*/
//global variables
/*global google*/
/*global $*/
var map;
var icons = {
  Building: {
    icon: 'https://maps.google.com/mapfiles/kml/paddle/orange-stars.png'
  },
  Parking: {
    icon: 'https://maps.google.com/mapfiles/kml/paddle/blu-diamond.png'
  },
  Bikes: {
    icon: 'https://maps.google.com/mapfiles/kml/paddle/B.png'
  },
 
};



/*-----------------------------Functions-----------------------------------------*/

function popupcontent(type, point) {
  switch (type){
    case 'Building':
      return '<div><strong>' + point.name + '</strong><br>' +
             'Address: ' + point.address + '<br>';
    case 'Parking':
      return '<div><strong>' + point.lotname + '</strong><br>' +
             'Type: ' + point.lottype + '<br>';
  }
}

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

// This function is to create pop up
function createpopup(marker,contentString) {
    var infowindow = new google.maps.InfoWindow({
          content: contentString
    });
    
    marker.addListener('click', function() {
        infowindow.open(map, marker);
    });
}

// Creates markers on the map
function createMarker(latlng, type, point){
    var marker = new google.maps.Marker({
      map: map,
      position: latlng,
      title: type,
      icon: {url: icons[type].icon, scaledSize: new google.maps.Size(20,20)}
    });
    var contentString = popupcontent(type, point);
    createpopup(marker,contentString);
}

function displayMarkers(data)
{
    console.log(data);//for debuging only : temporary
    
    for(var j = 0;j<data.layer.length;j++){
        for (var i = 0; i < data.layer[j].points.length; i++){
            var latlng = new google.maps.LatLng(data.layer[j].points[i].lat, data.layer[j].points[i].lon);
            createMarker(latlng, data.layer[j].objtype,data.layer[j].points[i]);
        }
    }
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