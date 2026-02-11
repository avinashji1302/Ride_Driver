class ApiEndpoints {
  static const baseUrl = "http://192.168.2.236:5678";
  // static const baseUrl = "http://192.168.2.239:5678";

  //Auth
  static const register = "$baseUrl/v1/driver/register";
  static const login = "$baseUrl/v1/driver/auth/send-otp-login";
   static const varifyOTP = "$baseUrl/v1/driver/auth/verify-otp-login";


static const uploadImage = "$baseUrl/v1/user/upload-image";
// http://localhost:5678/v1/driver/auth/verify-otp-login'
  // http://localhost:5678/v1/driver/auth/send-otp-login%27
  // 'http://192.168.2.236:5678/v1/driver/ride/accept'


  //home

   static const rideAccepted = "$baseUrl/v1/driver/ride/accept";

}