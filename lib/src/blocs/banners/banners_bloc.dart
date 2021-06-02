import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/repositories/banners_repo.dart';

part 'banners_event.dart';

part 'banners_state.dart';

class BannersBloc {

  final BannersRepo bannersRepo;

  // init and get StreamController
  final _bannersStreamController = StreamController<BannersResponse>();

  StreamSink<BannersResponse> get banners_sink => _bannersStreamController.sink;

  // expose data from stream
  Stream<BannersResponse> get banners_stream => _bannersStreamController.stream;

  final _bannersEventController = StreamController<BannersEvent>();

  // expose sink for input events
  Sink<BannersEvent> get banners_event_sink => _bannersEventController.sink;

  BannersBloc(this.bannersRepo) {
    _bannersEventController.stream.listen(_handleEvent);
  }

  _handleEvent(BannersEvent event) async {
    //counter_sink.add(++_counter);
    if (event is GetBanners) {
      if(AppData.banners != null){
        banners_sink.add(AppData.banners);
        return;
      }
      BannersResponse data = await bannersRepo.fetchBanners();
      if(data.success == "1" && data.bannersData!= null)
        AppData.banners = data;
      banners_sink.add(data);
    }
  }

  dispose() {
    _bannersStreamController.close();
    _bannersEventController.close();
  }

}
