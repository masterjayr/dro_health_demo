import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dro_health/features/bag/domain/usecases/delete_bag_usecase.dart';
import 'package:meta/meta.dart';

part 'delete_bag_event.dart';
part 'delete_bag_state.dart';

class DeleteBagBloc extends Bloc<DeleteBagEvent, DeleteBagState> {
  final DeleteBagUsecase deleteBagUsecase;

  DeleteBagBloc({DeleteBagState initialState, this.deleteBagUsecase})
      : super(initialState);

  @override
  Stream<DeleteBagState> mapEventToState(
    DeleteBagEvent event,
  ) async* {
    if (event is DeleteFromBagEvent) {
      yield DeleteLoading();
      final result = await deleteBagUsecase(id: event.id);
      yield result.fold((error) => DeleteError(message: error.message),
          (isDeleted) => DeleteLoaded(isDeleted: isDeleted));
    }
  }
}
