part of 'delete_bag_bloc.dart';

@immutable
abstract class DeleteBagState {}

class DeleteEmpty extends DeleteBagState {}

class DeleteLoading extends DeleteBagState {}

class DeleteLoaded extends DeleteBagState {
  final bool isDeleted;

  DeleteLoaded({this.isDeleted});
}

class DeleteError extends DeleteBagState {
  final String message;

  DeleteError({this.message});
}
