import 'dart:convert';

ShortlistedUsers shortlistedUsersFromJson(String str) => ShortlistedUsers.fromJson(json.decode(str));

String shortlistedUsersToJson(ShortlistedUsers data) => json.encode(data.toJson());

class ShortlistedUsers {
  ShortlistedUsers({
    this.shortListed,
  });

  List<ShortListed>? shortListed;

  factory ShortlistedUsers.fromJson(Map<String, dynamic> json) => ShortlistedUsers(
    shortListed: List<ShortListed>.from(json["shortListed"].map((x) => ShortListed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shortListed": List<dynamic>.from(shortListed!.map((x) => x.toJson())),
  };
}

class ShortListed {
  ShortListed({
    this.id,
    this.applications,
  });

  String? id;
  Applications? applications;

  factory ShortListed.fromJson(Map<String, dynamic> json) => ShortListed(
    id: json["_id"],
    applications: Applications.fromJson(json["applications"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "applications": applications!.toJson(),
  };
}

class Applications {
  Applications({
    this.userId,
    this.firstName,
    this.secondName,
    this.email,
    this.phone,
    this.location,
    this.experience,
    this.portfolio,
    this.imgUrl,
    this.resumeUrl,
    this.status,
  });

  String? userId;
  String? firstName;
  String? secondName;
  String? email;
  String? phone;
  String? location;
  String? experience;
  String? portfolio;
  String? imgUrl;
  String? resumeUrl;
  String? status;

  factory Applications.fromJson(Map<String, dynamic> json) => Applications(
    userId: json["userId"],
    firstName: json["firstName"],
    secondName: json["secondName"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"],
    experience: json["experience"],
    portfolio: json["portfolio"],
    imgUrl: json["imgUrl"],
    resumeUrl: json["resumeUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "secondName": secondName,
    "email": email,
    "phone": phone,
    "location": location,
    "experience": experience,
    "portfolio": portfolio,
    "imgUrl": imgUrl,
    "resumeUrl": resumeUrl,
    "status": status,
  };
}
