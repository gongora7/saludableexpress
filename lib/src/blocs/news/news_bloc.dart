
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';
import 'package:flutter_app1/src/repositories/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc {

  final NewsRepo newsRepo;

  final _newsStreamController = StreamController<NewsResponse>();
  final _newsEventController = StreamController<NewsEvent>();


  StreamSink<NewsResponse> get newsSink => _newsStreamController.sink;
  Stream<NewsResponse> get newsStream => _newsStreamController.stream;
  Sink<NewsEvent> get newsEventSink => _newsEventController.sink;

  NewsBloc(this.newsRepo) {
    _newsEventController.stream.listen((event) async {
      if(event is GetNews) {
        NewsResponse data = await newsRepo.fetchNews(event.pageNumber, event.isFeature, event.categoryId);
        newsSink.add(data);
      }
    });
  }


}