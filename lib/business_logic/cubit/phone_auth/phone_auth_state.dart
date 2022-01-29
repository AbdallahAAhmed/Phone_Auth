part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

// Loading
class Loading extends PhoneAuthState {}

// Error
class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  ErrorOccurred({ required this.errorMsg});
}

// if the phone number submitted
class PhoneNumberSubmitted extends PhoneAuthState {}

// if the phone number verified 
class PhoneOTPVerified extends PhoneAuthState {}



