import 'dart:convert';

FetchTask fetchTaskFromJson(String str) => FetchTask.fromJson(json.decode(str));

String fetchTaskToJson(FetchTask data) => json.encode(data.toJson());

class FetchTask {
  FetchTask({
    this.id,
    this.hrId,
    this.qset1,
    this.qset2,
    this.qset3,
  });

  String? id;
  String? hrId;
  Qset? qset1;
  Qset? qset2;
  Qset? qset3;

  factory FetchTask.fromJson(Map<String, dynamic> json) => FetchTask(
    id: json["_id"],
    hrId: json["hrId"],
    qset1: Qset.fromJson(json["Qset1"]),
    qset2: Qset.fromJson(json["Qset2"]),
    qset3: Qset.fromJson(json["Qset3"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hrId": hrId,
    "Qset1": qset1!.toJson(),
    "Qset2": qset2!.toJson(),
    "Qset3": qset3!.toJson(),
  };
}

class Qset {
  Qset({
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.uuid,
  });

  String? q1;
  String? q2;
  String? q3;
  String? q4;
  String? uuid;

  factory Qset.fromJson(Map<String, dynamic> json) => Qset(
    q1: json["q1"],
    q2: json["q2"],
    q3: json["q3"],
    q4: json["q4"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "q1": q1,
    "q2": q2,
    "q3": q3,
    "q4": q4,
    "uuid": uuid,
  };
}
