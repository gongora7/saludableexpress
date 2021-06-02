part of 'my_address_bloc.dart';

abstract class MyAddressState extends Equatable {
  const MyAddressState();
}

class MyAddressInitial extends MyAddressState {
  const MyAddressInitial();

  @override
  List<Object> get props => [];
}

class MyAddressLoading extends MyAddressState {

  const MyAddressLoading();

  @override
  List<Object> get props => [];
}

class MyAddressLoaded extends MyAddressState {

  final AddressResponse addressResponse;

  const MyAddressLoaded(this.addressResponse);

  @override
  List<Object> get props => [this.addressResponse];

}

class MyAddressError extends MyAddressState {
  final String error;

  const MyAddressError(this.error);

  @override
  List<Object> get props => [this.error];
}