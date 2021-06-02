import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/search_response.dart';
import 'package:flutter_app1/src/repositories/search_repo.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final SearchResponse searchResponse;

  const SearchLoaded(this.searchResponse);

  @override
  List<Object> get props => [this.searchResponse];
}

class SearchError extends SearchState {
  final String error;

  const SearchError(this.error);

  @override
  List<Object> get props => [this.error];
}
