import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  //declare variables
  String bid;
  String uid;
  String imageUrl;
  String actionTitle;
  int heroPoints;

  Bookmark(
    this.bid,
    this.uid,
    this.imageUrl,
    this.actionTitle,
    this.heroPoints,
  );

  Bookmark.fromMap(Map<String, dynamic> snapshot, String id) : 
  bid = id,
  uid = snapshot['uid'] ?? '',
  imageUrl = snapshot['imageUrl'] ?? '',
  actionTitle = snapshot['actionTitle'] ?? '',
  heroPoints = snapshot['heroPoints'] ?? 0;
}
