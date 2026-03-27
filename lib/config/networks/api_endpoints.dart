class ApiEndpoints {
  static const baseUrl = "http://192.168.2.67:5678"; // other system
  // static const baseUrl = "http://192.168.2.65:5678"; //locally

  //Auth
  static const register = "$baseUrl/v1/driver/register";
    static const uploadDocs = "$baseUrl/v1/driver/upload-driver-docs";
  static const login = "$baseUrl/v1/driver/auth/send-otp-login";
  static const varifyOTP = "$baseUrl/v1/driver/auth/verify-otp-login";

  static const uploadImage = "$baseUrl/v1/user/upload-image";

  //home
  static const rideAccepted = "$baseUrl/v1/driver/ride/accept";
  static const arrived = "$baseUrl/v1/driver/ride/arrived";
  static const startJourney = "$baseUrl/v1/driver/ride/start";
  static const reachedDestination =
      "$baseUrl/v1/driver/ride/reachedDestination";
  static const receivedPayment = "$baseUrl/v1/driver/ride/receivedPayment";





  static const goOnline = "$baseUrl/v1/driver/go-online";
  static const available = "$baseUrl/v1/driver/ride/available";
 static const logout = "$baseUrl/v1/driver/logout";
  static const goOffline = "$baseUrl/v1/driver/go-offline";


//------profile---------
 static const getProfile = "$baseUrl/v1/driver/me";
  static const updateProfle = "$baseUrl/v1/driver/update-profile";

//  v1/driver/update-profile
}
