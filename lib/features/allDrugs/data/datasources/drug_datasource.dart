import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';

class DrugDataSource {
  // file to access any external api's like calling all drugs endpoint using http or any resource getter package

  // calling getDrugs to return all Drugs at last (in a real case get Drugs would be a future returning a list of drugs from an external source)
  List<Drug> getDrugs() {
    return allDrugs;
  }
}
