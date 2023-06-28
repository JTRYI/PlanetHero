import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -
          70, //Gets size of screen and minus 70
      height: 35,
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 0.8),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10), //equal vertical padding of 10px
            hintText: 'Search Actions',
            hintStyle: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                size: 20,
              ),
              onPressed: () {},
            )),
      ),
    );
  }
}
