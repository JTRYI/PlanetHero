import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bookmark.dart';

class BookmarkService {
  addToBookmarks(uid, imageUrl, actionTitle, heroPoints) {
    return FirebaseFirestore.instance.collection('bookmarks').add({
      'uid': uid,
      'imageUrl': imageUrl,
      'actionTitle': actionTitle,
      'heroPoints': heroPoints,
    });
  }

  Stream<List<Bookmark>> getUserBookmarks(String uid) {
    return FirebaseFirestore.instance
        .collection('bookmarks')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Bookmark>((doc) => Bookmark.fromMap(doc.data(), doc.id))
            .toList());
  }

  removeBookmark(bid) {
    return FirebaseFirestore.instance.collection('bookmarks').doc(bid).delete();
  }
}
