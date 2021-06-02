part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class CountriesInitial extends AddressState {
  const CountriesInitial();

  @override
  List<Object> get props => [];
}

class CountriesLoading extends AddressState {
  const CountriesLoading();

  @override
  List<Object> get props => [];
}

class CountriesLoaded extends AddressState {
  final CountriesResponse countriesResponse;

  const CountriesLoaded(this.countriesResponse);

  @override
  List<Object> get props => [countriesResponse];
}

class CountriesError extends AddressState {
  final String error;

  const CountriesError(this.error);

  @override
  List<Object> get props => [error];
}

class ZonesInitial extends AddressState {
  const ZonesInitial();

  @override
  List<Object> get props => [];
}

class ZonesLoading extends AddressState {
  const ZonesLoading();

  @override
  List<Object> get props => [];
}

class ZonesLoaded extends AddressState {
  final ZonesResponse zonesResponse;

  const ZonesLoaded(this.zonesResponse);

  @override
  List<Object> get props => [this.zonesResponse];
}

class ZonesError extends AddressState {
  final String error;

  const ZonesError(this.error);

  @override
  List<Object> get props => [this.error];
}

class AddressInitial extends AddressState {
  const AddressInitial();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {
  const AddressLoading();

  @override
  List<Object> get props => [];
}

class AddressLoaded extends AddressState {
  @override
  List<Object> get props => [];
}

