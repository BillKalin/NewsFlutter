import 'package:news_fluttter/news/model/today_item.dart';

class TodayData {
  final bool error;
  final List<TodayItem> results;
  final List<String> category;

  TodayData({this.error, this.results, this.category});

  factory TodayData.fromJson(Map<String, dynamic> json) {
    bool isError = json['error'];
    List<String> category;
    List<TodayItem> finalResults = [];
    if (!isError) {
      category = (json['category'] as List).map((i) {
        return i as String;
      }).toList();
      Map<String, dynamic> results = json['results'] as Map;
      print("itemList = $results");
      category.forEach((item) {
        List<Map<String, dynamic>> itemList = (results[item] as List).map((i) {
          return i as Map<String, dynamic>;
        }).toList();
        itemList.forEach((data) {
          finalResults.add(TodayItem.fromJson(data));
        });
      });
    }
    return TodayData(error: isError, category: category, results: finalResults);
  }

  @override
  String toString() {
    return 'TodayData{error: $error, results: $results, category: $category}';
  }
}
