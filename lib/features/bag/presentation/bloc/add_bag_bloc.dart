import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/bag/domain/usecases/add_bag_usecase.dart';
import 'package:meta/meta.dart';

part 'add_bag_event.dart';
part 'add_bag_state.dart';

class AddBagBloc extends Bloc<AddBagEvent, AddBagState> {
  final AddBagUsecase addBagUsecase;

  AddBagBloc({AddBagState initialState, this.addBagUsecase})
      : super(initialState);

  @override
  Stream<AddBagState> mapEventToState(
    AddBagEvent event,
  ) async* {
    if (event is AddToBagEvent) {
      yield AddLoading();
      final result = await addBagUsecase(drug: event.drug);
      yield result.fold((error) => AddError(message: error.message),
          (isAdded) => AddLoaded(isAdded: isAdded));
    }
  }
}
