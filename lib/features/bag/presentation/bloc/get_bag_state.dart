part of 'get_bag_bloc.dart';

@immutable
abstract class GetBagState {}

class GetEmpty extends GetBagState {}

class GetLoading extends GetBagState {}

class GetLoaded extends GetBagState {
  final List<Drug> drugs;

  GetLoaded({this.drugs});
}

class GetError extends GetBagState {
  final String message;

  GetError({this.message});
}
