var GP = {} || GP;

(function(){
    console.log('GP active');

    GP.initGeolocation = function(){
        if( navigator.geolocation ){
            // Call getCurrentPosition with success and failure callbacks
            navigator.geolocation.getCurrentPosition( function(){ GP.success }, function(){ GP.fail } );
        } else {
            alert("Sorry, your browser does not support geolocation services.");
        }
    }

    GP.success = function(position){
        console.log('long', position.coords.longitude);
        console.log('lat', position.coords.latitude);
    }

    GP.fail = function(){
        // Could not obtain location
    }

    $('.GP_get_location').on('click', function(e){
        console.log('Clicked');
        e.preventDefault();
        GP.initGeolocation();
    });
})();
