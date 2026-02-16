class ApiEndpoints {
  static const baseUrl = "http://192.168.2.58:5678";
  // static const baseUrl = "http://localhost:5678";

  //Auth
  static const register = "$baseUrl/v1/driver/register";
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


}
