import 'package:bloc/bloc.dart';
import 'package:fitbangapp/database/database.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'water_reminder_event.dart';
part 'water_reminder_state.dart';

class WaterReminderBloc extends Bloc<WaterReminderEvent, WaterReminderState> {
  WaterReminderBloc(this.db) : super(WaterReminderInitial()) {
    on<WaterReminderPageLoaded>((event, emit) async {
      try {
        if (await db.waterGoal.count() == 0) {
          emit(WaterReminderShowSetGoalView());
        } else {
          // Create daily water intake
          final latestWaterGoal =
              await db.waterGoal.where(sort: Sort.desc).findFirst();

          if (latestWaterGoal == null) throw Exception('WaterGoal empty');

          final todayDate = DateUtils.dateOnly(DateTime.now());

          final todayDailyWaterIntakeRowsCount =
              await db.dailyWaterIntake.filter().dateEqualTo(todayDate).count();

          if (todayDailyWaterIntakeRowsCount == 0) {
            await db.writeTxn(() async {
              await db.dailyWaterIntake.put(
                DailyWaterIntakeCollection()
                  ..amount = 0
                  ..date = todayDate,
              );
            });
          }

          emit(WaterReminderShowMainView());
        }
      } catch (e) {
        emit(WaterReminderError(e.toString()));
      }
    });

    on<CreateWaterGoalPressed>((event, emit) async {
      try {
        final amount = int.parse(event.text);
        assert(amount > 0 && amount < 100000);
        final waterGoal = WaterGoalCollection()
          ..amount = amount
          ..startedAt = DateTime.now();
        await db.writeTxn(() async {
          await db.waterGoal.put(waterGoal);
        });
        emit(WaterReminderShowMainView());
      } catch (e) {
        emit(WaterReminderError(e.toString()));
      }
    });
  }

  final Isar db;
}
