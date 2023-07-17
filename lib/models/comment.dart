import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String uid;
  String profilePic;
  String username;
  String comment;
  String action;
  DateTime timeStamp;

  Comment(this.id, this.uid, this.profilePic, this.username, this.comment,
      this.action, this.timeStamp);

  Comment.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        uid = snapshot['uid'] ?? '',
        profilePic = snapshot['profilePic'] ?? '',
        username = snapshot['username'] ?? '',
        comment = snapshot['comment'] ?? '',
        action = snapshot['action'] ?? '',
        timeStamp =
            (snapshot['timeStamp'] ?? Timestamp.now() as Timestamp).toDate();
}
