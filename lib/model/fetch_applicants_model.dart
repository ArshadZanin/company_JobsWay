import 'dart:convert';

FetchApplicants fetchApplicantsFromJson(String str) =>
    FetchApplicants.fromJson(json.decode(str));

String fetchApplicantsToJson(FetchApplicants data) =>
    json.encode(data.toJson());

class FetchApplicants {
  FetchApplicants({
    this.applicantsList,
  });

  List<ApplicantsList>? applicantsList;

  factory FetchApplicants.fromJson(Map<String, dynamic> json) =>
      FetchApplicants(
        applicantsList: List<ApplicantsList>.from(
            json["applicantsList"].map((x) => ApplicantsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "applicantsList":
            List<dynamic>.from(applicantsList!.map((x) => x.toJson())),
      };
}

class ApplicantsList {
  ApplicantsList({
    this.id,
    this.jobTitle,
    this.applications,
  });

  String? id;
  String? jobTitle;
  Applications? applications;

  factory ApplicantsList.fromJson(Map<String, dynamic> json) => ApplicantsList(
        id: json["_id"],
        jobTitle: json["jobTitle"],
        applications: Applications.fromJson(json["applications"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jobTitle": jobTitle,
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
