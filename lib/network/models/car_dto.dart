import 'package:flutter/cupertino.dart';

class CarDto {
  String? _id;
  String? brand;
  String? model;
  Color? color;
  String? registration;
  DateTime? year;
  String? ownerId;
  num? lat;
  num? lng;

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
    _id = json["_id"].toString();
    brand = json["brand"].toString();
    model = json["model"].toString();
    color =
        Color(int.parse("0xFF" + json["color"].toString().replaceAll("#", "")));
    registration = json["registration"].toString();
    year = DateTime.tryParse(json["year"]);
    ownerId = json["ownerId"].toString();
    lat = num.tryParse(json["lat"].toString());
    lng = num.tryParse(json["lng"].toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["brand"] = brand;
    map["model"] = model;
    map["color"] = '#${color?.value.toRadixString(16).substring(2)}';
    map["registration"] = registration;
    map["year"] = year?.toIso8601String();
    map["ownerId"] = ownerId;
    map["lat"] = lat?.toStringAsFixed(4);
    map["lng"] = lng?.toStringAsFixed(4);
    return map;
  }
}
