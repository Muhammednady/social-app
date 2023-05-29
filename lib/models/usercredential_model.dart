import 'dart:convert';

class UserCredentialModel {

  String? name;
  String? email;
  String? phone;
  String? uID;
  String? profileImage;
  String? coverImage;
  String? bio;
  bool? isEmailVerified;

  UserCredentialModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uID,
      required this.profileImage,
      required this.coverImage,
      required this.bio,
      required this.isEmailVerified});

  UserCredentialModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uID = json['uid'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uID,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
