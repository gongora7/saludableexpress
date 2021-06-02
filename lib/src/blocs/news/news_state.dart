
part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();

  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {

  const NewsLoading();

  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {

  final NewsResponse newsResponse;

  const NewsLoaded(this.newsResponse);
  @override
  List<Object> get props => [this.newsResponse];
}

class NewsError extends NewsState {

  final String error;

  const NewsError(this.error);

  @override
  List<Object> get props => [this.error];

}