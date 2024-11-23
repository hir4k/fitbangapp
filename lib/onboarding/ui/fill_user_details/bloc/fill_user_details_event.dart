part of 'fill_user_details_bloc.dart';

@immutable
sealed class FillUserDetailsEvent {}

class FillUserDetailsPageLoaded extends FillUserDetailsEvent {}

class SaveUserHeightPressed extends FillUserDetailsEvent {
  final int cm;

  SaveUserHeightPressed(this.cm);
}

class SaveUserWeightPressed extends FillUserDetailsEvent {
  final int weightInKg;

  SaveUserWeightPressed(this.weightInKg);
}

class SaveUserAgePressed extends FillUserDetailsEvent {
  final int age;

  SaveUserAgePressed(this.age);
}

class SaveUserGenderPressed extends FillUserDetailsEvent {
  final bool isMale;

  SaveUserGenderPressed({required this.isMale});
}
