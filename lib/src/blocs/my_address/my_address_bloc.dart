
import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/address_response.dart';
import 'package:flutter_app1/src/repositories/address_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_address_event.dart';
part 'my_address_state.dart';

class MyAddressBloc extends Bloc<MyAddressEvent, MyAddressState> {
  final AddressRepo addressRepo;
  MyAddressBloc(this.addressRepo) : super(MyAddressInitial());

  @override
  Stream<MyAddressState> mapEventToState(MyAddressEvent event) async* {
    if (event is GetMyAddresses) {
      try {
        final addressResponse = await addressRepo.fetchAllAddresses();
        if (addressResponse.success == "1" &&
            addressResponse.data.isNotEmpty) {
          yield MyAddressLoaded(addressResponse);
        } else
          yield MyAddressError(addressResponse.message);
      } on Error {
        yield MyAddressError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is DeleteAddress) {



    }
  }



}
