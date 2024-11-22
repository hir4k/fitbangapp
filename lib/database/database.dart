import 'package:fitbangapp/database/collections/water_log_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

export './collections/water_log_collection.dart';

Future<Isar> connectIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [WaterLogCollectionSchema],
    directory: dir.path,
  );
}
