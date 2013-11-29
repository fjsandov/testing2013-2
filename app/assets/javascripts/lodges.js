var markersArray = [];
var geocoder;
var infowindow ;
var map;
var marker;

$( document ).ready(function() {

      geocoder = new google.maps.Geocoder();
      infowindow = new google.maps.InfoWindow();
      iniciarMapa();
      lat = $('#lodge_lat').val();
      lng = $('#lodge_long').val();
      var cord = new google.maps.LatLng(lat, lng);
      placeMarker(cord);

});


function iniciarMapa() {

  console.log('iniciar');

  var mapOptions = {
      zoom: 10,
      center: new google.maps.LatLng(-33.45,-70.6667),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);



              // On click, clear markers, place a new one, update coordinates in the form
    google.maps.event.addListener(map, 'rightclick', function(event) {
          clearOverlays();
          placeMarker(event.latLng);
          updateFormLocation(event.latLng);
          geocodePosition(event.latLng);
        });

        
}
      
      // Update form attributes with given coordinates
      function updateFormLocation(latLng) {
        $('#lodge_lat').val(latLng.lat());
        $('#lodge_long').val(latLng.lng());
        //$('#centre_gmaps_zoom').val(Gmaps.map.serviceObject.getZoom());
      }

      function updateAddress(address) {
        $('#lodge_address').val(address);
      }
      // Add a marker with an open infowindow


      //agrega un marker al mapa
    function placeMarker(latLng) {
        marker = new google.maps.Marker({
            position: latLng,
            map: map,
            animation: google.maps.Animation.DROP
        });

        markersArray.push(marker);
      } 

      // Removes the overlays from the map, including the ones loaded with the map itself

      function clearOverlays() {
     for (var i = 0; i < markersArray.length; i++ ) {
        markersArray[i].setMap(null);
      }
      markersArray = [];
    }

      function geocodePosition(latlng) {
        geocoder.geocode({
          'latLng': latlng
        }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          if (results[1]) {
            updateAddress(results[1].formatted_address);
          }
        } else {
          alert("Geocoder failed due to: " + status);
        }
      });

      }




