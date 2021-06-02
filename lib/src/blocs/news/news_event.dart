
part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNews extends NewsEvent {

  final int pageNumber;
  final int isFeature;
  final int categoryId;

  const GetNews(this.pageNumber, this.isFeature, this.categoryId);

  @override
  List<Object> get props => [this.pageNumber, this.isFeature, this.categoryId];
}