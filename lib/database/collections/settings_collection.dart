import 'package:isar/isar.dart';

part 'settings_collection.g.dart';

@Collection(accessor: 'settings')
class SettingsCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: true)
  late String key;

  late String value;
}
