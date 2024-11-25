import 'package:bloc/bloc.dart';
import 'package:fitbangapp/database/database.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'water_intake_progress_event.dart';
part 'water_intake_progress_state.dart';

class WaterIntakeProgressBloc
    extends Bloc<WaterIntakeProgressEvent, WaterIntakeProgressState> {
  WaterIntakeProgressBloc(this.db) : super(WaterIntakeProgressInitial()) {
    on<WaterIntakeProgressLoaded>((event, emit) async {
      final latestWaterGoal =
          await db.waterGoal.where(sort: Sort.desc).findFirst();
      final todayDate = DateUtils.dateOnly(DateTime.now());
      final todayDailyWaterIntake =
          await db.dailyWaterIntake.filter().dateEqualTo(todayDate).findFirst();
      try {
        if (latestWaterGoal == null) {
          throw Exception('WaterGoal not found.');
        }

        if (todayDailyWaterIntake == null) {
          throw Exception('DailyWaterGoalCollection today row not found.');
        }

        emit(FetchWaterIntakeSuccess(
          todayWaterIntakeGoalAmount: latestWaterGoal.amount,
          todayTotalWaterIntakeAmount: todayDailyWaterIntake.amount,
        ));

        final todayDailyWaterIntakeStream =
            db.dailyWaterIntake.watchObject(todayDailyWaterIntake.id);

        await emit.forEach(
          todayDailyWaterIntakeStream,
          onData: (data) => FetchWaterIntakeSuccess(
            todayWaterIntakeGoalAmount: latestWaterGoal.amount,
            todayTotalWaterIntakeAmount: data!.amount,
          ),
        );
      } catch (e) {
        emit(FetchWaterIntakeError());
      }
    });
  }

  final Isar db;
}
