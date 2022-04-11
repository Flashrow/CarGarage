class PersonDto {
  String? id;
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? sex;

  PersonDto({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.sex,
  });

  PersonDto.fromJson(dynamic json) {
    id = json["_id"].toString();
    firstName = json["first_name"].toString();
    lastName = json["last_name"].toString();
    birthDate = DateTime.tryParse(json["birth_date"]);
    sex = json["sex"].toString();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["sex"] = sex;
    map["birth_date"] = birthDate?.toIso8601String();
    return map;
  }
}
