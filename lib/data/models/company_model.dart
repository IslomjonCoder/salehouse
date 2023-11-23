class CompanyModel {
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

  CompanyModel({
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

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
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
