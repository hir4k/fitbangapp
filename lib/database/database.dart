export './collections/water_log_collection.dart';
export './collections/water_goal_collection.dart';
export './collections/daily_water_intake_collection.dart';

import 'package:fitbangapp/database/collections/daily_water_intake_collection.dart';
import 'package:fitbangapp/database/collections/water_goal_collection.dart';
import 'package:fitbangapp/database/collections/water_log_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> connectIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [
      WaterLogCollectionSchema,
      WaterGoalCollectionSchema,
      DailyWaterIntakeCollectionSchema,
    ],
    directory: dir.path,
  );
}
