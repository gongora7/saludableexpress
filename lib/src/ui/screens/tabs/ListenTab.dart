import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config.dart';
import '../player.dart';

class ListenTab extends StatefulWidget {
  @override
  _ListenTabState createState() => _ListenTabState();
}

class _ListenTabState extends State<ListenTab> {
  List<DocumentSnapshot> uploads;
  bool _isLoading = true;
  int limit = 50;

  DocumentSnapshot lastSnapshot;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchUploads();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print("loading more uploads");
          loadMoreUpload();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> fetchUploads() async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("uploads")
          .orderBy("date", descending: true)
          .limit(limit)
          .get();

      lastSnapshot = querySnapshot.docs.last;

      setState(() {
        uploads = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }

    return true;
  }

  Future<bool> loadMoreUpload() async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("uploads")
          .startAfterDocument(lastSnapshot)
          .orderBy("date", descending: true)
          .limit(limit)
          .get();

      lastSnapshot = querySnapshot.docs.last;

      setState(() {
        uploads.addAll(querySnapshot.docs);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: SpinKitChasingDots(
          color: primaryColor,
          size: 50,
        ),
      );
    } else {
      if (uploads != null) {
        return RefreshIndicator(
          onRefresh: () async {
            await fetchUploads();
            return null;
          },
          child: GridView.count(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: uploads.map((item) {
              Map<String, dynamic> data = item.data() as Map<String, dynamic>;

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(
                          item: item,
                        ),
                      ));
                },
                child: Container(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: item.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: CachedNetworkImage(
                                imageUrl: data["coverArt"],
                                placeholder: (context, url) => Image(
                                  image: AssetImage(
                                      "assets/images/placeholder.png"),
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/nothing.png"),
              ),
              Text("Nada por aquí....aún"),
            ],
          ),
        );
      }
    }
  }
}
