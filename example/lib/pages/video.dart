import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meedu_player/meedu_player.dart';

final videos = [
  'http://clips.vorwaerts-gmbh.de/VfE_html5.mp4',
  'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8',

];

class VideoPageDemo extends StatefulWidget {
  VideoPageDemo({Key key}) : super(key: key);

  @override
  _VideoPageDemoState createState() => _VideoPageDemoState();
}

class _VideoPageDemoState extends State<VideoPageDemo>
    with MeeduPlayerEventsMixin {
  final MeeduPlayerController _controller =
      MeeduPlayerController(backgroundColor: Colors.black);

  @override
  void initState() {
    super.initState();
    this._set(videos[0]);
    this._controller.events = this;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _set(String source) async {
    await _controller.setDataSource(
      dataSource: DataSource(
        dataSource: source,
        type: DataSourceType.network,
      ),
      autoPlay: true,
      aspectRatio: 16 / 9,
      header: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          source,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MeeduPlayer(
              controller: _controller,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      this._set(videos[index]);
                    },
                    title: Text("View video ${index + 1}"),
                  );
                },
                itemCount: videos.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onPlayerError(PlatformException e) {}

  @override
  void onPlayerFinished() {
    this._set(videos[1]);
  }

  @override
  void onPlayerFullScreen(bool isFullScreen) {}

  @override
  void onPlayerLoaded(Duration duration) {}

  @override
  void onPlayerLoading() {}

  @override
  void onPlayerPaused(Duration position) {}

  @override
  void onPlayerPlaying() {}

  @override
  void onPlayerRepeat() {}

  @override
  void onPlayerResumed() {}

  @override
  void onPlayerSeekTo(Duration position) {}

  @override
  void onPlayerPosition(Duration position) {}

  @override
  void onLauchAsFullScreenStopped() {}
}
