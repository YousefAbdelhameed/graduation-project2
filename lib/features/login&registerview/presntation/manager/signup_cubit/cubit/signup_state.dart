part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLooding extends SignupState {}

final class SignupSucssess extends SignupState {
  final dynamic data;
  SignupSucssess({required this.data});
}

final class SignupFailuer extends SignupState {
  final String? error;
  SignupFailuer({this.error});
}
