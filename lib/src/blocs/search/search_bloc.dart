import 'package:flutter_app1/src/api/responses/search_response.dart';
import 'package:flutter_app1/src/blocs/search/search_event.dart';
import 'package:flutter_app1/src/blocs/search/search_state.dart';
import 'package:flutter_app1/src/repositories/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;

  SearchBloc(this.searchRepo) : super(SearchInitial());



  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is PerformSearch) {
      yield SearchLoading();
      try {
        SearchResponse response = await searchRepo.fetchSearchData(event.query);
        if (response.success == "1" && response.productData.products.isNotEmpty) {
          yield SearchLoaded(response);
        } else {
          yield SearchError(response.message);
        }
      } on Error {
        yield SearchError("Couldn't fetch Data. Is the device online?");
      }
    } else if (event is ClearSearch) {
      yield SearchInitial();
    }
  }

}