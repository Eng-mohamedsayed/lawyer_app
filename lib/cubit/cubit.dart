// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/layouts/users/home_layout.dart';
import 'package:lawyer_app/models/connect_model.dart';
import 'package:lawyer_app/models/message_model.dart';
import 'package:lawyer_app/models/offer_model.dart';
import 'package:lawyer_app/models/problems_model.dart';

import 'package:lawyer_app/models/user_model.dart';
import 'package:lawyer_app/modules/login/loginCubit/login_states.dart';
import 'package:lawyer_app/modules/login/login_screen.dart';
import 'package:lawyer_app/shared/components/constants.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LawyerCubits extends Cubit<LawyerStates> {
  LawyerCubits() : super(LawyerInitialStates());

  static LawyerCubits get(context) => BlocProvider.of(context);

  UsersModel? model;

  void getUserData() {
    emit(LawyerGetAllUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .snapshots()
        .listen((value) {
      if (value.exists) {
        model = UsersModel.fromJson(value.data()!);
        print(value.data());
        emit(LawyerGetAllUserSuccessState());
      } else {
        print('Lawyer Not Found');
        emit(LawyerGetAllUserErrorState());
      }
    });
  }

  void getLawyerData() {
    emit(LawyerGetAllUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(lawyerID)
        .snapshots()
        .listen((value) {
      if (value.exists) {
        model = UsersModel.fromJson(value.data()!);
        print(value.data());
        emit(LawyerGetAllUserSuccessState());
      } else {
        print('Lawyer Not Found');
        emit(LawyerGetAllUserErrorState());
      }
    });
  }

  List<UsersModel> searchList = [];
  void serachByName({required String username}) {
    emit(LawyerSearchByNameLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .where('lawyer', isEqualTo: true)
        .get()
        .then((event) {
      searchList = [];
      for (var element in event.docs) {
        searchList.add(UsersModel.fromJson(element.data()));
      }
      print(searchList.length);

      emit(LawyerSearchByNameSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(LawyerSearchByNameErrorStates());
    });
  }

  void serachByCat({required String category}) {
    emit(LawyerSearchByCategoryLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .where('category', isEqualTo: category)
        .get()
        .then((event) {
      searchList = [];
      for (var element in event.docs) {
        searchList.add(UsersModel.fromJson(element.data()));
      }
      print(searchList.length);
      emit(LawyerSearchByCategorySuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(LawyerSearchByCategoryErrorStates());
    });
  }

  File? fileProfileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      fileProfileImage = File(pickedFile.path);
      emit(LaywerProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(LaywerProfileImagePickedErrorState());
    }
  }

  void updateLawyerProfile(
      {required String year,
      required String dates,
      String? category,
      String? profileImage,
      String? info}) {
    if (fileProfileImage != null) {
      emit(LawyerUpdateProfileLoadingStates());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(fileProfileImage!.path).pathSegments.last}')
          .putFile(fileProfileImage!)
          .then((value) {
        // bytesTransferred = value.bytesTransferred;
        // totalBytes = value.totalBytes;

        // // progress = double.parse(bytesTransferred / totalBytes);
        // // percentage = (progress * 100).toStringAsFixed(2);
        // // emit(MobileReviwGetPercentStates());

        value.ref.getDownloadURL().then((value) {
          editLawyerData(
              year: year,
              dates: dates,
              profileImage: value,
              category: category,
              info: info);

          emit(LawyerUploadProfileImageSuccessStates());
        }).catchError((error) {
          emit(LawyerUploadProfileImageErrorStates());
        });
      }).catchError((error) {
        emit(LawyerUploadProfileImageErrorStates());
      });
    } else {
      editLawyerDataWithoutProfile(
          year: year, dates: dates, category: category, info: info);
    }
  }

  void editLawyerData(
      {required String year,
      required String dates,
      String? category,
      String? profileImage,
      String? info}) {
    emit(LawyerUpdateLoadingStates());
    UsersModel userModel = UsersModel(
        lawyerID,
        model!.email,
        model!.username,
        model!.phone,
        model!.lawyer,
        category,
        year,
        dates,
        model!.rate,
        profileImage,
        info);

    FirebaseFirestore.instance
        .collection('users')
        .doc(lawyerID)
        .update(userModel.toMap())
        .then((value) {
      getLawyerData();
      emit(LawyerUpdateDataSuccessSatets());
    }).catchError((error) {
      print(error.toString());
      emit(LawyerUpdateDataErrorSatets());
    });
  }

  void editLawyerDataWithoutProfile(
      {required String year,
      required String dates,
      String? category,
      String? info}) {
    emit(LawyerUpdateWithoutPhotoLoadingStates());
    UsersModel userModel = UsersModel(
        lawyerID,
        model!.email,
        model!.username,
        model!.phone,
        model!.lawyer,
        category,
        year,
        dates,
        model!.rate,
        model!.photo,
        info);

    FirebaseFirestore.instance
        .collection('users')
        .doc(lawyerID)
        .update(userModel.toMap())
        .then((value) {
      getLawyerData();
      emit(LawyerUpdateWithoutPhotoDataSuccessSatets());
    }).catchError((error) {
      print(error.toString());
      emit(LawyerUpdateWithoutPhotoDataErrorSatets());
    });
  }

  // void editLawyerData({required String year, required String dates,
  // String?category ,String? profileImage, String?info}) {
  //   emit(LawyerEditProfileLoadingStates());
  //   FirebaseFirestore.instance.collection('users').doc(lawyerID).update({
  //     'yearsExp': year,
  //     'dates': dates,
  //     'photo':profileImage,
  //     'info':info,

  //   }).then((value) {
  //     emit(LawyerEditProfileSuccessStates());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LawyerEditProfileErrorStates());
  //   });
  // }

  bool rateSuccess = false;
  void rateLawyer(rate, lawID) {
    emit(LawyerRateLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(lawID)
        .update({'rate': rate}).then((value) {
      rateSuccess = true;
      emit(LawyerRateSuccessStates());
    }).catchError((error) {
      print(error.toString());
      rateSuccess = false;
      emit(LawyerRateErrorStates());
    });
  }

  List<ProblemsModel> allProblems = [];
  List<String> allProblemsID = [];
  void getProblemsByCat({required String? cat}) {
    emit(LawyerGetProblemsByCatLoadingStates());
    FirebaseFirestore.instance
        .collection('problems')
        .where('category', isEqualTo: cat)
        .snapshots()
        .listen((event) {
      allProblems = [];
      allProblemsID = [];
      for (var element in event.docs) {
        allProblems.add(ProblemsModel.fromJson(element.data()));
        allProblemsID.add(element.id);
      }
      print('*****************************************');

      for (int i = 0; i < allProblems.length; i++) {
        print(allProblems[i].category);
      }

      emit(LawyerGetProblemsByCatSuccessSatets());
    });
  }

  void addOffer({
    required String? offer,
    required String? uID,
    required String probID,
    String? username,
    String? profileImage,
    String? category,
  }) {
    emit(LawyerAddOfferLoadingStates());

    OfferModel offerModel = OfferModel(offer, probID, category, uID,
        DateTime.now().toString(), username, profileImage, lawyerID);
    FirebaseFirestore.instance
        .collection('problems')
        .doc(probID)
        .collection('offers')
        .doc(lawyerID)
        .set(offerModel.toMap())
        .then((value) {
      emit(LawyerAddOfferSuccessSatets());
    }).catchError((error) {
      emit(LawyerAddOfferErrorSatets());
    });
  }

  List<OfferModel> allOffers = [];
  List<String> allOfferID = [];
  void getOffers({required String probID}) {
    emit(LawyerGetOfferLoadingStates());
    FirebaseFirestore.instance
        .collection('problems')
        .doc(probID)
        .collection('offers')
        .snapshots()
        .listen((event) {
      allOffers = [];
      allOfferID = [];
      for (var element in event.docs) {
        allOffers.add(OfferModel.fromJson(element.data()));
        allOfferID.add(element.id);
      }

      emit(LawyerGetOfferSuccessSatets());
    });
  }

/*  ***********************  User Methods  *******************  */

  void makeProblem({String? title, String? desc, String? category}) {
    emit(LawyerMakeProblemLoadingStates());

    ProblemsModel problemsModel = ProblemsModel(title, desc, category, userID,
        DateTime.now().toString(), model!.username, false);
    FirebaseFirestore.instance
        .collection('problems')
        .add(problemsModel.toMap())
        .then((value) {
      emit(LawyerMakeProblemSuccessSatets());
    }).catchError((error) {
      emit(LawyerMakeProblemErrorSatets());
    });
  }

  List<ProblemsModel> myProblems = [];
  List<String> myProblemsID = [];
  void getMyProblems() {
    emit(LawyerGetMyProblemsLoadingStates());
    FirebaseFirestore.instance
        .collection('problems')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .listen((event) {
      myProblems = [];
      myProblemsID = [];
      for (var element in event.docs) {
        myProblems.add(ProblemsModel.fromJson(element.data()));
        myProblemsID.add(element.id);
      }
      print(myProblemsID.length);

      emit(LawyerGetMyProblemsSuccessSatets());
    });
  }

  void editProblem(
      {String? title,
      String? desc,
      String? category,
      required String? probID}) {
    emit(LawyerEditMyProblemsLoadingStates());

    ProblemsModel problemsModel = ProblemsModel(title, desc, category, userID,
        DateTime.now().toString(), model!.username, false);
    FirebaseFirestore.instance
        .collection('problems')
        .doc(probID)
        .update(problemsModel.toMap())
        .then((value) {
      emit(LawyerEditMyProblemsSuccessSatets());
    }).catchError((error) {
      emit(LawyerEditMyProblemsErrorSatets());
    });
  }

  void deleteProblem({required String? probID}) {
    emit(LawyerDeleteMyProblemsLoadingStates());

    FirebaseFirestore.instance
        .collection('problems')
        .doc(probID)
        .delete()
        .then((value) {
      emit(LawyerDeleteMyProblemsSuccessSatets());
    }).catchError((error) {
      emit(LawyerDeleteMyProblemsErrorSatets());
    });
  }

  List<OfferModel> myOffers = [];
  List<String> myOffersID = [];
  void getUserOffers({required String? probID}) {
    emit(LawyerGetUserOffersLoadingStates());
    FirebaseFirestore.instance
        .collection('problems')
        .doc(probID)
        .collection('offers')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .listen((event) {
      myOffers = [];
      myOffersID = [];
      for (var element in event.docs) {
        myOffers.add(OfferModel.fromJson(element.data()));
        myOffersID.add(element.id);
      }
      print(myProblemsID.length);

      emit(LawyerGetUserOffersSuccessSatets());
    });
  }

  void sendMessage(
      {required String? recieverID,
      required String dateTime,
      required String message}) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      message: message,
      recieveID: recieverID,
      senderID: model!.userID,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.userID)
        .collection('chats')
        .doc(recieverID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('chat').doc(model!.userID).set(
          {'recieverID': recieverID, 'senderID': model!.userID}).then((value) {
        emit(LawyerMakeConnectSuccessSatets());
      });

      emit(LawyerSendMessageSuccessSuccessSatets());
    }).catchError((error) {
      emit(LawyerSendMessageSuccessErrorSatets());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverID)
        .collection('chats')
        .doc(model!.userID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('chat').doc(recieverID).set(
          {'recieverID': recieverID, 'senderID': model!.userID}).then((value) {
        emit(LawyerMakeConnectSuccessSatets());
      });
      emit(LawyerSendMessageSuccessSuccessSatets());
    }).catchError((error) {
      emit(LawyerSendMessageSuccessErrorSatets());
    });
  }

  List<MessageModel> messages = [];
  List<String> recID = [];
  List<String> senderID = [];

  void getMessages({
    required String? recieverID,
  }) {
    emit(LawyerGetMessageSuccessLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('chats')
        .doc(recieverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      recID = [];
      senderID = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(LawyerGetMessageSuccessSuccessSatets());
    });
  }

  List<UsersModel> allUsersChat = [];

  void getAllUsersMessage() {
    emit(LawyerGetAllUsersMessageLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .where('lawyer', isEqualTo: true)
        .snapshots()
        .listen((event) {
      allUsersChat = [];
      event.docs.forEach((element) {
        allUsersChat.add(UsersModel.fromJson(element.data()));
      });

      emit(LawyerGetAllUsersMessageSuccessSatets());
    });
  }

  ConnectModel? connects;
  List<ConnectModel> connectList = [];
  void getChatForLawyer() {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(lawyerID)
        .snapshots()
        .listen((value) {
      connects = ConnectModel.fromJson(value.data()!);
      print('******************** Chat **************************');
      print(value.data());
      emit(LawyerGetConnectSuccessSatets());
    });
  }
}
