import 'package:flutter/material.dart';
import 'package:news_fluttter/news/widget/clipper_circle.dart';

class NewsMePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsMePageState();
}

class _NewsMePageState extends State<NewsMePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {})
            ],
            pinned: false,
            expandedHeight: 200,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: _MeHeaderWidget(),
          ),
          _MeListWidget()
        ],
      ),
    );
  }
}

class _MeHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipperCircle(),
      child: Container(
        color: Theme.of(context).primaryColor.withAlpha(200),
        padding: EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Hero(
                    tag: 'icon',
                    child: ClipOval(
                      child: Image.asset(
                        'assets/app_icon.png',
                        width: 60,
                        height: 60,
                      ),
                    )),
              ),
              SizedBox(height: 20),
              Text(
                'User Name',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: SliverList(
        delegate: SliverChildListDelegate([
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.brightness_2),
            title: Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (status) {}),
            onTap: () {},
          ),
          _ThemeListWidget(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}

class _ThemeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.color_lens),
      title: Text('Theme'),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: Colors.primaries.map((color) {
              return Material(
                color: color,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
