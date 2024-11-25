import 'package:isar/isar.dart';

part 'water_goal_collection.g.dart';

@Collection(accessor: 'waterGoal')
class WaterGoalCollection {
  Id id = Isar.autoIncrement;
  late DateTime startedAt;
  DateTime? finishedAt;
  late int amount;
}
