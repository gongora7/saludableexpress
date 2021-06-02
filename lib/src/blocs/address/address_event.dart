part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class GetCountries extends AddressEvent {
  const GetCountries();

  @override
  List<Object> get props => [];
}

class GetZones extends AddressEvent {
  final int countryId;

  const GetZones(this.countryId);

  @override
  List<Object> get props => [this.countryId];
}

class GetAddresses extends AddressEvent {
  const GetAddresses();

  @override
  List<Object> get props => [];
}

class AddAddress extends AddressEvent {
  final Address address;

  const AddAddress(this.address);

  @override
  List<Object> get props => [this.address];
}

class GetDefaultAddress extends AddressEvent {

  GetDefaultAddress();

  @override
  List<Object> get props => [];

}