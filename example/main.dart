import 'package:flutter/material.dart';
import 'package:novel_reading/novel_reading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovelReadingExample extends StatelessWidget {
  const NovelReadingExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NovelReading(
        theme: NovelReadingType.green, // use provided theme [white(default), black, green, pink]
        start: 5, // readding novel starts from chapter 5
        cache: 10, // cache 10 chapters
        // color: , // setting background color
        // textStyle: , // setting text style
        builder: (page) async {
            return await http.get('example.com?page=$page');
        },
    );
  }
}