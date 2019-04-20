class SubCategory {
  final String _id;
  final String created_at;
  final String icon;
  final String id;
  final String title;

  SubCategory(this._id, this.created_at, this.icon, this.id, this.title);

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(json['_id'], json['created_at'], json['icon'],
        json['id'], json['title']);
  }

  static List<SubCategory> parseJson(List list) {
    return list.map((i) {
      return SubCategory.fromJson(i);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'created_at': created_at,
      'icon': icon,
      'id': id,
      'title': title
    };
  }
}
