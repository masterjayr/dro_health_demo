import 'package:dro_health/core/app_database.dart';
import 'package:dro_health/features/allDrugs/data/datasources/drug_datasource.dart';
import 'package:dro_health/features/allDrugs/data/repositories/all_drugs_repo.dart';
import 'package:dro_health/features/allDrugs/domain/usecases/all_drugs_usecase.dart';
import 'package:dro_health/features/allDrugs/presentation/bloc/all_drugs_bloc.dart';
import 'package:dro_health/features/bag/data/datasources/bag_local_datasource.dart';
import 'package:dro_health/features/bag/data/repositories/bag_repository.dart';
import 'package:dro_health/features/bag/domain/usecases/add_bag_usecase.dart';
import 'package:dro_health/features/bag/domain/usecases/delete_bag_usecase.dart';
import 'package:dro_health/features/bag/domain/usecases/get_bag_usecase.dart';
import 'package:dro_health/features/bag/presentation/bloc/add_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/bloc/delete_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/bloc/get_bag_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => AllDrugsBloc(allDrugsUsecase: sl(), initialState: Empty()));
  sl.registerFactory(
      () => GetBagBloc(getBagUsecase: sl(), initialState: GetEmpty()));
  sl.registerFactory(
      () => AddBagBloc(addBagUsecase: sl(), initialState: AddEmpty()));
  sl.registerFactory(
      () => DeleteBagBloc(deleteBagUsecase: sl(), initialState: DeleteEmpty()));

  //usecases
  sl.registerLazySingleton(() => AllDrugsUsecase(allDrugsRepository: sl()));
  sl.registerLazySingleton(() => AddBagUsecase(bagRepository: sl()));
  sl.registerLazySingleton(() => GetBagUsecase(bagRepository: sl()));
  sl.registerLazySingleton(() => DeleteBagUsecase(bagRepository: sl()));
  //respositories
  sl.registerLazySingleton(() => AllDrugsRepository(drugDataSource: sl()));
  sl.registerLazySingleton(() => BagRepository(bagLocalDataSource: sl()));

  //datasources
  sl.registerLazySingleton(() => DrugDataSource());
  sl.registerLazySingleton(() => BagLocalDatasource(appDao: sl()));

  //local db
  sl.registerLazySingleton(() => AppDBProvider.db);
  sl.registerLazySingleton(() => AppDao(db: sl()));
}
