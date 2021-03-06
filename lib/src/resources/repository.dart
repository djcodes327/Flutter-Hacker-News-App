import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {

  List<Source> sources = [
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel itemModel;
    var source;

    for(source in sources) {
      itemModel = await source.fetchItem(id);
      if(itemModel != null) {
        break;
      }
    }

    for(var cache in caches) {
      if(cache != source) {
        cache.addItem(itemModel);
      }
    }

    return itemModel;
  }

}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel itemModel);
}