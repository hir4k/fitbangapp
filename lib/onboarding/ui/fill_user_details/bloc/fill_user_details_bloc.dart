import 'package:bloc/bloc.dart';
import 'package:fitbangapp/onboarding/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'fill_user_details_event.dart';
part 'fill_user_details_state.dart';

class FillUserDetailsBloc
    extends Bloc<FillUserDetailsEvent, FillUserDetailsState> {
  FillUserDetailsBloc(this.repository) : super(FillUserDetailsInitial()) {
    on<FillUserDetailsPageLoaded>((event, emit) async {
      emit(FillUserHeightShowing());
    });

    on<SaveUserHeightPressed>((event, emit) async {
      emit(FillUserDetailsInProgress());
      try {
        await repository.setHeight(event.cm);
        emit(FillUserWeightShowing());
      } catch (e) {
        emit(FillUserDetailsFail());
      }
    });

    on<SaveUserWeightPressed>((event, emit) async {
      emit(FillUserDetailsInProgress());
      try {
        await repository.setWeight(event.weightInKg);
        emit(FillUserAgeShowing());
      } catch (e) {
        emit(FillUserDetailsFail(message: 'Setting weight failed'));
      }
    });

    on<SaveUserAgePressed>((event, emit) async {
      emit(FillUserDetailsInProgress());
      try {
        await repository.setAge(event.age);
        emit(FillUserGenderShowing());
      } catch (e) {
        emit(FillUserDetailsFail(message: 'Setting age failed'));
      }
    });

    on<SaveUserGenderPressed>((event, emit) async {
      emit(FillUserDetailsInProgress());
      try {
        await repository.setGender(isMale: event.isMale);
        emit(FillUserDetailsComplete());
      } catch (e) {
        emit(FillUserDetailsFail(message: 'Setting user gender failed'));
      }
    });
  }

  final UserRepository repository;
}
