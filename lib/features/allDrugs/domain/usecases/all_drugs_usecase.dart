import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/allDrugs/data/repositories/all_drugs_repo.dart';

class AllDrugsUsecase {
  final AllDrugsRepository allDrugsRepository;

  AllDrugsUsecase({this.allDrugsRepository});

  List<Drug> call() {
    // this calls the repository
    return allDrugsRepository.getDrugs();
  }
}
