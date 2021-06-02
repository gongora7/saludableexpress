import 'package:flutter_app1/src/models/user_liked_products.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  int roleId;
  @HiveField(2)
  String userName;
  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String gender;
  @HiveField(6)
  int defaultAddressId;
  @HiveField(7)
  String countryCode;
  @HiveField(8)
  String phone;
  @HiveField(9)
  String email;
  @HiveField(10)
  String password;
  @HiveField(11)
  String avatar;
  @HiveField(12)
  String status;
  @HiveField(13)
  int isSeen;
  @HiveField(14)
  int phoneVerified;
  @HiveField(15)
  String rememberToken;
  @HiveField(16)
  String authIdTiwilo;
  @HiveField(17)
  String dob;
  @HiveField(18)
  String createdAt;
  @HiveField(19)
  String updatedAt;
/*
  @HiveField(1)
  List<UserLikedProducts> likedProducts;
*/

  User(
      {this.id,
      this.roleId,
      this.userName,
      this.firstName,
      this.lastName,
      this.gender,
      this.defaultAddressId,
      this.countryCode,
      this.phone,
      this.email,
      this.password,
      this.avatar,
      this.status,
      this.isSeen,
      this.phoneVerified,
      this.rememberToken,
      this.authIdTiwilo,
      this.dob,
      this.createdAt,
      this.updatedAt/*,
      this.likedProducts*/});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    defaultAddressId = json['default_address_id'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    status = json['status'];
    isSeen = json['is_seen'];
    phoneVerified = json['phone_verified'];
    rememberToken = json['remember_token'];
    authIdTiwilo = json['auth_id_tiwilo'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
/*
    if (json['liked_products'] != null) {
      likedProducts = new List<UserLikedProducts>();
      json['liked_products'].forEach((v) {
        likedProducts.add(new UserLikedProducts.fromJson(v));
      });
    }
*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['user_name'] = this.userName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['default_address_id'] = this.defaultAddressId;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['is_seen'] = this.isSeen;
    data['phone_verified'] = this.phoneVerified;
    data['remember_token'] = this.rememberToken;
    data['auth_id_tiwilo'] = this.authIdTiwilo;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
/*
    if (this.likedProducts != null) {
      data['liked_products'] =
          this.likedProducts.map((v) => v.toJson()).toList();
    }
*/
    return data;
  }
}
