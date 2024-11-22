part of 'list_water_log_bloc.dart';

@immutable
sealed class ListWaterLogEvent {}

class WaterLogListViewLoaded extends ListWaterLogEvent {}

class WaterLogsStreamSubRequested extends ListWaterLogEvent {}
