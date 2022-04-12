// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/layouts/users/home_layout.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer_app/models/user_model.dart';
import 'package:lawyer_app/modules/login/loginCubit/login_cubit.dart';
import 'package:lawyer_app/modules/login/loginCubit/login_states.dart';
import 'package:lawyer_app/modules/register/lawyer_register.dart';
import 'package:lawyer_app/modules/register/user_register.dart';
import 'package:lawyer_app/modules/toggleRegister/toggle_screen.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

import '../../shared/components/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final GlobalKey<ScaffoldState> loginKey = GlobalKey<ScaffoldState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    UsersModel? checkModel;

    ScreenUtil.init(
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        designSize: Size(width, height),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return BlocProvider(
      create: (context) => LoginCubits(),
      child: BlocConsumer<LoginCubits, LoginStates>(
        listener: (context, state) {
          if (state is LoginUserSuccessStates) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(state.uID)
                .snapshots()
                .listen((event) {
              checkModel = UsersModel.fromJson(event.data()!);
              CasheHelper.removeData(key: 'uID');
              CasheHelper.removeData(key: 'laywerID');

              if (checkModel!.lawyer == true) {
                CasheHelper.saveData(key: 'laywerID', value: checkModel!.userID)
                    .then((value) {
                          setState(() {
                    lawyerID = CasheHelper.getData(key: 'laywerID');
                  });
                  CasheHelper.removeData(key: 'uID').then((value) {

                    navigateAndFinish(context, LawyerLayout());
                  });

              

                });
              } else {
                CasheHelper.saveData(key: 'uID', value: state.uID)
                    .then((value) {
                              setState(() {
                    userID = CasheHelper.getData(key: 'uID');
                  });
                  CasheHelper.removeData(key: 'laywerID').then((value) {
                    navigateAndFinish(context, HomeLayout());
                  });
          
                 
                });
              }
            });
          } else if (state is LoginUserErrorStates) {
            LoginScreen.loginKey.currentState!
                .showSnackBar(SnackBar(content: Text('${state.errMsg}')));
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubits.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Lawyer Online',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: LoginScreen.formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image.asset(
                            'assets/images/start.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 20.w),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: mainColor,
                              child: const Icon(
                                Ionicons.ios_arrow_up,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultTextField(
                              controller: LoginScreen.emailController,
                              prefixIcon: Icons.person,
                              borderColor: mainColor,
                              hintText: 'البريد الالكترونى ',
                            ),
                            SizedBox(height: ScreenUtil().setWidth(20)),
                            defaultTextField(
                              controller: LoginScreen.passwordController,
                              borderColor: mainColor,
                              prefixIcon: Icons.lock,
                              hintText: 'كلمة السر',
                            ),
                            SizedBox(height: ScreenUtil().setWidth(20)),
                            Text(
                              'نسيت كلمة السر؟',
                              style:
                                  TextStyle(fontSize: 20.sp, color: mainColor),
                            )
                          ],
                        ),
                      ),
                      state is! LoginUserLoadingStates
                          ? defaultButton(
                              background: mainColor,
                              textColor: Colors.white,
                              function: () {
                                if (LoginScreen.formKey.currentState!
                                    .validate()) {
                                  loginCubit.loginUser(
                                      email: LoginScreen.emailController.text
                                          .trim(),
                                      password: LoginScreen
                                          .passwordController.text
                                          .trim());
                                }
                              },
                              text: 'تسجيل الدخول',
                              textFontSize: 20.sp,
                              width: 150.w,
                              height: 40.h)
                          : Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ' لست مشترك؟',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                navigateTo(context, ToggleScreen());
                              },
                              child: Text(
                                'اشترك الان',
                                style: TextStyle(
                                    fontSize: 20.sp, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 32,
                  ),
                  defaultButton(
                      background: mainColor,
                      textColor: Colors.white,
                      function: () {},
                      text: 'الرجوع',
                      textFontSize: 20.sp,
                      width: 140.w,
                      height: 40.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
