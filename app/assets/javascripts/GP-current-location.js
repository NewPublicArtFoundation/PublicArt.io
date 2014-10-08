var GP = {} || GP;

(function(){
    console.log('GP active');

    GP.initGeolocation = function(){
        if( navigator.geolocation ){
            // Call getCurrentPosition with success and failure callbacks
            navigator.geolocation.getCurrentPosition( GP.success, GP.fail );
        } else {
            alert("Sorry, your browser does not support geolocation services.");
        }
    }

    GP.success = function(position){
        GP.lon = position.coords.longitude;
        GP.lat = position.coords.latitude;
        GP.postToGoogle(position.coords.longitude, position.coords.latitude);
    }

    GP.fail = function(){
        // Could not obtain location
    }

    GP.processSearch = function(){
        location.href = location.origin + '/find?search=' + GP.lat + '%2C' + GP.lon;
    }

    GP.postToGoogle = function(lon, lat) {
        var field1 = lat;
        var field2 = lon;

        $.ajax({
            url: "https://docs.google.com/forms/d/19TmdAgos0j48ApewymWOgrept-WyeVdQy6BSw_J4HPw/formResponse",
            data: { "entry.1522668461": field1, "entry.2127807238": field2},
            type: "POST",
            dataType: "xml",
            statusCode: {
                0: function() {
                    //Success message
                },
                200: function() {
                    //Success Message
                }
            }
        });
    }

    $('.GP_get_location').on('click', function(e){
        e.preventDefault();
        console.log('Clicked');
        GP.initGeolocation();
        if(GP.lat != undefined){
            GP.processSearch();
        } else {
            setTimeout(function(){
                GP.initGeolocation();
            }, 500);
        }
    });
})();
