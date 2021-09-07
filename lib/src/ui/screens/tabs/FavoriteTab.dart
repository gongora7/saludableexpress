import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/ui/screens/player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config.dart';

class FavoriteTab extends StatefulWidget {
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<DocumentSnapshot> uploads;
  bool _isLoading = true;
  int limit = 10;

  DocumentSnapshot lastSnapshot;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
      User user = auth.currentUser;
      String uid = user.uid;
      QuerySnapshot querySnapshot = await db
          .collection("favorites")
          .doc(uid)
          .collection("favorites")
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
      User user = auth.currentUser;
      String uid = user.uid;
      QuerySnapshot querySnapshot = await db
          .collection("favorites")
          .doc(uid)
          .collection("favorites")
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

  void showAlert(context, title, subTitle) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: subTitle,
      borderRadius: 100,
    );
  }

  void deleteFromFavorite(context, docid) async {
    try {
      User user = auth.currentUser;
      String uid = user.uid;

      db
          .collection("favorites")
          .doc(uid)
          .collection("favorites")
          .doc(docid)
          .delete()
          .then((v) {
        showAlert(context, "Completed", "Refresh to see changes");
      });
    } catch (e) {
      print(e);
    }
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
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          title: Text("Confirmation"),
                          content: Text("Do you want to delete?"),
                          actions: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => primaryColor)),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: Text("CANCEL"),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => primaryColor)),
                              onPressed: () {
                                deleteFromFavorite(context, item.id);
                                Navigator.pop(ctx);
                              },
                              child: Text("YES, DELETE IT"),
                            ),
                          ],
                        );
                      });
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
                image: AssetImage("assets/images/bgfavorites.png"),
              ),
              Text("Agrega favoritos, para ver aquí"),
            ],
          ),
        );
      }
    }
  }
}
