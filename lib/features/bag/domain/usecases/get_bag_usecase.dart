import 'package:dartz/dartz.dart';
import 'package:dro_health/core/exceptions/failures.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/bag/data/repositories/bag_repository.dart';

class GetBagUsecase {
  final BagRepository bagRepository;

  GetBagUsecase({this.bagRepository});

  Future<Either<Failure, List<Drug>>> call() async {
    return await bagRepository.getBagDetails();
  }
}
