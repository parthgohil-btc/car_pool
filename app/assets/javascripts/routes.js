$(document).ready(function(){
  	$(".map-load").on("click", function(event) {
		coordinates = $("#locations_coordinates").attr('value');
		handler = Gmaps.build('Google');
		handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
		  markers = handler.addMarkers(coordinates);
		  handler.bounds.extendWith(markers);
		  handler.fitMapToBounds();
		  handler.getMap().setZoom(15);
		});
	})
});