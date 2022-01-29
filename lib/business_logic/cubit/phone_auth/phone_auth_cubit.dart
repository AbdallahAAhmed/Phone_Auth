// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  // when the phone number submit to firebase to send the sms to the phone number, that function is for that
  // by the way this is function from flutter firebase phone auth docs and here we're modifing.
  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    // this is from flutter firebase phone number docs
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+970 $phoneNumber',
      timeout: const Duration(
          seconds:
              14), // The time consumed of try to read automatic the code incoming to device.
      verificationCompleted: verificationCompleted, // everything is okay
      verificationFailed: verificationFailed, // something return error
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // Automatic handling of the SMS code on Android devices.
  // This handler will only be called on Android devices which support automatic SMS code resolution.
  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  // If Firebase returns an error
  // Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  // Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
  // when the phone number already sended, and make verify it.
  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  // Handle a timeout of when automatic SMS code handling fails.
  // That is function is not important on this case, becouse i solved this issue by set timeout and get it value by seconds.
  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  // if firebase send the OTP code by sms to your mobile number, and you should to enter the OTP code to inputs to signIn, that's function for that.
  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  // Sign In function
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    }catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  // LogOut Function
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut(); // method from firebase.
  }

  // Return User account Information
  // the User model from firebase not model from developer.
  User getLoggedInUser() {
    return FirebaseAuth.instance.currentUser!;  // method from firebase.
  } 

}
