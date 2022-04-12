import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawyer_app/models/user_model.dart';
import 'package:lawyer_app/modules/register/cubit/registerStates.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class RegisterCubits extends Cubit<RegisterStates> {
  RegisterCubits() : super(RegisterInitialStates());

  static RegisterCubits get(context) => BlocProvider.of(context);

  String errorMessage = '';
  File? file;
  UploadTask? task;
  var fileName;

  bool confrim = false;
  bool accept = false;
  void checkConfirmPass(var pass, var confirm) {
    if (pass == confirm) {
      confrim = true;
    } else {
      confrim = false;
    }
    emit(RegisterCehckConfirmStates());
  }

  void changeAcceptance(value) {
    accept = !accept;
    emit(changeAccepteStates());
  }

  void registerUser(
      {required String username,
      required String email,
      required String password,
      bool? lawyer,
      String? category,
      required String phone}) {
    emit(RegisterUserLoadingStates());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          username: username,
          phone: phone,
          email: email,
          lawyer: false,
          category: '',
          userID: value.user!.uid);
      emit(RegisterUserSuccessStates());
    }).catchError((error) {
      errorMessage = error.message;
      emit(RegisterUserErrorStates(errorMessage.toString()));
    });
  }

  void createUser(
      {required String? username,
      required String? phone,
      required String? email,
      required String? userID,
      bool? lawyer,
      String? category}) {
    UsersModel usersModel = UsersModel(
        userID, email, username, phone, lawyer, category, '', '', 0, '', '');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(usersModel.toMap())
        .then((value) {
      emit(CreateUserSuccessfullStates());
    }).catchError((error) {
      print('Errrrrrrrrrror' + error.toString());
      emit(CreateUserErrorStates());
    });
  }

  void registerLawyer(
      {required String username,
      required String email,
      required String password,
      bool? lawyer,
      required String? category,
      required String phone}) {
    emit(RegisterLawyerLoadingStates());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createLawyer(
        username: username,
        phone: phone,
        email: email,
        lawyer: true,
        category: category,
        userID: value.user!.uid,
      );
      emit(RegisterLawyerSuccessStates());
    }).catchError((error) {
      errorMessage = error.message;
      emit(RegisterLawyerErrorStates(errorMessage.toString()));
    });
  }

  void createLawyer(
      {required String? username,
      required String? phone,
      required String? email,
      required String? userID,
      bool? lawyer,
      required String? category,
      String? yearsExp,
      String? photo}) {
    UsersModel usersModel = UsersModel(
        userID,
        email,
        username,
        phone,
        lawyer,
        category,
        '',
        '',
        0,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_RlT-ytB9A_TQFLKMqVYpdJiiRbckTCThmw&usqp=CAU',
        '');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(usersModel.toMap())
        .then((value) {
      emit(CreateLawyerSuccessfullStates());
    }).catchError((error) {
      print('Errrrrrrrrrror' + error.toString());
      emit(CreateLawyerErrorStates());
    });
  }
}
