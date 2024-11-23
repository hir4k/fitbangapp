import 'package:fitbangapp/database/database.dart';

import 'package:isar/isar.dart';

class UserRepository {
  UserRepository(this.db);

  final Isar db;

  static const String heightKey = "user_height";
  static const String weightKey = 'user_weight';
  static const String ageKey = 'user_age';
  static const String genderKey = "user_gender";

  Future<void> setHeight(int cm) async {
    await _setByKey(heightKey, cm);
  }

  Future<void> setWeight(int kg) async {
    await _setByKey(weightKey, kg);
  }

  Future<void> setAge(int age) async {
    await _setByKey(ageKey, age);
  }

  Future<void> setGender({required bool isMale}) async {
    final gender = isMale ? 1 : 0;
    await _setByKey(genderKey, gender);
  }

  Future<int> get height async {
    final collection = await _getByKey(heightKey);
    if (collection == null) {
      throw Exception('User height not found');
    }
    return int.parse(collection.value);
  }

  Future<int> get weight async {
    final collection = await _getByKey(weightKey);
    if (collection == null) {
      throw Exception('User weight not found');
    }
    return int.parse(collection.value);
  }

  Future<int> get age async {
    final collection = await _getByKey(ageKey);
    if (collection == null) {
      throw Exception('User age not found');
    }
    return int.parse(collection.value);
  }

  Future<SettingsCollection?> _getByKey(String key) async {
    return await db.settings.filter().keyEqualTo(key).findFirst();
  }

  Future<SettingsCollection> _setByKey(String key, dynamic value) async {
    final collection = await _getByKey(key);

    late SettingsCollection updatedCollection;

    if (collection == null) {
      updatedCollection = SettingsCollection()
        ..key = key
        ..value = value.toString();
    } else {
      collection.value = value.toString();
      updatedCollection = collection;
    }

    final id = await db.writeTxn(() async {
      return await db.settings.put(updatedCollection);
    });

    updatedCollection.id = id;
    return updatedCollection;
  }
}
