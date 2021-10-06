import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

import 'pages/oldDemo.dart';
import 'pages/thumbnailDemo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(YoutubeApp());
}

///
class YoutubeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Plyr Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      home: YoutubeAppDemo(),
    );
  }
}

///
class YoutubeAppDemo extends StatefulWidget {
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  String videoID = "BgkxvVtO0JM";
  List<Map<String, dynamic>> players = [
    {
      "videoID": "AOhFzDN3eMI",
      "quality": ThumbnailQuality.max,
    },
    {
      "videoID": "LRNuWYvRtac",
      "quality": ThumbnailQuality.standard,
    },
    {
      "videoID": "ZEqba-Bg7Z0",
      "quality": ThumbnailQuality.high,
    },
  ];
  double headerSize = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text("Demo"),
      //   centerTitle: true,
      //   automaticallyImplyLeading: true,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: new Center(
              child: Column(
                // center the children
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      children: [
                        ElevatedButton(
                          child: Text("Inline Demo"),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OldDemo()),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text("Thumbnail Demo"),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThumbnailDemo()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Livestream",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  ytPlayer("5qap5aO4i9A"),
                  Divider(),
                  Text(
                    "Like on dart.dev",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.blueGrey[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Dart is a client-optimized language for fast apps on any platform",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          TextButton.icon(
                              onPressed: () => _showDialog(
                                    context,
                                    "5F-6n_2XWR8",
                                  ),
                              icon: Icon(
                                Icons.play_circle_fill_outlined,
                                size: 30,
                                color: Colors.blue,
                              ),
                              label: Text("Watch video")),
                          SizedBox(height: 20),
                          Image.network(
                            "https://dart.dev/assets/dash/2x/supported%20by%20google@2x.png",
                            width: 200,
                          ),
                          SizedBox(height: 20),
                          TextButton.icon(
                            onPressed: () => print("here url"),
                            label: Icon(
                              Icons.code,
                              size: 30,
                              color: Colors.grey,
                            ),
                            icon: Text(
                              "Dart is free and open source",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                        ],
                      )),
                  Divider(),
                  Text(
                    "Single Player",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  ytPlayer("Vcl2Rje_6w0"),
                  ytPlayer("F1B9Fk_SgI0"),
                  Divider(),
                  Text(
                    "From String",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  ytPlayer(videoID),
                  Divider(),
                  Text(
                    "List View",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  for (var i in players)
                    ytPlayer(
                      i["videoID"],
                    ),
                  Divider(),
                  Text(
                    "Row List",
                    style: TextStyle(fontSize: headerSize),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    direction: Axis.horizontal,
                    children: [
                      ytPlayer("TyimCGEkiUc"),
                      Text(
                        "Hello World",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(context, videoID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return YoutubeViewer(
          videoID,
        );
      },
    );
  }

  Widget ytPlayer(videoID) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDialog(
            context,
            videoID,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (kIsWeb && constraints.maxWidth > 800) {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 55.0,
            ),
          ],
        ),
      ),
    );
  }
}

class YoutubeViewer extends StatefulWidget {
  final String? videoID;
  YoutubeViewer(this.videoID);
  @override
  _YoutubeViewerState createState() => _YoutubeViewerState();
}

class _YoutubeViewerState extends State<YoutubeViewer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID!, // livestream example
      params: YoutubePlayerParams(
        //startAt: Duration(minutes: 1, seconds: 5),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        autoPlay: true,
        enableCaption: true,
        showVideoAnnotations: false,
        enableJavaScript: true,
        privacyEnhanced: true,
        useHybridComposition: true,
        playsInline: false,
      ),
    )..listen((value) {
        print(_controller.value.position);
        if (value.isReady && !value.hasPlayed) {
          _controller
            ..hidePauseOverlay()
            ..play()
            ..hideTopMenu();
        }
        if (value.hasPlayed) {
          _controller..hideEndScreen();
        }
      });

    _controller.onExitFullscreen = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      key: UniqueKey(),
      controller: _controller,
      child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          content: Container(height: 450, width: 750, child: player),
          contentPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
          // actions: <Widget>[
          //   new Center(
          //     child: TextButton(
          //       child: new Text("Close"),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //     ),
          //   ),
          // ],
          ),
    );
  }
}

///
/// For getting youtube player from anywhere
///

class YoutubePlayer extends StatefulWidget {
  final String videoID;
  YoutubePlayer(this.videoID);
  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDialog(
            context,
            widget.videoID,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (kIsWeb && constraints.maxWidth > 800) {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: widget.videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: widget.videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 55.0,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(context, videoID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return YoutubeViewer(
          videoID,
        );
      },
    );
  }
}
