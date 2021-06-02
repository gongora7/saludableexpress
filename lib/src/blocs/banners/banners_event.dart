part of 'banners_bloc.dart';

abstract class BannersEvent extends Equatable {
  const BannersEvent();
}

class GetBanners extends BannersEvent {
  const GetBanners();

  @override
  List<Object> get props => [];
}
