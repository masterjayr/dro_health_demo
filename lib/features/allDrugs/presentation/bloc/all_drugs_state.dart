part of 'all_drugs_bloc.dart';

@immutable
abstract class AllDrugsState {}

class Empty extends AllDrugsState {}

class Loading extends AllDrugsState {}

class Loaded extends AllDrugsState {
  final List<Drug> allDrugs;

  Loaded({this.allDrugs});
}

class Error extends AllDrugsState {
  final String message;

  Error({this.message});
}
