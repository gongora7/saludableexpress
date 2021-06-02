part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final CategoriesResponse categoriesResponse;

  const CategoriesLoaded(this.categoriesResponse);

  @override
  List<Object> get props => [categoriesResponse];
}

class CategoriesError extends CategoriesState {
  final String error;

  const CategoriesError(this.error);

  @override
  List<Object> get props => [error];
}
