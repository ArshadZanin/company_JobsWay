import 'dart:convert';

Registered registeredFromJson(String str) => Registered.fromJson(json.decode(str));

String registeredToJson(Registered data) => json.encode(data.toJson());

class Registered {
  Registered({
    this.company,
    this.token,
  });

  Company? company;
  String? token;

  factory Registered.fromJson(Map<String, dynamic> json) => Registered(
    company: Company.fromJson(json["company"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "company": company!.toJson(),
    "token": token,
  };
}

class Company {
  Company({
    this.id,
    this.companyName,
    this.industry,
    this.email,
    this.location,
    this.phone,
    this.bio,
    this.website,
    this.linkedIn,
    this.facebook,
    this.twitter,
    this.instagram,
    this.password,
    this.logoUrl,
    this.status,
    this.ban,
  });

  String? id;
  String? companyName;
  String? industry;
  String? email;
  String? location;
  String? phone;
  String? bio;
  String? website;
  String? linkedIn;
  String? facebook;
  String? twitter;
  String? instagram;
  String? password;
  String? logoUrl;
  bool? status;
  bool? ban;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["_id"],
    companyName: json["companyName"],
    industry: json["industry"],
    email: json["email"],
    location: json["location"],
    phone: json["phone"],
    bio: json["bio"],
    website: json["website"],
    linkedIn: json["linkedIn"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    password: json["password"],
    logoUrl: json["logoUrl"],
    status: json["status"],
    ban: json["ban"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "companyName": companyName,
    "industry": industry,
    "email": email,
    "location": location,
    "phone": phone,
    "bio": bio,
    "website": website,
    "linkedIn": linkedIn,
    "facebook": facebook,
    "twitter": twitter,
    "instagram": instagram,
    "password": password,
    "logoUrl": logoUrl,
    "status": status,
    "ban": ban,
  };
}
