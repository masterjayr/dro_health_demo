part of 'add_bag_bloc.dart';

@immutable
abstract class AddBagEvent {}

class AddToBagEvent extends AddBagEvent {
  final Drug drug;

  AddToBagEvent({this.drug});
}
