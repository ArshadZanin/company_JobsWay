import 'dart:convert';

HrCompany hrCompanyFromJson(String str) => HrCompany.fromJson(json.decode(str));

String hrCompanyToJson(HrCompany data) => json.encode(data.toJson());

class HrCompany {
  HrCompany({
    this.hr,
    this.signLink,
  });

  Hr? hr;
  String? signLink;

  factory HrCompany.fromJson(Map<String, dynamic> json) => HrCompany(
    hr: Hr.fromJson(json["hr"]),
    signLink: json["signLink"],
  );

  Map<String, dynamic> toJson() => {
    "hr": hr!.toJson(),
    "signLink": signLink,
  };
}

class Hr {
  Hr({
    this.id,
    this.email,
    this.name,
    this.companyId,
  });

  String? id;
  String? email;
  String? name;
  String? companyId;

  factory Hr.fromJson(Map<String, dynamic> json) => Hr(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    companyId: json["companyId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "companyId": companyId,
  };
}
