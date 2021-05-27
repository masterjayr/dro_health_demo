part of 'delete_bag_bloc.dart';

@immutable
abstract class DeleteBagEvent {}

class DeleteFromBagEvent extends DeleteBagEvent {
  final int id;

  DeleteFromBagEvent({this.id});
}
