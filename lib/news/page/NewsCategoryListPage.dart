import 'package:flutter/material.dart';
import 'package:news_fluttter/news/page/NewsListPage.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/BaseReponse.dart';
import 'package:news_fluttter/news/model/SubCategory.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';

class NewsCategoryListPage extends StatefulWidget {
  final String enName;

  NewsCategoryListPage({Key key, this.enName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsCategoryListPageState();
}

class _NewsCategoryListPageState extends State<NewsCategoryListPage> {
  List<SubCategory> _list = List();

  @override
  void initState() {
    super.initState();
    _getSubCategory(widget.enName);
  }

  void _getSubCategory(String enName) {
    Future subRes = NetUtils.get(Api.SUB_CATEGORY_URL + "$enName");
    subRes.then((dynamic source) {
      var baseResponse = BaseResponse.fromJson(source);
      return SubCategory.parseJson(baseResponse.results);
    }).then((data) {
      print("data = $data");
      setState(() {
        _list = data;
      });
    });
  }

  void _handleItemClick(SubCategory category) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return NewsListPage(title: category.title, categoryId: category.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              SubCategory category = _list[index];
              return ListTile(
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(category.icon),
                  ),
                ),
                title: Text(category.title),
                onTap: () => _handleItemClick(category),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            },
            itemCount: _list.length,
          );
  }
}
