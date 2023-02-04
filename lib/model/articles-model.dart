class ArticlesModel {
  Name? name;
  Images? images;
  String? gender;
  String? species;
  String? homePlanet;
  String? occupation;
  List<String>? sayings;
  int? id;
  String? age;

  ArticlesModel(
      {this.name,
      this.images,
      this.gender,
      this.species,
      this.homePlanet,
      this.occupation,
      this.sayings,
      this.id,
      this.age});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] == null ? null : Name.fromJson(json["name"]);
    images = json["images"] == null ? null : Images.fromJson(json["images"]);
    gender = json["gender"];
    species = json["species"];
    homePlanet = json["homePlanet"];
    occupation = json["occupation"];
    sayings =
        json["sayings"] == null ? null : List<String>.from(json["sayings"]);
    id = json["id"];
    age = json["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (name != null) {
      _data["name"] = name?.toJson();
    }
    if (images != null) {
      _data["images"] = images?.toJson();
    }
    _data["gender"] = gender;
    _data["species"] = species;
    _data["homePlanet"] = homePlanet;
    _data["occupation"] = occupation;
    if (sayings != null) {
      _data["sayings"] = sayings;
    }
    _data["id"] = id;
    _data["age"] = age;
    return _data;
  }
}

class Images {
  String? headShot;
  String? main;

  Images({this.headShot, this.main});

  Images.fromJson(Map<String, dynamic> json) {
    headShot = json["head-shot"];
    main = json["main"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["head-shot"] = headShot;
    _data["main"] = main;
    return _data;
  }
}

class Name {
  String? first;
  String? middle;
  String? last;

  Name({this.first, this.middle, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json["first"];
    middle = json["middle"];
    last = json["last"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first"] = first;
    _data["middle"] = middle;
    _data["last"] = last;
    return _data;
  }
}
