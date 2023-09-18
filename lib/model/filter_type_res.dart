class FilterTypeRes {
  int? count;
  String? next;
  String? previous;
  List<ResultsType>? results;

  FilterTypeRes({this.count, this.next, this.previous, this.results});

  FilterTypeRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ResultsType>[];
      json['results'].forEach((v) {
        results!.add(ResultsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsType {
  String? name;
  String? url;

  ResultsType({this.name, this.url});

  ResultsType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
