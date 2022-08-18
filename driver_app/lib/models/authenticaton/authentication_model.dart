class LoginResponse {
  LoginResponse({
    required this.token,
    // required this.refreshToken,
  });

  String token;
  // String refreshToken;

  static LoginResponse? loginResponse(Map<String, dynamic>? json) {
    if (json == null) return null;
    return LoginResponse(
      token: json["token"],
      // refreshToken: json["refreshToken"],
    );
  }
}

class LoginRequest {
  String phone;
  String password;
  String deviceToken;

  LoginRequest(
      {required this.phone, required this.password, required this.deviceToken});

  Map<String, dynamic> toJson() =>
      {"phone": phone, "password": password, "device_token": deviceToken};
}

class RegisterRequest {
  String name;
  String phone;
  String password;
  String role = "driver";
  String confirmPassword;

  RegisterRequest({
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() =>
      {"phone": phone, "password": password, "name": name, "role": role};

  static int? registerSuccessful(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json["status"];
  }
}
