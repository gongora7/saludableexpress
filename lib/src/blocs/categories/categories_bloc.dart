import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/repositories/categories_repo.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesBloc(this.categoriesRepo) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    yield CategoriesLoading();
    if (event is GetCategories) {
      if(AppData.categories != null) {
        yield CategoriesLoaded(AppData.categories);
        return;
      }
      try {
        final categoriesResponse = await categoriesRepo.fetchCategories();
        if (categoriesResponse.success == "1" &&
            categoriesResponse.categoriesData.isNotEmpty) {
          AppData.categories = categoriesResponse;
          yield CategoriesLoaded(categoriesResponse);
        } else
          yield CategoriesError(categoriesResponse.message);
      } on Error {
        yield CategoriesError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
