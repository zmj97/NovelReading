# novel_reading
![pub](https://img.shields.io/pub/v/novel_reading)
一个支持上拉加载更多和缓存的小说阅读Flutter插件。
A Flutter novel reading package supports pull-up loading more and caching.

<img src="https://github.com/zmj97/NovelReading/raw/master/novel_reading.gif" alt="novel_reading" width="400" />	

## How to Use

```dart
NovelReading(
    theme: NovelReadingType.green, // use provided theme [white(default), black, green, pink]
    start: 5, // readding novel starts from chapter 5
    cache: 10, // cache 10 chapters
    color: , // setting background color
    textStyle: , // setting text style
    builder: (page) async {
        return await http.get('example.com?page=$page');
    },
)

```

---
This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
