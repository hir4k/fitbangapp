import 'package:fitbangapp/database/database.dart';
import 'package:fitbangapp/water_reminder/models/water_log_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/subjects.dart';

class WaterLogRepository {
  WaterLogRepository(this.db);

  final Isar db;

  final _logsController = BehaviorSubject<List<WaterLogModel>>.seeded([]);

  Stream<List<WaterLogModel>> get logsStream => _logsController.stream;

  Future<void> create({int amount = 250}) async {
    final now = DateTime.now();
    final newWaterLog = WaterLogCollection()
      ..amount = amount
      ..createdAt = now;
    final id = await db.writeTxn(() async {
      return await db.waterLog.put(newWaterLog);
    });
    newWaterLog.id = id;
    final logs = List<WaterLogModel>.from(_logsController.value);
    _logsController.sink.add([...logs, WaterLogModel.fromIsar(newWaterLog)]);
  }

  Future<void> list() async {
    final now = DateTime.now();
    final lower = DateUtils.dateOnly(now);
    final collections =
        await db.waterLog.filter().createdAtBetween(lower, now).findAll();
    final logs = collections.map((c) => WaterLogModel.fromIsar(c)).toList();
    _logsController.sink.add(logs);
  }
}
