import 'package:flutter/material.dart';
import 'package:planethero_application/models/bookmark.dart';

class AllBookmarks with ChangeNotifier {
  //Populate a list of bookmarks
  List<Bookmark> allBookmarks = [
    Bookmark(
      'Tester',
      'https://s.wsj.net/public/resources/images/WK-AN111_BAGS_j_O_20080924123035.jpg',
      'Bring Recycle Bags',
      5,
    ),
    Bookmark(
      'Tester',
      'https://images.ctfassets.net/z3ixs6i8tjtq/1RK1N83Bd246C6q68gicUO/f970cf756bb0a3786a87b922f368762f/clothes-line-615962_640.jpg?q=90&fl=progressive&w=961&fit=fill',
      'Air-Dry Clothes After Washing',
      10,
    ),
    Bookmark(
      'Tester',
      'https://images.pexels.com/photos/5970279/pexels-photo-5970279.jpeg?cs=srgb&dl=pexels-alexandre-saraiva-carniato-5970279.jpg&fm=jpg',
      'Cycle Instead of Taking Cars',
      100,
    )
  ];

  //function to get all bookmarks
  List<Bookmark> getBookmarks() {
    return allBookmarks;
  }

  //function to add bookmarks
  void addBookmark(username, imageUrl, actionTitle, heroPoints) {
    allBookmarks.insert(
        0, Bookmark(username, imageUrl, actionTitle, heroPoints));

    notifyListeners();
  }

  //function to remove bookmark
  void removeBookmark(Bookmark bookmark) {
    allBookmarks.remove(bookmark);
    notifyListeners();
  }
}
