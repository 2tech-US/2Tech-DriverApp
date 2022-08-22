class User {
  User({required this.id, required this.phone, required this.name});

  final int id;
  final String phone;
  final String name;

  static User loginResponse(Map<String, dynamic> json) {
    return User(
        id: json["driver"]["id"] ?? "1",
        phone: json["driver"]["phone"] ?? "1111111111",
        name: json["driver"]["name"] ?? "Driver");
  }
}
