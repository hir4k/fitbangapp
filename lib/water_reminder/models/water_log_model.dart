import 'package:fitbangapp/database/database.dart';

class WaterLogModel {
  final int id;
  final DateTime createdAt;
  final int amount;

  WaterLogModel({
    required this.id,
    required this.createdAt,
    required this.amount,
  });

  factory WaterLogModel.fromIsar(WaterLogCollection collection) {
    return WaterLogModel(
      id: collection.id,
      createdAt: collection.createdAt,
      amount: collection.amount,
    );
  }
}
