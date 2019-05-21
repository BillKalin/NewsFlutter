import 'package:flutter/material.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/today_data.dart';
import 'package:news_fluttter/news/model/today_item.dart';
import 'package:news_fluttter/news/network/net_utils.dart';
import 'package:news_fluttter/news/page/news_search_page.dart';
import 'package:news_fluttter/news/page/web_view_page.dart';
import 'package:news_fluttter/news/widget/SearchWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List<TodayItem> _list = [];

  @override
  void initState() {
    super.initState();
    _fetchTodayData();
  }

  Future<void> _fetchTodayData() async {
    var data = await NetUtils.get(Api.TODAY_DATA).then((dynamic) {
      return TodayData.fromJson(dynamic);
    });
//        .then((data) {
    print("size = ${data.results.length} & data = $data ");
    setState(() {
      if (data.error || data.results.isEmpty) {
        _list = [];
      } else {
        _list = data.results;
      }
    });
  }

  void _handleItemClick(TodayItem item) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return NewsDetailPage(
        title: item.desc,
        url: item.url,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: SearchWidget(
                hindText: "input search keywords",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return NewsSearchPage();
                  }));
                },
                onSubmitted: (String text) {},
              )),
            ],
          ),
        ),
        Expanded(
          child: _list.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        TodayItem item = _list[index];
                        if ("休息视频" == item.type) {
//                      return VideoPlayer(
//                          VideoPlayerController.network(item.url));
                        } else if (item.images != null &&
                            item.images.isNotEmpty) {
                          var imageChildren = List<Widget>();
                          if (item.images.length > 1) {
                            if (item.images.length < 3) {
                              imageChildren = [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                          imageUrl: item.images[0],
                                          fit: BoxFit.cover,
                                          height: 100,
                                          placeholder: (BuildContext context,
                                              String url) {
                                            return Container(
                                                height: 100,
                                                child: Center(
                                                  child: SizedBox(
                                                    child:
                                                        CircularProgressIndicator(strokeWidth: 2,),
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ));
                                          },
                                          errorWidget: (BuildContext context,
                                              String url, Object error) {
                                            return Icon(Icons.error);
                                          }),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ];
                            } else {
                              imageChildren = item.images.map((url) {
                                return Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                        imageUrl: url,
                                        fit: BoxFit.contain,
                                        height: 100,
                                        placeholder:
                                            (BuildContext context, String url) {
                                          return Container(
                                              height: 100,
                                              child: Center(
                                                child: SizedBox(
                                                  child:
                                                      CircularProgressIndicator(strokeWidth: 2,),
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ));
                                        },
                                        errorWidget: (BuildContext context,
                                            String url, Object error) {
                                          return Icon(Icons.error);
                                        }),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ));
                              }).toList();
                            }
                            return InkWell(
                                onTap: () {
                                  _handleItemClick(item);
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                item.desc,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: imageChildren,
                                        ),
                                      ],
                                    )));
                          }

                          return InkWell(
                            onTap: () {
                              _handleItemClick(item);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.desc,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                          ),
                                          Text(
                                            item.who,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          )
                                        ],
                                      ),
                                      flex: 1,
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: CachedNetworkImage(
                                              imageUrl: item.images[0],
                                              fit: BoxFit.contain,
                                              height: 50,
                                              width: 50,
                                              placeholder:
                                                  (BuildContext context,
                                                      String url) {
                                                return Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: Center(
                                                      child: SizedBox(
                                                        child:
                                                            CircularProgressIndicator(strokeWidth: 2,),
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    ));
                                              },
                                              errorWidget:
                                                  (BuildContext context,
                                                      String url,
                                                      Object error) {
                                                return Icon(Icons.error);
                                              }),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          );
                        }
                        return ListTile(
                          title: Text(item.desc),
                          subtitle: Row(
                            children: <Widget>[
                              Text(item.who),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                  item.type,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            _handleItemClick(item);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                      itemCount: _list.length),
                  onRefresh: _fetchTodayData),
        ),
      ],
    ));
  }
}
