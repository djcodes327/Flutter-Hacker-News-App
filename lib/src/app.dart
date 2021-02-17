import 'package:flutter/material.dart';
import 'package:news/src/blocs/story_provider.dart';
import '../src/screens/news_list.dart';
import '../src/blocs/story_bloc.dart';

class MyApp extends StatelessWidget{
  Widget build(context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'News App',
        home: NewsList(),
      ),
    );
  }
}