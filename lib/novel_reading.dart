library novel_reading;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NovelReadingTheme {
  white,
  green,
  pink,
  black
}

class NovelReading extends StatefulWidget {

  /// 从第几页开始
  /// start from which page
  final int start;

  /// 预加载页数
  /// how much pages to preload
  final int cache;

  /// 如何获取第page页的数据，返回字符串
  /// how to get a page's data, return string
  final Future<String> Function(int page) builder;

  /// 字体样式
  /// novel text font style
  final TextStyle textStyle;

  /// 背景色
  /// background color
  final Color color;

  final NovelReadingTheme theme;

  NovelReading({Key key, this.start = 0, this.cache = 5, @required this.builder, this.textStyle, this.color, this.theme = NovelReadingTheme.white}) : super(key: key);

  @override
  _NovelReadingState createState() => _NovelReadingState();
}

class _NovelReadingState extends State<NovelReading> {

  get start => widget.start;
  get cache => widget.cache;
  get builder => widget.builder;
  get textStyle => widget.textStyle;
  get color => widget.color;
  get theme => widget.theme;

  int currentPage;

  bool _showLoading = false;

  String _novel = '';

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _initNovel();

    _controller = new ScrollController()
      ..addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        currentPage += cache + 1;
        _loadMore(currentPage, cache);
      }});
  }

  void _loadMore(int from, int cache) async {
    setState(() {
      _showLoading = true;
    });
    for (int i = from; i <= from + cache; i++) {
      _novel += (await builder(i));
    }
    setState(() {
      _showLoading = false;
    });
  }
  
  void _initNovel() async {
    currentPage = start;
    _loadMore(start, cache);
  }

  TextStyle _getTextStyle() {
    if (textStyle != null) {
      return textStyle;
    }
    if (theme == NovelReadingTheme.black) {
      return TextStyle(
        color: Colors.white,
        height: 1.75
      );
    }
    // default text color is black
    return TextStyle(
      color: Colors.black,
      height: 1.75
    );
  }

  Color _getBgcolor() {
    if (color != null) {
      return color;
    }
    if (theme == NovelReadingTheme.green) {
      return Colors.green[300];
    }
    if (theme == NovelReadingTheme.pink) {
      return Colors.pink[50];
    }
    if (theme == NovelReadingTheme.black) {
      return Colors.black87;
    }
    // default background color is black
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: _getBgcolor(),
          padding: EdgeInsets.only(top: 12, left: 12, right: 12),
          child: SingleChildScrollView(
            child: Text(_novel, style: _getTextStyle(),),
            controller: _controller,
          ),
        ),
        Opacity(
          opacity: _showLoading ? 1 : 0,
          child: Center(
            child: CupertinoActivityIndicator(),
          )
        )
      ],
    );
  }
}