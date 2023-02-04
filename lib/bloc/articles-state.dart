part of 'articles-bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object?> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<ArticlesModel>? articlesList;
  const ArticlesLoaded(this.articlesList);
}

class ArticlesError extends ArticlesState {
  final String? message;
  const ArticlesError(this.message);
}
