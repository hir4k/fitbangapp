part of 'create_water_log_bloc.dart';

@immutable
sealed class CreateWaterLogState {}

final class CreateWaterLogInitial extends CreateWaterLogState {}

class CreateWaterLogInProgress extends CreateWaterLogState {}

class CreateWaterLogSuccess extends CreateWaterLogState {}

class CreateWaterLogFail extends CreateWaterLogState {}
