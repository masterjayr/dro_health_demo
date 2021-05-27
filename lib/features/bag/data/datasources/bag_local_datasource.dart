import 'package:dro_health/core/app_database.dart';
import 'package:dro_health/core/exceptions/exceptions.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';

class BagLocalDatasource {
  final AppDao appDao;

  BagLocalDatasource({this.appDao});

  Future<List<Drug>> getCachedBagDetails() async {
    List<Drug> drugs = await appDao.getDrugsInBag();
    if (drugs != null) {
      return drugs;
    } else {
      throw CacheException(message: "Could not retrieve bag details");
    }
  }

  Future<bool> addDrug(Drug drug) async {
    bool result = await appDao.addDrug(drug);
    if (result) {
      return result;
    } else {
      throw CacheException(message: "Could not add drug");
    }
  }

  Future<bool> deleteDrug(int id) async {
    bool result = await appDao.delete(id);
    if (result) {
      return result;
    } else {
      throw CacheException(message: "Could not delete drug");
    }
  }
}
