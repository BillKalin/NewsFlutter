class Category {
  final String id;
  final String enName;
  final String name;
  final int rank;

  Category({this.id, this.enName, this.name, this.rank});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        enName: json['en_name'],
        name: json['name'],
        rank: json['rank']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'en_name': enName, 'name': name, 'rank': rank};
  }

  static List<Category> parseJson(List json) {
    return json.map((j) {
      return Category.fromJson(j);
    }).toList();
  }

  @override
  String toString() {
    return 'Category{id: $id, enName: $enName, name: $name, rank: $rank}';
  }


}
