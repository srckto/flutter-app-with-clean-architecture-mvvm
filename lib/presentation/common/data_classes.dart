
class LoginObject {
  String userName;
  String password;
  LoginObject({
    this.userName = "",
    this.password = "",
  });

  LoginObject copyWith({
    String? userName,
    String? password,
  }) {
    return LoginObject(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}

class RegisterObject {
  String name;
  String phoneNumber;
  String email;
  String password;
  String profilePicture;
  RegisterObject({
    this.name = "",
    this.phoneNumber = "",
    this.email = "",
    this.password = "",
    this.profilePicture = "",
  });

  RegisterObject copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    String? profilePicture,
  }) {
    return RegisterObject(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
