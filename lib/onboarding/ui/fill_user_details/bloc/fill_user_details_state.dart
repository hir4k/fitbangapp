part of 'fill_user_details_bloc.dart';

@immutable
sealed class FillUserDetailsState {}

final class FillUserDetailsInitial extends FillUserDetailsState {}

class FillUserDetailsInProgress extends FillUserDetailsState {}

class FillUserHeightShowing extends FillUserDetailsState {}

class FillUserWeightShowing extends FillUserDetailsState {}

class FillUserAgeShowing extends FillUserDetailsState {}

class FillUserGenderShowing extends FillUserDetailsState {}

class FillUserDetailsComplete extends FillUserDetailsState {}

class FillUserDetailsFail extends FillUserDetailsState {
  final String message;

  FillUserDetailsFail({this.message = "Something went wrong"});
}
