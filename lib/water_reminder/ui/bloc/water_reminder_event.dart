part of 'water_reminder_bloc.dart';

@immutable
sealed class WaterReminderEvent {}

class WaterReminderPageLoaded extends WaterReminderEvent {}

class CreateWaterGoalPressed extends WaterReminderEvent {
  final String text;

  CreateWaterGoalPressed(this.text);
}
