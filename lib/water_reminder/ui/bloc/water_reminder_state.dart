part of 'water_reminder_bloc.dart';

@immutable
sealed class WaterReminderState {}

final class WaterReminderInitial extends WaterReminderState {}

class WaterReminderShowSetGoalView extends WaterReminderState {}

class WaterReminderShowMainView extends WaterReminderState {}

class WaterReminderError extends WaterReminderState {
  final String message;

  WaterReminderError(this.message);
}
