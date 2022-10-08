class LoginRequest {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest {
  String name;
  String phoneNumber;
  String email;
  String password;
  RegisterRequest({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
