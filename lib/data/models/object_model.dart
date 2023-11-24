
class ObjectModel {
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
  Regions regions;
  Companies companies;

  ObjectModel({
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
    required this.regions,
    required this.companies,
  });

  factory ObjectModel.fromJson(Map<String, dynamic> json) => ObjectModel(
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
    regions: Regions.fromJson(json["regions"]),
    companies: Companies.fromJson(json["companies"]),
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
    "regions": regions.toJson(),
    "companies": companies.toJson(),
  };
}

class Companies {
  int id;
  String name;
  String director;
  String phone;
  String inn;
  String mfo;
  String oked;
  String bank;
  String accountNumber;
  String regionId;
  String city;
  String address;

  Companies({
    required this.id,
    required this.name,
    required this.director,
    required this.phone,
    required this.inn,
    required this.mfo,
    required this.oked,
    required this.bank,
    required this.accountNumber,
    required this.regionId,
    required this.city,
    required this.address,
  });

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
    id: json["id"],
    name: json["name"],
    director: json["director"],
    phone: json["phone"],
    inn: json["inn"],
    mfo: json["mfo"],
    oked: json["oked"],
    bank: json["bank"],
    accountNumber: json["account_number"],
    regionId: json["region_id"],
    city: json["city"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "director": director,
    "phone": phone,
    "inn": inn,
    "mfo": mfo,
    "oked": oked,
    "bank": bank,
    "account_number": accountNumber,
    "region_id": regionId,
    "city": city,
    "address": address,
  };
}

class Regions {
  int id;
  String name;

  Regions({
    required this.id,
    required this.name,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
