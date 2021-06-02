part of 'my_address_bloc.dart';

abstract class MyAddressEvent extends Equatable {
  const MyAddressEvent();
}

class GetMyAddresses extends MyAddressEvent {

  const GetMyAddresses();

  @override
  List<Object> get props => [];
}

class DeleteAddress extends MyAddressEvent {

  final int addressBookId;

  DeleteAddress(this.addressBookId);

  @override
  List<Object> get props => [this.addressBookId];

}