import 'package:ev_studios_task/model/articles-model.dart';

import 'api-provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<ArticlesModel>?> fetchArticlesList() {
    return _provider.fetchArticlesList();
  }
}

class NetworkError extends Error {}
