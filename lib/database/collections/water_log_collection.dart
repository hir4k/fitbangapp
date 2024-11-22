import 'package:isar/isar.dart';

part 'water_log_collection.g.dart';

@Collection(accessor: 'waterLog')
class WaterLogCollection {
  Id id = Isar.autoIncrement;
  late DateTime createdAt;
  late int amount;
}
