part of 'water_intake_progress_bloc.dart';

@immutable
sealed class WaterIntakeProgressState {}

final class WaterIntakeProgressInitial extends WaterIntakeProgressState {}

class FetchWaterIntakeSuccess extends WaterIntakeProgressState {
  final int todayWaterIntakeGoalAmount;
  final int todayTotalWaterIntakeAmount;

  FetchWaterIntakeSuccess({
    required this.todayWaterIntakeGoalAmount,
    required this.todayTotalWaterIntakeAmount,
  });
}

class FetchWaterIntakeError extends WaterIntakeProgressState {}
