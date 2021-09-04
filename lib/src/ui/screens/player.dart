import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';

class PlayerScreen extends StatefulWidget {
  final DocumentSnapshot item;

  PlayerScreen({this.item});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isPlaying = false;

  String _songTotalMinutes = "00:00";
  String _songPlayed = "00:00";

  Duration totalTimeInDuration = Duration();
  Duration playedTimeInDuration = Duration();

  AudioPlayer audioPlayer = AudioPlayer();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    play();
  }

  @override
  void dispose() {
    audioPlayer.release();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  play() async {
    Map<String, dynamic> data = widget.item.data() as Map<String, dynamic>;
    int result = await audioPlayer.play(data["audioFile"], stayAwake: true);

    if (result == 1) {
      audioPlayer.onDurationChanged.listen((Duration d) {
        setState(() {
          _songTotalMinutes = formatDuration(d);
          totalTimeInDuration = d;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((Duration p) {
        setState(() {
          _songPlayed = formatDuration(p);
          playedTimeInDuration = p;
        });
      });

      setState(() {
        _isPlaying = true;
      });
    }
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  skip10s() async {
    Duration d;
    if (playedTimeInDuration.inSeconds + 10 > totalTimeInDuration.inSeconds) {
      d = Duration(seconds: totalTimeInDuration.inSeconds);
    } else {
      d = Duration(seconds: playedTimeInDuration.inSeconds + 10);
    }

    await audioPlayer.seek(d);
  }

  prev10s() async {
    Duration d;
    if (playedTimeInDuration.inSeconds - 10 <= 0) {
      d = Duration(seconds: 0);
    } else {
      d = Duration(seconds: playedTimeInDuration.inSeconds - 10);
    }
    await audioPlayer.seek(d);
  }

  seek(int seconds) async {
    await audioPlayer.seek(Duration(seconds: seconds));
  }

  void showAlert(context, title, subTitle) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: subTitle,
      borderRadius: 100,
    );
  }

  void addToFavorite() async {
    //User user = auth.currentUser;

    //String uid = user.uid;
    Map<String, dynamic> data = widget.item.data() as Map<String, dynamic>;

    firestore
        .collection("favorites")
        // .doc(uid)
        //.collection("favorites")
        .doc(widget.item.id)
        .set(data)
        .then((val) {
      showAlert(context, "Favorite", "Added to your list 👩🏻‍💻");
    });
  }

  void showUploadDetails(context) {
    Map<String, dynamic> data = widget.item.data() as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => primaryColor)),
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("CLOSE"),
            ),
          ],
          title: Text(data["title"]),
          content: SingleChildScrollView(
            child: Container(
              child: Text(
                data["description"],
                softWrap: true,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = widget.item.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(data["title"]),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(-10, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onSelected: (val) {
              if (val == "add_to_favorite") {
                addToFavorite();
              } else if (val == "details") {
                showUploadDetails(context);
              }
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text("Add to favorite"),
                  value: "add_to_favorite",
                ),
                PopupMenuItem(
                  child: Text("Details"),
                  value: "details",
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: widget.item.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: CachedNetworkImage(
                      width: 200,
                      height: 200,
                      imageUrl: data["coverArt"],
                      placeholder: (context, url) => Image(
                        image: AssetImage("assets/placeholder.png"),
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                data["title"],
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$_songTotalMinutes",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  addToFavorite();
                },
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "$_songPlayed",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "$_songTotalMinutes",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: playedTimeInDuration.inSeconds.toDouble(),
                onChanged: (v) {
                  seek(v.toInt());
                },
                activeColor: primaryColor,
                inactiveColor: Colors.grey[200],
                min: 0,
                max: totalTimeInDuration.inSeconds.toDouble(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.replay_10,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      prev10s();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isPlaying) {
                        pause();
                      } else {
                        resume();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.forward_10,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      skip10s();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
