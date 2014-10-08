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
    }

    GP.fail = function(){
        // Could not obtain location
    }

    GP.processSearch = function(){
        location.href = location.origin + '/find?search=' + GP.lat + '%2C' + GP.lon;
    }

    $('.GP_get_location').on('click', function(e){
        console.log('Clicked');
        GP.initGeolocation();
        e.preventDefault();
        GP.processSearch();
    });
})();
