import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/shared/network/local/shared_preferences.dart';
import '../states/loginstates.dart';

class SocialLOGINCubit extends Cubit<SocialLogInStates> {
  SocialLOGINCubit() : super(SocialLogInInitialState());

  bool isPassword = true;
  IconData prefixIcon = Icons.lock_outlined;
  IconData suffixIcon = Icons.visibility_outlined;

  static SocialLOGINCubit get(context) => BlocProvider.of(context);

  void changePasswordState() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.lock_outlined : Icons.lock_open;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(PasswordChangeState());
  }

  logIn({
    required String email,
    required String password,
  }) {
    emit(SocialLogInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('user Credential : $value');

      emit(SocialLogInSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLogInErrorState(error.toString()));
    });
  }
}
