import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawyer_app/models/user_model.dart';
import 'package:lawyer_app/modules/login/loginCubit/login_states.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';

class LoginCubits extends Cubit<LoginStates> {
  LoginCubits() : super(LoginInitialStates());

  static LoginCubits get(context) => BlocProvider.of(context);

  String errorMessage = '';
  UsersModel? checkModel;
  bool isLawyer = false;
  void loginUser({required String email, required String password}) {
    emit(LoginUserLoadingStates());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      
      emit(LoginUserSuccessStates(value.user!.uid));
    }).catchError((error) {
      if (error.code == 'invalid-email') {
        errorMessage = 'The email address is badly formatted';
        //showToast(text: 'Invalid Email', states: ToastStates.ERROR);
      }
      if (error.code == 'user-not-found') {
        errorMessage =
            'There is no user record corresponding to this email address';

        //showToast(text: 'User not found', states: ToastStates.ERROR);
      }
      if (error.code == 'wrong-password') {
        errorMessage = 'The password is invalid';

        //showToast(text: 'Wrong password', states: ToastStates.ERROR);
      }

      emit(LoginUserErrorStates(errorMessage));
    });
  }
}
