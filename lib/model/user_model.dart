class Data {
  Data({
    required this.result,
    required this.queryParam,
    required this.code,
    required this.message,
  });

  final List<Result> result;
  final QueryParam? queryParam;
  final int? code;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      queryParam: json["queryParam"] == null ? null : QueryParam.fromJson(json["queryParam"]),
      code: json["code"],
      message: json["message"],
    );
  }

}

class QueryParam {
  QueryParam({
    required this.category,
    required this.language,
    required this.genre,
    required this.sort,
  });

  final String? category;
  final String? language;
  final String? genre;
  final String? sort;

  factory QueryParam.fromJson(Map<String, dynamic> json){
    return QueryParam(
      category: json["category"],
      language: json["language"],
      genre: json["genre"],
      sort: json["sort"],
    );
  }

}

class Result {
  Result({
    required this.id,
    required this.director,
    required this.writers,
    required this.stars,
    required this.releasedDate,
    required this.productionCompany,
    required this.title,
    required this.language,
    required this.runTime,
    required this.genre,
    required this.voted,
    required this.poster,
    required this.pageViews,
    required this.description,
    required this.upVoted,
    required this.downVoted,
    required this.totalVoted,
    required this.voting,
  });

  final String? id;
  final List<String> director;
  final List<String> writers;
  final List<String> stars;
  final int? releasedDate;
  final List<String> productionCompany;
  final String? title;
  final String? language;
  final int? runTime;
  final String? genre;
  final List<Voted> voted;
  final String? poster;
  final int? pageViews;
  final String? description;
  final List<String> upVoted;
  final List<String> downVoted;
  final int? totalVoted;
  final int? voting;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      id: json["_id"],
      director: json["director"] == null ? [] : List<String>.from(json["director"]!.map((x) => x)),
      writers: json["writers"] == null ? [] : List<String>.from(json["writers"]!.map((x) => x)),
      stars: json["stars"] == null ? [] : List<String>.from(json["stars"]!.map((x) => x)),
      releasedDate: json["releasedDate"],
      productionCompany: json["productionCompany"] == null ? [] : List<String>.from(json["productionCompany"]!.map((x) => x)),
      title: json["title"],
      language: json["language"],
      runTime: json["runTime"],
      genre: json["genre"],
      voted: json["voted"] == null ? [] : List<Voted>.from(json["voted"]!.map((x) => Voted.fromJson(x))),
      poster: json["poster"],
      pageViews: json["pageViews"],
      description: json["description"],
      upVoted: json["upVoted"] == null ? [] : List<String>.from(json["upVoted"]!.map((x) => x)),
      downVoted: json["downVoted"] == null ? [] : List<String>.from(json["downVoted"]!.map((x) => x)),
      totalVoted: json["totalVoted"],
      voting: json["voting"],
    );
  }

}

class Voted {
  Voted({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.updatedAt,
    required this.genre,
  });

  final List<String> upVoted;
  final List<dynamic> downVoted;
  final String? id;
  final int? updatedAt;
  final String? genre;

  factory Voted.fromJson(Map<String, dynamic> json){
    return Voted(
      upVoted: json["upVoted"] == null ? [] : List<String>.from(json["upVoted"]!.map((x) => x)),
      downVoted: json["downVoted"] == null ? [] : List<dynamic>.from(json["downVoted"]!.map((x) => x)),
      id: json["_id"],
      updatedAt: json["updatedAt"],
      genre: json["genre"],
    );
  }

}
