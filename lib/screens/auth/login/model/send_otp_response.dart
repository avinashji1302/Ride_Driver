class SendOtpResponse {
  final String mobileOtpId;

  SendOtpResponse({required this.mobileOtpId});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      mobileOtpId: json['mobileOtpId'] ?? '',
    );
  }
}
