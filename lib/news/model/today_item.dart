//  "_id": "5c0622429d2122308e7445cf",
//  "createdAt": "2018-12-04T06:44:18.364Z",
//  "desc": "一个基于ijkplayer的完整视频播放器封装，支持自定义，拓展性强，已经用于实际开发中",
//  "images": [
//  "https://ww1.sinaimg.cn/large/0073sXn7ly1g1p96mf7zlj308c0pfjtm",
//  "https://ww1.sinaimg.cn/large/0073sXn7ly1g1p96mlxyxj308c0go748",
//  "https://ww1.sinaimg.cn/large/0073sXn7ly1g1p96mw2gaj30k30bv406",
//  "https://ww1.sinaimg.cn/large/0073sXn7ly1g1p96n3bp6j308c0et0tm",
//  "https://ww1.sinaimg.cn/large/0073sXn7ly1g1p96n9715j308c0goq3f"
//  ],
//  "publishedAt": "2019-04-10T00:00:00.0Z",
//  "source": "web",
//  "type": "Android",
//  "url": "https://github.com/yangchong211/YCVideoPlayer",
//  "used": true,
//  "who": "fingdo"
class TodayItem {
  final String id;
  final String createdAt;
  final String desc;
  final List<String> images;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;

  TodayItem(
      {this.id,
      this.createdAt,
      this.desc,
      this.images,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who});

  factory TodayItem.fromJson(Map<String, dynamic> json) {
    return TodayItem(
        id: json['_id'],
        createdAt: json['createdAt'],
        desc: json['desc'],
        images: json['images'] == null
            ? null
            : (json['images'] as List).map((i) {
                return i as String;
              }).toList(),
        publishedAt: json['publishedAt'],
        source: json['source'],
        type: json['type'],
        url: json['url'],
        used: json['used'],
        who: json['who']);
  }

  @override
  String toString() {
    return 'TodayItem{id: $id, createdAt: $createdAt, desc: $desc, images: $images, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }
}
