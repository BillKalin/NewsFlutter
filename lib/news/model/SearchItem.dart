class SearchItem {
  final String desc;
  final String ganhuId;
  final String publishedAt;
  final String readability;
  final String type;
  final String url;
  final String who;

  SearchItem(
      {this.desc,
      this.ganhuId,
      this.publishedAt,
      this.readability,
      this.type,
      this.url,
      this.who});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        desc: json['desc'],
        ganhuId: json['ganhuo_id'],
        publishedAt: json['publishedAt'],
        readability: json['readability'],
        type: json['type'],
        url: json['url'],
        who: json['who'] != null ? json['who'] : "");
  }

  static List<SearchItem> parseJson(List list) {
    return list.map((i) {
      return SearchItem.fromJson(i);
    }).toList();
  }

  @override
  String toString() {
    return 'SearchItem{desc: $desc, ganhuId: $ganhuId, publishedAt: $publishedAt, readability: $readability, type: $type, url: $url, who: $who}';
  }
}
