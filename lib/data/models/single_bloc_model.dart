class SingleBlocModel {
  int id;
  String name;
  String roomNumber;
  String objectsId;

  SingleBlocModel({
    required this.id,
    required this.name,
    required this.roomNumber,
    required this.objectsId,
  });

  factory SingleBlocModel.fromJson(Map<String, dynamic> json) => SingleBlocModel(
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
