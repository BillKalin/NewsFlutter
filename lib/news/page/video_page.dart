import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<void> _completer = Completer<void>();
  static const String videoController =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  final VideoPlayerController beeController =
      VideoPlayerController.network(videoController);

  @override
  void initState() {
    Future<void> initController(
        VideoPlayerController controller, String name) async {
      controller.setLooping(true);
      controller.setVolume(0.0);
      controller.play();
      await _completer.future;
      await controller.initialize();
      if (mounted) {
        setState(() {});
      }
    }

    initController(beeController, "play");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: _ConnectivityOverlay(
        scaffoldKey: scaffoldKey,
        child: Scrollbar(
            child: ListView(
          children: <Widget>[
            _VideoCard(
              title: 'Bee',
              subTitle: '… gently buzzing',
              controller: beeController,
            ),
          ],
        )),
        connectedCompleter: _completer,
      ),
    );
  }

  @override
  void dispose() {
    beeController.dispose();
    super.dispose();
  }
}

class _ConnectivityOverlay extends StatefulWidget {
  const _ConnectivityOverlay(
      {this.scaffoldKey, this.connectedCompleter, this.child});

  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Completer<void> connectedCompleter;

  @override
  State<StatefulWidget> createState() => _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends State<_ConnectivityOverlay> {
  StreamSubscription<ConnectivityResult> _streamSubscription;

  Stream<ConnectivityResult> _connectivityStream() async* {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult preResult = await connectivity.checkConnectivity();
    yield preResult;
    await for (ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      if (result != preResult) {
        yield result;
        preResult = result;
      }
    }
  }

  static const Widget errorSnackBar = SnackBar(
    backgroundColor: Colors.red,
    content: ListTile(
      title: Text('no network'),
      subtitle: Text(
        'To load the videos you must have an active network connection',
      ),
    ),
  );

  @override
  void initState() {
    _streamSubscription =
        _connectivityStream().listen((ConnectivityResult result) {
      if (!mounted) return;
      if (result == ConnectivityResult.none) {
        widget.scaffoldKey.currentState.showSnackBar(errorSnackBar);
      } else {
        widget.connectedCompleter.complete(null);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}

class _VideoCard extends StatelessWidget {
  final VideoPlayerController controller;
  final String title;
  final String subTitle;

  const _VideoCard({Key key, this.title, this.subTitle, this.controller})
      : super(key: key);

  Widget _buildInlineVideo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Center(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Hero(
              tag: controller,
              child: _VideoPlayerLoading(
                controller: controller,
              )),
        ),
      ),
    );
  }

  Widget _buildFullScreenVideo() {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Hero(
              tag: controller,
              child: _VideoPause(
                controller: controller,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget fullScreenPageBuilder(BuildContext context,
        Animation<double> animation, Animation<double> secondaryAnimation) {
      return _buildFullScreenVideo();
    }

    void showFullScreenPlayer() {
      final TransitionRoute<void> route = PageRouteBuilder<void>(
          settings: RouteSettings(name: title, isInitialRoute: false),
          pageBuilder: fullScreenPageBuilder);

      route.completed.then((void data) {
        controller.setVolume(0.0);
      });

      controller.setVolume(1.0);
      Navigator.of(context).push(route);
    }

    return SafeArea(
        top: false,
        bottom: false,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(title),
                subtitle: Text(subTitle),
              ),
              GestureDetector(
                onTap: showFullScreenPlayer,
                child: _buildInlineVideo(),
              )
            ],
          ),
        ));
  }
}

class _VideoPlayerLoading extends StatefulWidget {
  final VideoPlayerController controller;

  const _VideoPlayerLoading({Key key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPlayerLoadingState();
}

class _VideoPlayerLoadingState extends State<_VideoPlayerLoading> {
  bool _initialized = false;

  @override
  void initState() {
    _initialized = widget.controller.value.initialized;
    widget.controller.addListener(() {
      if (!mounted) return;
      final bool curr = widget.controller.value.initialized;
      if (curr != _initialized) {
        setState(() {
          _initialized = curr;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return VideoPlayer(widget.controller);
    }
    return Stack(
      children: <Widget>[
        VideoPlayer(widget.controller),
        Center(child: CircularProgressIndicator())
      ],
      fit: StackFit.expand,
    );
  }
}

class _VideoPause extends StatefulWidget {
  final VideoPlayerController controller;

  _VideoPause({Key key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPauseState();
}

class _VideoPauseState extends State<_VideoPause> {
  VoidCallback listener;

  _VideoPauseState() {
    listener = () {
      if (!mounted) return;
      setState(() {});
    };
  }

  VideoPlayerController get controller => widget.controller;
  _FadeAnimation _fadeAnimation;

  @override
  void initState() {
    controller.addListener(listener);
    super.initState();
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          child: _VideoPlayerLoading(
            controller: controller,
          ),
          onTap: () {
            if (!controller.value.initialized) return;
            if (controller.value.isPlaying) {
              _fadeAnimation = _FadeAnimation(
                child: Icon(
                  Icons.pause,
                  size: 100,
                ),
              );
              controller.pause();
            } else {
              _fadeAnimation = _FadeAnimation(
                child: Icon(
                  Icons.play_arrow,
                  size: 100,
                ),
              );
              controller.play();
            }
          },
        ),
        Center(
          child: _fadeAnimation,
        )
      ],
    );
  }
}

class _FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  _FadeAnimation(
      {Key key, this.child, this.duration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<_FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _controller.forward(from: 0.0);
    super.initState();
  }

  @override
  void deactivate() {
    _controller.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.isAnimating
        ? Opacity(
            opacity: 1.0 - _controller.value,
            child: widget.child,
          )
        : Container();
  }
}
