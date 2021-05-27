import 'package:dro_health/features/allDrugs/data/datasources/drug_datasource.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';

class AllDrugsRepository {
  // this repository calls the drug_datasource
  final DrugDataSource drugDataSource;

  AllDrugsRepository({this.drugDataSource});

  List<Drug> getDrugs() {
    // try catch block would be used here in a real scenerio and it'll return either a list of drugs or throw an exception
    // to memick just return all drugs from drugDatasource

    final result = drugDataSource.getDrugs();
    return result;
  }
}
