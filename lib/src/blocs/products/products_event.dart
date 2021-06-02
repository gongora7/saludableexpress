part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetProducts extends ProductsEvent {
  final ProductPostModel postModel;

  const GetProducts(this.postModel);

  @override
  List<Object> get props => [postModel];
}

class GetCartProducts extends ProductsEvent {
  final List productsIds;

  const GetCartProducts(this.productsIds);

  @override
  List<Object> get props => [productsIds];
}

class GetSingleProduct extends ProductsEvent {
  final int productId;

  const GetSingleProduct(this.productId);

  @override
  List<Object> get props => [this.productId];
}

class DeleteCartProduct extends ProductsEvent {
  final int postion;

  const DeleteCartProduct(this.postion);

  @override
  List<Object> get props => [postion];
}

class IncrementCartProductQuantity extends ProductsEvent {
  final int position;

  IncrementCartProductQuantity(this.position);

  @override
  List<Object> get props => [position];
}

class DecrementCartProductQuantity extends ProductsEvent {
  final int position;

  DecrementCartProductQuantity(this.position);

  @override
  List<Object> get props => [position];
}

class GetStock extends ProductsEvent {
  final GetStockPost getStockPost;

  const GetStock(this.getStockPost);

  @override
  List<Object> get props => [this.getStockPost];
}

class GetNextPageProducts extends ProductsEvent {
  final ProductPostModel postModel;

  const GetNextPageProducts(this.postModel);

  @override
  List<Object> get props => [postModel];
}

class GetTopSellerProducts extends ProductsEvent {
  final ProductPostModel postModel;

  const GetTopSellerProducts(this.postModel);

  @override
  List<Object> get props => [postModel];
}

class GetFilters extends ProductsEvent {
  final String categoryID;

  GetFilters(this.categoryID);

  @override
  List<Object> get props => [categoryID];
}

class LikeProduct extends ProductsEvent {
  final int productId;

  const LikeProduct(this.productId);

  @override
  List<Object> get props => [this.productId];
}

class UnlikeProduct extends ProductsEvent {
  final int productId;

  const UnlikeProduct(this.productId);

  @override
  List<Object> get props => [this.productId];
}