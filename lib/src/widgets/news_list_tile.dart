import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_tile.dart';
import '../models/item_model.dart';
import '../blocs/story_provider.dart';

class NewsListTiles extends StatelessWidget {
  final int itemId;

  NewsListTiles({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context,AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {

        if(!snapshot.hasData) {
          return LoadingTiles();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context,AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return LoadingTiles();
            }

            return buildTile(itemSnapshot.data);

          },
        );

      },
    );
  }

  Widget buildTile(ItemModel itemModel) {

    return Column(
      children:<Widget> [
        ListTile(
          title: Text(itemModel.title),
          subtitle: Text('${itemModel.score} Points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${itemModel.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

}

