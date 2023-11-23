// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

BlockModel blockModelFromJson(String str) => BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  int id;
  String name;
  String roomNumber;
  String objectsId;
  Objects objects;

  BlockModel({
    required this.id,
    required this.name,
    required this.roomNumber,
    required this.objectsId,
    required this.objects,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
    id: json["id"],
    name: json["name"],
    roomNumber: json["room_number"],
    objectsId: json["objects_id"],
    objects: Objects.fromJson(json["objects"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "room_number": roomNumber,
    "objects_id": objectsId,
    "objects": objects.toJson(),
  };
}

class Objects {
  int id;
  String name;
  String regionId;
  String companiesId;
  String city;
  String address;
  DateTime start;
  DateTime end;
  String image;
  String stage;
  String padez;

  Objects({
    required this.id,
    required this.name,
    required this.regionId,
    required this.companiesId,
    required this.city,
    required this.address,
    required this.start,
    required this.end,
    required this.image,
    required this.stage,
    required this.padez,
  });

  factory Objects.fromJson(Map<String, dynamic> json) => Objects(
    id: json["id"],
    name: json["name"],
    regionId: json["region_id"],
    companiesId: json["companies_id"],
    city: json["city"],
    address: json["address"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    image: json["image"],
    stage: json["stage"],
    padez: json["padez"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region_id": regionId,
    "companies_id": companiesId,
    "city": city,
    "address": address,
    "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
    "image": image,
    "stage": stage,
    "padez": padez,
  };
}
