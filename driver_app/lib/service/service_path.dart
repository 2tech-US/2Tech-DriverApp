class ServicePath {
  static const String apiUrl = "http://10.0.0.2:3000";
  static const String login = "$apiUrl/auth/login/driver";
  static const String register = "$apiUrl/auth/register";

  //Driver
  static const String getDriverInfor = "$apiUrl/drivers/";
  static const String updateDriverLocation = "$apiUrl/drivers/location";
}
