import 'package:equatable/equatable.dart';
import 'package:ev_studios_task/model/articles-model.dart';
import 'package:ev_studios_task/resources/api-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'articles-event.dart';
part 'articles-state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetArticlesList>((event, emit) async {
      try {
        emit(ArticlesLoading());
        final mList = await apiRepository.fetchArticlesList();
        emit(ArticlesLoaded(mList));
        if (mList == null) {
          emit(const ArticlesError("Error Happened, try Again Later"));
        }
      } on NetworkError {
        emit(const ArticlesError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
