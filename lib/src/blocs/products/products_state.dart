part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();

  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();

  @override
  List<Object> get props => [];
}

class TopSellerProductsLoading extends ProductsState {
  const TopSellerProductsLoading();

  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductsState {
  final ProductsResponse productsResponse;

  const ProductsLoaded(this.productsResponse);

  @override
  List<Object> get props => [productsResponse];
}

class TopSellerProductsLoaded extends ProductsState {
  final ProductsResponse productsResponse;

  const TopSellerProductsLoaded(this.productsResponse);

  @override
  List<Object> get props => [productsResponse];
}

class ProductsError extends ProductsState {
  final String error;

  const ProductsError(this.error);

  @override
  List<Object> get props => [error];
}

class LikeProductInitial extends ProductsState {

  const LikeProductInitial();

  @override
  List<Object> get props => [];

}

class LikeProductLoading extends ProductsState {

  const LikeProductLoading();

  @override
  List<Object> get props => [];
}

class LikeProductLoaded extends ProductsState {

  final LikeProductResponse likeProductResponse;

  const LikeProductLoaded(this.likeProductResponse);

  @override
  List<Object> get props => [this.likeProductResponse];

}

class LikeProductError extends ProductsState {

  final String error;

  const LikeProductError(this.error);

  @override
  List<Object> get props => [this.error];

}

