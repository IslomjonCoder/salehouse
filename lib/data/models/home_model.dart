

class HomeModel {
  int currentPage;
  List<HomeModelUser> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  HomeModel({
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

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    currentPage: json["current_page"],
    data: List<HomeModelUser>.from(json["data"].map((x) => HomeModelUser.fromJson(x))),
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

class HomeModelUser {
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
  String? planId;
  String isvalute;

  HomeModelUser({
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

  factory HomeModelUser.fromJson(Map<String, dynamic> json) => HomeModelUser(
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
