import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class PerformSearch extends SearchEvent {
  final String query;

  const PerformSearch(this.query);

  @override
  List<Object> get props => [this.query];
}

class ClearSearch extends SearchEvent {
  const ClearSearch();

  @override
  List<Object> get props => [];
}
