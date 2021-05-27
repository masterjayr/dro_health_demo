import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/bag/domain/usecases/get_bag_usecase.dart';
import 'package:meta/meta.dart';

part 'get_bag_event.dart';
part 'get_bag_state.dart';

class GetBagBloc extends Bloc<GetBagEvent, GetBagState> {
  final GetBagUsecase getBagUsecase;

  GetBagBloc({GetBagState initialState, this.getBagUsecase})
      : super(initialState);

  @override
  Stream<GetBagState> mapEventToState(
    GetBagEvent event,
  ) async* {
    if (event is GetInBagEvent) {
      yield GetLoading();
      final result = await getBagUsecase();
      yield result.fold((error) => GetError(message: error.message),
          (drugs) => GetLoaded(drugs: drugs));
    }
  }
}
