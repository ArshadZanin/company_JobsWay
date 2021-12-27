import 'dart:convert';

HrLoginModel hrLoginFromJson(String str) => HrLoginModel.fromJson(json.decode(str));

String hrLoginToJson(HrLoginModel data) => json.encode(data.toJson());

class HrLoginModel {
  HrLoginModel({
    this.hrDetails,
    this.token,
  });

  HrDetails? hrDetails;
  String? token;

  factory HrLoginModel.fromJson(Map<String, dynamic> json) => HrLoginModel(
    hrDetails: HrDetails.fromJson(json["hrDetails"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "hrDetails": hrDetails!.toJson(),
    "token": token,
  };
}

class HrDetails {
  HrDetails({
    this.id,
    this.email,
    this.name,
    this.companyId,
    this.password,
    this.status,
  });

  String? id;
  String? email;
  String? name;
  String? companyId;
  String? password;
  String? status;

  factory HrDetails.fromJson(Map<String, dynamic> json) => HrDetails(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    companyId: json["companyId"],
    password: json["password"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "companyId": companyId,
    "password": password,
    "status": status,
  };
}
