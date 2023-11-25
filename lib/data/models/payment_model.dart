class PaymentModel {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  PaymentModel({
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

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      currentPage: json["current_page"],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  }
}

class Datum {
  int id;
  String contractId;
  String userId;
  String date;
  String sum;
  String typeId;
  String isvalute;
  String valute;
  Contract contract;
  Types types;

  Datum({
    required this.id,
    required this.contractId,
    required this.userId,
    required this.date,
    required this.sum,
    required this.typeId,
    required this.isvalute,
    required this.valute,
    required this.contract,
    required this.types,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        contractId: json["contract_id"],
        userId: json["user_id"],
        date: json["date"],
        sum: json["sum"],
        typeId: json["type_id"],
        isvalute: json["isvalute"],
        valute: json["valute"],
        contract: Contract.fromJson(json["contract"]),
        types: Types.fromJson(json["types"]),
      );
}

class Contract {
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
  Custom custom;

  Contract({
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
    required this.custom,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
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
        custom: Custom.fromJson(json["custom"]),
      );
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
}

class Types {
  int id;
  String name;

  Types({
    required this.id,
    required this.name,
  });

  factory Types.fromJson(Map<String, dynamic> json) => Types(
        id: json["id"],
        name: json["name"],
      );
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
}
