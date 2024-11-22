import 'package:bloc/bloc.dart';
import 'package:fitbangapp/water_reminder/models/water_log_model.dart';
import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:meta/meta.dart';

part 'list_water_log_event.dart';
part 'list_water_log_state.dart';

class ListWaterLogBloc extends Bloc<ListWaterLogEvent, ListWaterLogState> {
  ListWaterLogBloc(this.repository) : super(ListWaterLogInitial()) {
    on<WaterLogListViewLoaded>((event, emit) async {
      emit(ListWaterLogInProgress());
      try {
        await repository.list();
      } catch (e) {
        emit(ListWaterLogFail());
      }
    });

    on<WaterLogsStreamSubRequested>((event, emit) async {
      await emit.forEach(repository.logsStream,
          onData: (data) => ListWaterLogSuccess(data));
    });
  }

  final WaterLogRepository repository;
}
