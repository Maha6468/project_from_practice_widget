
class OffersHistoryModel {
  Result? result;
  int? statusCode;

  OffersHistoryModel({this.result, this.statusCode});

  OffersHistoryModel.fromJson(Map<String, dynamic> json) {
    result = json["result"] == null ? null : Result.fromJson(json["result"]);
    statusCode = json["statusCode"];
  }

  static List<OffersHistoryModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OffersHistoryModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(result != null) {
      _data["result"] = result?.toJson();
    }
    _data["statusCode"] = statusCode;
    return _data;
  }
}

class Result {
  List<Content>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort1? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  Result({this.content, this.pageable, this.last, this.totalPages, this.totalElements, this.size, this.number, this.sort, this.first, this.numberOfElements, this.empty});

  Result.fromJson(Map<String, dynamic> json) {
    content = json["content"] == null ? null : (json["content"] as List).map((e) => Content.fromJson(e)).toList();
    pageable = json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]);
    last = json["last"];
    totalPages = json["totalPages"];
    totalElements = json["totalElements"];
    size = json["size"];
    number = json["number"];
    sort = json["sort"] == null ? null : Sort1.fromJson(json["sort"]);
    first = json["first"];
    numberOfElements = json["numberOfElements"];
    empty = json["empty"];
  }

  static List<Result> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Result.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(content != null) {
      _data["content"] = content?.map((e) => e.toJson()).toList();
    }
    if(pageable != null) {
      _data["pageable"] = pageable?.toJson();
    }
    _data["last"] = last;
    _data["totalPages"] = totalPages;
    _data["totalElements"] = totalElements;
    _data["size"] = size;
    _data["number"] = number;
    if(sort != null) {
      _data["sort"] = sort?.toJson();
    }
    _data["first"] = first;
    _data["numberOfElements"] = numberOfElements;
    _data["empty"] = empty;
    return _data;
  }
}

class Sort1 {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort1({this.empty, this.sorted, this.unsorted});

  Sort1.fromJson(Map<String, dynamic> json) {
    empty = json["empty"];
    sorted = json["sorted"];
    unsorted = json["unsorted"];
  }

  static List<Sort1> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Sort1.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["empty"] = empty;
    _data["sorted"] = sorted;
    _data["unsorted"] = unsorted;
    return _data;
  }
}

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable({this.pageNumber, this.pageSize, this.sort, this.offset, this.paged, this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json["pageNumber"];
    pageSize = json["pageSize"];
    sort = json["sort"] == null ? null : Sort.fromJson(json["sort"]);
    offset = json["offset"];
    paged = json["paged"];
    unpaged = json["unpaged"];
  }

  static List<Pageable> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Pageable.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pageNumber"] = pageNumber;
    _data["pageSize"] = pageSize;
    if(sort != null) {
      _data["sort"] = sort?.toJson();
    }
    _data["offset"] = offset;
    _data["paged"] = paged;
    _data["unpaged"] = unpaged;
    return _data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json["empty"];
    sorted = json["sorted"];
    unsorted = json["unsorted"];
  }

  static List<Sort> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Sort.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["empty"] = empty;
    _data["sorted"] = sorted;
    _data["unsorted"] = unsorted;
    return _data;
  }
}

class Content {
  String? id;
  String? userId;
  double? token;
  String? type;
  String? description;
  int? createdAt;

  Content({this.id, this.userId, this.token, this.type, this.description, this.createdAt});

  Content.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    token = json["token"];
    type = json["type"];
    description = json["description"];
    createdAt = json["createdAt"];
  }

  static List<Content> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Content.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["userId"] = userId;
    _data["token"] = token;
    _data["type"] = type;
    _data["description"] = description;
    _data["createdAt"] = createdAt;
    return _data;
  }
}