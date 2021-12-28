import 'dart:convert';

FetchHr fetchHrFromJson(String str) => FetchHr.fromJson(json.decode(str));

String fetchHrToJson(FetchHr data) => json.encode(data.toJson());

class FetchHr {
  FetchHr({
    this.hrDetails,
  });

  List<HrDetail>? hrDetails;

  factory FetchHr.fromJson(Map<String, dynamic> json) => FetchHr(
    hrDetails: List<HrDetail>.from(json["HrDetails"].map((x) => HrDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "HrDetails": List<dynamic>.from(hrDetails!.map((x) => x.toJson())),
  };
}

class HrDetail {
  HrDetail({
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

  factory HrDetail.fromJson(Map<String, dynamic> json) => HrDetail(
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




// import 'dart:convert';
//
// FetchHr fetchHrFromJson(String str) => FetchHr.fromJson(json.decode(str));
//
// String fetchHrToJson(FetchHr data) => json.encode(data.toJson());
//
// class FetchHr {
//   FetchHr({
//     this.hrDetails,
//   });
//
//   List<HrDetail>? hrDetails;
//
//   factory FetchHr.fromJson(Map<String, dynamic> json) => FetchHr(
//     hrDetails: List<HrDetail>.from(json["HrDetails"].map((x) => HrDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "HrDetails": List<dynamic>.from(hrDetails!.map((x) => x.toJson())),
//   };
// }
//
// class HrDetail {
//   HrDetail({
//     this.id,
//     this.email,
//     this.name,
//     this.companyId,
//     this.password,
//   });
//
//   String? id;
//   String? email;
//   String? name;
//   String? companyId;
//   String? password;
//
//   factory HrDetail.fromJson(Map<String, dynamic> json) => HrDetail(
//     id: json["_id"],
//     email: json["email"],
//     name: json["name"],
//     companyId: json["companyId"],
//     password: json["password"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "email": email,
//     "name": name,
//     "companyId": companyId,
//     "password": password,
//   };
// }
