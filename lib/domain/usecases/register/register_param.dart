class RegisterParam {
  final String email;
  final String name;
  final String password;
  final String? photoUrl;
  final int balance;

  RegisterParam(
      {required this.email,
      required this.name,
      required this.password,
      required this.photoUrl,
      required this.balance});
}
