class User {
  String name;
  String IC;
  String email;
  String password;
  String phoneNo;


  User({ this.name, this.IC, this.email, this.password, this.phoneNo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      IC: json['IC'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNo: json['phoneNo'] as String,
    );
  }
}