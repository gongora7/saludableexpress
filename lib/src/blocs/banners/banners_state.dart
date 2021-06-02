part of 'banners_bloc.dart';

abstract class BannersState extends Equatable {
  const BannersState();
}

class BannersInitial extends BannersState {
  const BannersInitial();

  @override
  List<Object> get props => [];
}

class BannersLoading extends BannersState {
  const BannersLoading();

  @override
  List<Object> get props => [];
}

class BannersLoaded extends BannersState {
  final BannersResponse bannersResponse;

  const BannersLoaded(this.bannersResponse);

  @override
  List<Object> get props => [bannersResponse];
}

class BannersError extends BannersState {
  final String error;

  const BannersError(this.error);

  @override
  List<Object> get props => [error];
}
