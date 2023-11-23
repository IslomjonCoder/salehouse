// To parse this JSON data, do
//
//     final freeHomeModel = freeHomeModelFromJson(jsonString);

import 'dart:convert';

List<FreeHomeModel> freeHomeModelFromJson(String str) => List<FreeHomeModel>.from(json.decode(str).map((x) => FreeHomeModel.fromJson(x)));

String freeHomeModelToJson(List<FreeHomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FreeHomeModel {
  int id;
  String blockId;
  String number;
  String stage;
  String? rooms;
  String? square;
  String? repaired;
  String? norepaired;
  String? start;
  String? isrepaired;
  String? islive;
  String status;
  dynamic image;
  dynamic planId;
  String isvalute;
  Blocks blocks;

  FreeHomeModel({
    required this.id,
    required this.blockId,
    required this.number,
    required this.stage,
    required this.rooms,
    required this.square,
    required this.repaired,
    required this.norepaired,
    required this.start,
    required this.isrepaired,
    required this.islive,
    required this.status,
    required this.image,
    required this.planId,
    required this.isvalute,
    required this.blocks,
  });

  factory FreeHomeModel.fromJson(Map<String, dynamic> json) => FreeHomeModel(
    id: json["id"],
    blockId: json["block_id"],
    number: json["number"],
    stage: json["stage"],
    rooms: json["rooms"],
    square: json["square"],
    repaired: json["repaired"],
    norepaired: json["norepaired"],
    start: json["start"],
    isrepaired: json["isrepaired"],
    islive: json["islive"],
    status: json["status"],
    image: json["image"],
    planId: json["plan_id"],
    isvalute: json["isvalute"],
    blocks: Blocks.fromJson(json["blocks"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "block_id": blockId,
    "number": number,
    "stage": stage,
    "rooms": rooms,
    "square": square,
    "repaired": repaired,
    "norepaired": norepaired,
    "start": start,
    "isrepaired": isrepaired,
    "islive": islive,
    "status": status,
    "image": image,
    "plan_id": planId,
    "isvalute": isvalute,
    "blocks": blocks.toJson(),
  };
}

class Blocks {
  int id;
  String name;
  String roomNumber;
  String objectsId;

  Blocks({
    required this.id,
    required this.name,
    required this.roomNumber,
    required this.objectsId,
  });

  factory Blocks.fromJson(Map<String, dynamic> json) => Blocks(
    id: json["id"],
    name: json["name"],
    roomNumber: json["room_number"],
    objectsId: json["objects_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "room_number": roomNumber,
    "objects_id": objectsId,
  };
}
