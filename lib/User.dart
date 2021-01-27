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


class UserAddress {
  String street;
  String city;
  String state;
  String district;
  int poskod;
  int userID;


  UserAddress({ this.street, this.city, this.state, this.district, this.poskod, this.userID});

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      district: json['district'] as String,
      poskod: json['poskod'] as int,
      userID: json['userID'] as int,
    );
  }
}

