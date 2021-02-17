import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/refresh.dart';
import '../resources/repository.dart';
import '../blocs/story_bloc.dart';
import '../blocs/story_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget{

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: news(bloc),
    );
  }

  Widget news(StoriesBloc bloc) {

    return StreamBuilder(
      //Static in Nature
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);

              return NewsListTiles(itemId: snapshot.data[index]);
            },
          ),
        );

      },
    );
  }

}