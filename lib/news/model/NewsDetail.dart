class NewsDetail {
  final String id;
  final String content;
  final String cover;
  final String url;
  final String title;

  NewsDetail({this.id, this.content, this.cover, this.url, this.title});

  factory NewsDetail.fromJson(Map<String, dynamic> json) {
    return NewsDetail(
        id: json['_id'],
        content: json['content'],
        cover: json['cover'],
        url: json['url'],
        title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'cover': cover,
      'url': url,
      'title': title
    };
  }

  static List<NewsDetail> parseJson(List json) {
    return json.map((j) {
      return NewsDetail.fromJson(j);
    }).toList();
  }
}
