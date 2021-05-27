import 'package:dartz/dartz.dart';
import 'package:dro_health/core/exceptions/failures.dart';
import 'package:dro_health/features/bag/data/repositories/bag_repository.dart';

class DeleteBagUsecase {
  final BagRepository bagRepository;

  DeleteBagUsecase({this.bagRepository});

  Future<Either<Failure, bool>> call({int id}) async {
    return await bagRepository.deleteDrug(id);
  }
}
