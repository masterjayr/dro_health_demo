import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/allDrugs/domain/usecases/all_drugs_usecase.dart';
import 'package:meta/meta.dart';

part 'all_drugs_event.dart';
part 'all_drugs_state.dart';

class AllDrugsBloc extends Bloc<AllDrugsEvent, AllDrugsState> {
  final AllDrugsUsecase allDrugsUsecase;

  AllDrugsBloc({AllDrugsState initialState, this.allDrugsUsecase})
      : super(initialState);

  @override
  Stream<AllDrugsState> mapEventToState(
    AllDrugsEvent event,
  ) async* {
    if (event is GetAllDrugsEvent) {
      yield Loading();
      final result = allDrugsUsecase();
      yield Loaded(allDrugs: result);
    }
  }
}
