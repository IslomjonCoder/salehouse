// To parse this JSON data, do
//
//     final contractModel = contractModelFromJson(jsonString);

import 'dart:convert';

ContractModel contractModelFromJson(String str) => ContractModel.fromJson(json.decode(str));

String contractModelToJson(ContractModel data) => json.encode(data.toJson());

class ContractModel {
  int currentPage;
  List<ContractUser> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  ContractModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
    currentPage: json["current_page"],
    data: List<ContractUser>.from(json["data"].map((x) => ContractUser.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ContractUser {
  int id;
  String name;
  String userId;
  String homeId;
  String clientId;
  String clientType;
  String square;
  String price;
  String sum;
  String left;
  String discount;
  String startPrice;
  DateTime date;
  dynamic comment;
  String status;
  String isrepaired;
  dynamic peniya;
  String isvalute;
  String valute;
  Homes homes;
  Custom custom;
  Detail detail;
  Staff staff;

  ContractUser({
    required this.id,
    required this.name,
    required this.userId,
    required this.homeId,
    required this.clientId,
    required this.clientType,
    required this.square,
    required this.price,
    required this.sum,
    required this.left,
    required this.discount,
    required this.startPrice,
    required this.date,
    required this.comment,
    required this.status,
    required this.isrepaired,
    required this.peniya,
    required this.isvalute,
    required this.valute,
    required this.homes,
    required this.custom,
    required this.detail,
    required this.staff,
  });

  factory ContractUser.fromJson(Map<String, dynamic> json) => ContractUser(
    id: json["id"],
    name: json["name"],
    userId: json["user_id"],
    homeId: json["home_id"],
    clientId: json["client_id"],
    clientType: json["client_type"],
    square: json["square"],
    price: json["price"],
    sum: json["sum"],
    left: json["left"],
    discount: json["discount"],
    startPrice: json["start_price"],
    date: DateTime.parse(json["date"]),
    comment: json["comment"],
    status: json["status"],
    isrepaired: json["isrepaired"],
    peniya: json["peniya"],
    isvalute: json["isvalute"],
    valute: json["valute"],
    homes: Homes.fromJson(json["homes"]),
    custom: Custom.fromJson(json["custom"]),
    detail: Detail.fromJson(json["detail"]),
    staff: Staff.fromJson(json["staff"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_id": userId,
    "home_id": homeId,
    "client_id": clientId,
    "client_type": clientType,
    "square": square,
    "price": price,
    "sum": sum,
    "left": left,
    "discount": discount,
    "start_price": startPrice,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "comment": comment,
    "status": status,
    "isrepaired": isrepaired,
    "peniya": peniya,
    "isvalute": isvalute,
    "valute": valute,
    "homes": homes.toJson(),
    "custom": custom.toJson(),
    "detail": detail.toJson(),
    "staff": staff.toJson(),
  };
}

class Custom {
  int id;
  String name;
  String surname;
  String middlename;
  String clientType;
  String phone;
  String? phone2;

  Custom({
    required this.id,
    required this.name,
    required this.surname,
    required this.middlename,
    required this.clientType,
    required this.phone,
    required this.phone2,
  });

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    middlename: json["middlename"],
    clientType: json["client_type"],
    phone: json["phone"],
    phone2: json["phone2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "middlename": middlename,
    "client_type": clientType,
    "phone": phone,
    "phone2": phone2,
  };
}

class Detail {
  int id;
  String passportSeries;
  DateTime issue;
  String authority;
  DateTime birthday;
  String regionId;
  String city;
  String home;
  String workPlace;
  String image;
  dynamic inn;
  dynamic mfo;
  dynamic oked;
  dynamic accountNumber;
  dynamic bankName;
  String contractId;

  Detail({
    required this.id,
    required this.passportSeries,
    required this.issue,
    required this.authority,
    required this.birthday,
    required this.regionId,
    required this.city,
    required this.home,
    required this.workPlace,
    required this.image,
    required this.inn,
    required this.mfo,
    required this.oked,
    required this.accountNumber,
    required this.bankName,
    required this.contractId,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    passportSeries: json["passport_series"],
    issue: DateTime.parse(json["issue"]),
    authority: json["authority"],
    birthday: DateTime.parse(json["birthday"]),
    regionId: json["region_id"],
    city: json["city"],
    home: json["home"],
    workPlace: json["work_place"],
    image: json["image"],
    inn: json["inn"],
    mfo: json["mfo"],
    oked: json["oked"],
    accountNumber: json["account_number"],
    bankName: json["bank_name"],
    contractId: json["contract_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "passport_series": passportSeries,
    "issue": "${issue.year.toString().padLeft(4, '0')}-${issue.month.toString().padLeft(2, '0')}-${issue.day.toString().padLeft(2, '0')}",
    "authority": authority,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "region_id": regionId,
    "city": city,
    "home": home,
    "work_place": workPlace,
    "image": image,
    "inn": inn,
    "mfo": mfo,
    "oked": oked,
    "account_number": accountNumber,
    "bank_name": bankName,
    "contract_id": contractId,
  };
}

class Homes {
  int id;
  String blockId;
  String number;
  String stage;
  String rooms;
  String square;
  String repaired;
  String norepaired;
  String start;
  String isrepaired;
  String islive;
  String status;
  dynamic image;
  String? planId;
  String isvalute;

  Homes({
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
  });

  factory Homes.fromJson(Map<String, dynamic> json) => Homes(
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
  };
}

class Staff {
  int id;
  String name;
  String login;
  String password;
  String role;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  Staff({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    id: json["id"],
    name: json["name"],
    login: json["login"],
    password: json["password"],
    role: json["role"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "login": login,
    "password": password,
    "role": role,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
