part of 'add_bag_bloc.dart';

@immutable
abstract class AddBagState {}

class AddEmpty extends AddBagState {}

class AddLoading extends AddBagState {}

class AddLoaded extends AddBagState {
  final bool isAdded;

  AddLoaded({this.isAdded});
}

class AddError extends AddBagState {
  final String message;

  AddError({this.message});
}
