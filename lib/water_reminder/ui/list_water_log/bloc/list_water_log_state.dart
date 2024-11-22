part of 'list_water_log_bloc.dart';

@immutable
sealed class ListWaterLogState {}

final class ListWaterLogInitial extends ListWaterLogState {}

class ListWaterLogInProgress extends ListWaterLogState {}

class ListWaterLogSuccess extends ListWaterLogState {
  final List<WaterLogModel> waterLogs;

  ListWaterLogSuccess(this.waterLogs);
}

class ListWaterLogFail extends ListWaterLogState {}
