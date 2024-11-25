import 'package:bloc/bloc.dart';
import 'package:fitbangapp/database/database.dart';
import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

part 'create_water_log_event.dart';
part 'create_water_log_state.dart';

class CreateWaterLogBloc
    extends Bloc<CreateWaterLogEvent, CreateWaterLogState> {
  CreateWaterLogBloc(this.repository, this.db)
      : super(CreateWaterLogInitial()) {
    on<CreateWaterLogPressed>((event, emit) async {
      emit(CreateWaterLogInProgress());
      try {
        const amount = 250;
        await repository.create(amount: amount);

        // Increase today total water intake
        final todayDate = DateUtils.dateOnly(DateTime.now());
        final todayWaterIntake = await db.dailyWaterIntake
            .filter()
            .dateEqualTo(todayDate)
            .findFirst();

        if (todayWaterIntake != null) {
          await db.writeTxn(() async {
            todayWaterIntake.amount += amount;
            await db.dailyWaterIntake.put(todayWaterIntake);
          });
        }

        emit(CreateWaterLogSuccess());
      } catch (e) {
        emit(CreateWaterLogFail());
      }
    });
  }

  final WaterLogRepository repository;
  final Isar db;
}
