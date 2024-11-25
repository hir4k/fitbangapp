import 'package:isar/isar.dart';

part 'daily_water_intake_collection.g.dart';

@Collection(accessor: 'dailyWaterIntake')
class DailyWaterIntakeCollection {
  Id id = Isar.autoIncrement;
  late int amount;
  late DateTime date;
}
