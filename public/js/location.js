var Location = {
	latitude: null,
	longitude: null,
	accuracy: null,
   
	loadLocation: function() {
		if(navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(this.success_handler, this.error_handler, {timeout:10000});
        }
   },

   success_handler: function (position) {
       latitude = position.coords.latitude;
       longitude = position.coords.longitude;
       accuracy = position.coords.accuracy;
       
       if (!latitude || !longitude) {
           return;
       }
       
       Location.updateDisplay();
   },
   
   updateDisplay: function () {               
       window.location='/findart?lat='+ latitude +'&lng='+ longitude;
   },
   
   error_handler: function error_handler(error) {
       var locationError = '';
       
       switch(error.code){
       case 0:
           locationError = "There was an error while retrieving your location: " + error.message;
           break;
       case 1:
           locationError = "The user prevented this page from retrieving a location.";
           break;
       case 2:
           locationError = "The browser was unable to determine your location: " + error.message;
           break;
       case 3:
           locationError = "The browser timed out before retrieving the location.";
           break;
       }
   },
}