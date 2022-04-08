class CarDto {
  String? _id;
  String? brand;
  String? model;
  String? color;
  String? registration;
  DateTime? year;
  String? ownerId;
  double? lat;
  double? lng;

  CarDto(
      {this.brand,
      this.model,
      this.color,
      this.registration,
      this.year,
      this.ownerId,
      this.lat,
      this.lng});

  CarDto.fromJson(dynamic json) {
    _id = json["_id"];
    brand = json["brand"];
    model = json["model"];
    color = json["color"];
    registration = json["registration"];
    year = DateTime.tryParse(json["year"]);
    ownerId = json["ownerId"];
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["brand"] = brand;
    map["model"] = model;
    map["color"] = color;
    map["registration"] = registration;
    map["year"] = year?.toIso8601String();
    map["ownerId"] = ownerId;
    map["lat"] = lat;
    map["lng"] = lng;
    return map;
  }
}
