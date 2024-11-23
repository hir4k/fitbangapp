export './collections/water_log_collection.dart';
export './collections/settings_collection.dart';

import 'package:fitbangapp/database/collections/settings_collection.dart';
import 'package:fitbangapp/database/collections/water_log_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> connectIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [
      WaterLogCollectionSchema,
      SettingsCollectionSchema,
    ],
    directory: dir.path,
  );
}
