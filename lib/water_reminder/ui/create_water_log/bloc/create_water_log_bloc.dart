import 'package:bloc/bloc.dart';
import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:meta/meta.dart';

part 'create_water_log_event.dart';
part 'create_water_log_state.dart';

class CreateWaterLogBloc
    extends Bloc<CreateWaterLogEvent, CreateWaterLogState> {
  CreateWaterLogBloc(this.repository) : super(CreateWaterLogInitial()) {
    on<CreateWaterLogPressed>((event, emit) async {
      emit(CreateWaterLogInProgress());
      try {
        await repository.create();
        emit(CreateWaterLogSuccess());
      } catch (e) {
        emit(CreateWaterLogFail());
      }
    });
  }

  final WaterLogRepository repository;
}
