import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/add_address_response.dart';
import 'package:flutter_app1/src/api/responses/address_response.dart';
import 'package:flutter_app1/src/api/responses/countries_response.dart';
import 'package:flutter_app1/src/api/responses/zones_response.dart';
import 'package:flutter_app1/src/models/address/address.dart';

abstract class AddressRepo {
  Future<CountriesResponse> fetchCountries();

  Future<ZonesResponse> fetchZones(int countryId);

  Future<AddressResponse> fetchAllAddresses();

  Future<AddAddressResponse> addAddress(Address address);
}

class RealAddressRepo implements AddressRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CountriesResponse> fetchCountries() {
    return _apiProvider.getCountries();
  }

  @override
  Future<ZonesResponse> fetchZones(int countryId) {
    return _apiProvider.getZones(countryId);
  }

  @override
  Future<AddressResponse> fetchAllAddresses() {
    return _apiProvider.getAllAddresses();
  }

  @override
  Future<AddAddressResponse> addAddress(Address address) {
    return _apiProvider.addAddress(address);
  }
}

class FakeAddressRepo implements AddressRepo {
  @override
  Future<CountriesResponse> fetchCountries() {
    throw UnimplementedError();
  }

  @override
  Future<ZonesResponse> fetchZones(int countryId) {
    throw UnimplementedError();
  }

  @override
  Future<AddressResponse> fetchAllAddresses() {
    throw UnimplementedError();
  }

  @override
  Future<AddAddressResponse> addAddress(Address address) {
    throw UnimplementedError();
  }
}
