class LoginModel {
  String email;
  String password;

  LoginModel(this.email, this.password);
}

class RegisterModel {
  String email;
  String name;
  String phone;
  String password;
  String username;

  RegisterModel(
      this.email, this.name, this.password, this.phone, this.username);
}
