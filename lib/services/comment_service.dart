import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planethero_application/models/comment.dart';

class CommentService {
  addComment(profilePic, uid, username, comment, action, timeStamp) {
    return FirebaseFirestore.instance.collection('comments').add({
      'profilePic': profilePic,
      'uid': uid,
      'username': username,
      'comment': comment,
      'action': action,
      'timeStamp': timeStamp
    });
  }

  removeComment(id) {
    return FirebaseFirestore.instance.collection('comments').doc(id).delete();
  }

  Stream<List<Comment>> getCommentsForAction(String actionTitle) {
    return FirebaseFirestore.instance.collection('comments').where('action', isEqualTo: actionTitle).snapshots().map(
        (snapshot) => snapshot.docs
            .map<Comment>((doc) => Comment.fromMap(doc.data(), doc.id))
            .toList());
  }

  editComment(id, username, comment, timeStamp) {
    return FirebaseFirestore.instance.collection('comments').doc(id).update(
        {'username': username, 'comment': comment, 'timeStamp': timeStamp});
  }
}
