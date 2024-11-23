import 'package:fitbangapp/database/collections/settings_collection.dart';

class SettingsModel {
  final int id;
  final String key;
  final String value;

  SettingsModel({
    required this.id,
    required this.key,
    required this.value,
  });

  factory SettingsModel.fromIsar(SettingsCollection collection) {
    return SettingsModel(
      id: collection.id,
      key: collection.key,
      value: collection.value,
    );
  }
}
