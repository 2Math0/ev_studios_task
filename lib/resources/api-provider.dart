import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ev_studios_task/model/articles-model.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.sampleapis.com/futurama/characters';

  Future<List<ArticlesModel>?> fetchArticlesList() async {
    try {
      Response response = await _dio.get(_url);
      List<dynamic> data = response.data;
      List<ArticlesModel> articlesList = [];
      for (Map<String, dynamic> model in data) {
        articlesList.add(ArticlesModel.fromJson(model));
      }
      log(articlesList.toString());
      return articlesList;
    } catch (error, stacktrace) {
      log("Don't know why");
      if (kDebugMode) {
        print("Exception occurred: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }
}
