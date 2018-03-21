// If value 1 only, then value 1 is address
// If value 1&2, then value 1 is street, and value 2 is block/unit
// If value 1,2,3 then value 1 is street, value 2 is building, value 3 is block/unit

// Sample return data
/*
response{
	results: [
		0: [
			ADDRESS"158 KALLANG WAY PERFORMANCE BUILDING SINGAPORE 349245"
			BLK_NO:"158"
			BUILDING:"PERFORMANCE BUILDING"
			LATITUDE:"1.32320025483415"
			LONGITUDE:"103.876549935471"
			LONGTITUDE:"103.876549935471"
			POSTAL:"349245"
			ROAD_NAME:"KALLANG WAY"
			SEARCHVAL:"PERFORMANCE BUILDING"
			X:"32811.2183294455"
			Y:"33938.3202846274"
		]
	]
}
*/

function postalcode(ele, value1, value2, value3){
	if($(ele).length){
		$(ele).on("keyup", function(e){
			if(Number($(ele).val()) && $(ele).val().length > 3){
				$.get("https://developers.onemap.sg/commonapi/search?returnGeom=Y&getAddrDetails=Y&pageNum=1&searchVal=" + $(ele).val(), function(response){
					if('results' in response && response.found > 0){
						block = response.results[0].BLK_NO;
						street = response.results[0].ROAD_NAME;
						building = response.results[0].BUILDING;
					
						//cl(response); // console.log
						if(value1 && value2 && value3){ 
							$(value1).val(street);
							$(value2).val(building);
							$(value3).val(block);
						}
						else if(value1 && value2){
							$(value1).val(block+" "+street);
							$(value2).val(building);
						}
						else if (value1){ 
							address = response.results[0].ADDRESS; // As a whole
							address_only = address.replace(response.results[0].POSTAL, "");
							
							$(value1).val(address_only);
						}
						else{
							// No value
						}
					}
				});
			}
		});
	}
}


var last_click = null;
$(window).load(function () {
	$(".list-group .input-group .input-group-addon").click(function (e) {
		e.preventDefault();
		e.stopPropagation();

		if (this != last_click) {

			last_click = this;

			// Level Parent
			parent = $(this).data("parent");
			cl(parent);
			$("." + parent).removeClass("active");

			// Level child
			level = $(this).data("level");
			$("." + level).stop().slideUp(300);

			$(this).prev().addClass("active");

			child = $("." + this.id);
			if (child.length) {
				child.stop().slideDown(300);
			}
		} else {

		}
	});

	$(".input-number").on("keydown, keyup, change", function (e) {

		filter = [46, 8, 9, 27, 13, 110, 190];
		if ($(this).hasClass('integer') || $(this).val().indexOf('.') > -1) {
			filter = [46, 8, 9, 27, 13, 190];
		}

		// Allow: backspace, delete, tab, escape, enter and .
		if ($.inArray(e.keyCode, filter) !== -1 ||
			// Allow: Ctrl+A
			(e.keyCode == 65 && e.ctrlKey === true) ||
			// Allow: Ctrl+C
			(e.keyCode == 67 && e.ctrlKey === true) ||
			// Allow: Ctrl+X
			(e.keyCode == 88 && e.ctrlKey === true) ||
			// Allow: home, end, left, right
			(e.keyCode >= 35 && e.keyCode <= 39)) {
			// Retrun key press value
			return;
		}
		// Ensure that it is a number and stop the keypress
		if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
			e.preventDefault();
		}

	});


});


/* UItoTop jQuery */
jQuery(document).ready(function () {
	$().UItoTop({
		easingType: 'easeOutQuint'
	});
});

(function ($) {
	$.fn.UItoTop = function (options) {
		var defaults = {
			text: 'To Top',
			min: 200,
			inDelay: 600,
			outDelay: 400,
			containerID: 'ToTop',
			containerHoverID: 'ToTopHover',
			scrollSpeed: 800,
			easingType: 'linear'
		};

		var settings = $.extend(defaults, options);
		var containerIDhash = '#' + settings.containerID;
		var containerHoverIDHash = '#' + settings.containerHoverID;
		$('body').append('<span id="' + settings.containerID + '">' + settings.text + '</span>');
		$(containerIDhash).hide().click(function (event) {
			$('html, body').animate({
				scrollTop: 0
			}, settings.scrollSpeed);
			event.preventDefault();
		})
			.prepend('<span id="' + settings.containerHoverID + '"></span>')
			.hover(function () {
				$(containerHoverIDHash, this).stop().animate({
					'opacity': 1
				}, 600, 'linear');
			}, function () {
				$(containerHoverIDHash, this).stop().animate({
					'opacity': 0
				}, 700, 'linear');
			});
		$(window).scroll(function () {
			var sd = $(window).scrollTop();
			if (typeof document.body.style.maxHeight === "undefined") {
				$(containerIDhash).css({
					'position': 'absolute',
					'top': $(window).scrollTop() + $(window).height() - 50
				});
			}
			if (sd > settings.min)
				$(containerIDhash).fadeIn(settings.inDelay);
			else
				$(containerIDhash).fadeOut(settings.Outdelay);
		});
	};
})(jQuery);

function cl(x) {
	console.log(x);
}

/* Google Map */

var mapObj = [];

function gmap() {

	var infowindow = [];
	var service = [];
	var marker = [];

	$("[data-toggle=\'gmap\']").each(function (index, value) {
		cmap = $(this);
		loadMapMarker(mapObj, index, cmap);
	});

	$("#accordion").on('shown.bs.collapse', function () {
		reintGmap();
	});
}

function loadMapMarker(mapObj, index, cmap) {

	var lat = cmap.data('lat');
	var lng = cmap.data('lng');
	var id = cmap.data('id');
	var store = cmap.data('store');
	var address = cmap.data('address');

	var place = { lat: lat, lng: lng };
	mapObj[index] = new google.maps.Map(
		document.getElementById(id), {
			zoom: 16,
			center: place
		});

	var contentString =
		'<b>' + store + '</b>' +
		'<p>' + address + '</p>';

	var infowindow = new google.maps.InfoWindow({
		content: contentString
	});

	var marker = new google.maps.Marker({
		position: place,
		map: mapObj[index],
		title: store
	});

	marker.addListener('click', function () {
		infowindow.open(mapObj[index], marker);
	});

}

function reintGmap() {
	var center = null;
	$.each(mapObj, function (index, value) {
		center = mapObj[index].getCenter();
		google.maps.event.trigger(mapObj[index], "resize");
		mapObj[index].setCenter(center);
	});
}

