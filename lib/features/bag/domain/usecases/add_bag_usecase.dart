import 'package:dartz/dartz.dart';
import 'package:dro_health/core/exceptions/failures.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/bag/data/repositories/bag_repository.dart';

class AddBagUsecase {
  final BagRepository bagRepository;

  AddBagUsecase({this.bagRepository});

  Future<Either<Failure, bool>> call({Drug drug}) async {
    return await bagRepository.addDrug(drug);
  }
}
