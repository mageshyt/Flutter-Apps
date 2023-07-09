import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String uid;
  final String name;
  final String email;
  final List<String> followers;
  final List<String> following;
  final String avatar;
  final String bannerPic;
  final String bio;
  final bool isVerified;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
    required this.avatar,
    required this.bannerPic,
    required this.bio,
    required this.isVerified,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? uid,
    List<String>? followers,
    List<String>? following,
    String? avatar,
    String? bannerPic,
    String? bio,
    bool? isVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      avatar: avatar ?? this.avatar,
      bannerPic: bannerPic ?? this.bannerPic,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'followers': followers,
      'following': following,
      'avatar': avatar,
      'bannerPic': bannerPic,
      'bio': bio,
      'isVerified': isVerified,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      followers: map['followers'],
      following: map['following'],
      avatar: map['avatar'] ?? '',
      bannerPic: map['bannerPic'] ?? '',
      bio: map['bio'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, followers: $followers, following: $following, avatar: $avatar, bannerPic: $bannerPic, bio: $bio, isVerified: $isVerified)';
  }
}
