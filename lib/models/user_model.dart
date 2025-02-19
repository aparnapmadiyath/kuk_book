// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final List<Address> address;
  final String id;
  final DateTime createdDate;
  final bool delete;
  final List<dynamic> search;
  final DocumentReference? reference;
  final String profilePic;
  final List<dynamic> bio;
  final List<dynamic> followers;
  final List<dynamic> watchLater;
  final List<dynamic> downloads;
  final List<dynamic> myRecipes;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.id,
    required this.createdDate,
    required this.delete,
    required this.search,
     this.reference,
    required this.profilePic,
    required this.bio,
    required this.followers,
    required this.watchLater,
    required this.downloads,
    required this.myRecipes,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    List<Address>? address,
    String? id,
    DateTime? createdDate,
    bool? delete,
    List<dynamic>? search,
    DocumentReference? reference,
    String? profilePic,
    List<dynamic>? bio,
    List<dynamic>? followers,
    List<dynamic>? watchLater,
    List<dynamic>? downloads,
    List<dynamic>? myRecipes,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        address: address ?? this.address,
        id: id ?? this.id,
        createdDate: createdDate ?? this.createdDate,
        delete: delete ?? this.delete,
        search: search ?? this.search,
        reference: reference ?? this.reference,
        profilePic: profilePic ?? this.profilePic,
        bio: bio ?? this.bio,
        followers: followers ?? this.followers,
        watchLater: watchLater ?? this.watchLater,
        downloads: downloads ?? this.downloads,
        myRecipes: myRecipes ?? this.myRecipes,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    id: json["id"],
    createdDate: json["createdDate"].toDate(),
    delete: json["delete"],
    search: List<dynamic>.from(json["search"].map((x) => x)),
    reference: json["reference"],
    profilePic: json["profilePic"],
    bio: List<dynamic>.from(json["bio"].map((x) => x)),
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    watchLater: List<dynamic>.from(json["watchLater"].map((x) => x)),
    downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
    myRecipes: List<dynamic>.from(json["myRecipes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "id": id,
    "createdDate": createdDate,
    "delete": delete,
    "search": List<dynamic>.from(search.map((x) => x)),
    "reference": reference,
    "profilePic": profilePic,
    "bio": List<dynamic>.from(bio.map((x) => x)),
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "watchLater": List<dynamic>.from(watchLater.map((x) => x)),
    "downloads": List<dynamic>.from(downloads.map((x) => x)),
    "myRecipes": List<dynamic>.from(myRecipes.map((x) => x)),
  };
}

class Address {
  final String place;
  final String city;
  final String state;
  final String dist;
  final String pin;

  Address({
    required this.place,
    required this.city,
    required this.state,
    required this.dist,
    required this.pin,
  });

  Address copyWith({
    String? place,
    String? city,
    String? state,
    String? dist,
    String? pin,
  }) =>
      Address(
        place: place ?? this.place,
        city: city ?? this.city,
        state: state ?? this.state,
        dist: dist ?? this.dist,
        pin: pin ?? this.pin,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    place: json["place"],
    city: json["city"],
    state: json["state"],
    dist: json["dist"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "place": place,
    "city": city,
    "state": state,
    "dist": dist,
    "pin": pin,
  };
}
