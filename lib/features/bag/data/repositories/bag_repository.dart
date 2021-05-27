import 'package:dartz/dartz.dart';
import 'package:dro_health/core/exceptions/exceptions.dart';
import 'package:dro_health/core/exceptions/failures.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';

import '../datasources/bag_local_datasource.dart';

class BagRepository {
  final BagLocalDatasource bagLocalDataSource;
  BagRepository({this.bagLocalDataSource});

  Future<Either<Failure, List<Drug>>> getBagDetails() async {
    try {
      final result = await bagLocalDataSource.getCachedBagDetails();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<Failure, bool>> addDrug(Drug drug) async {
    try {
      final result = await bagLocalDataSource.addDrug(drug);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<Failure, bool>> deleteDrug(int id) async {
    try {
      final result = await bagLocalDataSource.deleteDrug(id);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
