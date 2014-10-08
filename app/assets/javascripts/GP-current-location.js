var GP = {} || GP;

GP.initGeolocation = function(){
    if( navigator.geolocation ){
        // Call getCurrentPosition with success and failure callbacks
        navigator.geolocation.getCurrentPosition( GP.success, GP.fail );
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
    e.preventDefault();
    initGeolocation();
});
