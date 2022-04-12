import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/layouts/chat/chat_bot.dart';
import 'package:lawyer_app/layouts/users/home_layout.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer_app/layouts/users/laywer_search/lawyer_details.dart';
import 'package:lawyer_app/modules/login/loginCubit/login_cubit.dart';

import 'package:lawyer_app/modules/login/loginCubit/login_states.dart';
import 'package:lawyer_app/modules/login/login_screen.dart';
import 'package:lawyer_app/modules/register/lawyer_register.dart';
import 'package:lawyer_app/modules/register/user_register.dart';
import 'package:lawyer_app/modules/start/start_screen.dart';
import 'package:lawyer_app/modules/toggleRegister/toggle_screen.dart';
import 'package:lawyer_app/shared/components/constants.dart';
import 'package:lawyer_app/shared/network/bloc_observer.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/user_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CasheHelper.init();
  Widget widget;

  userID = CasheHelper.getData(key: 'uID');

  lawyerID = CasheHelper.getData(key: 'laywerID');

  print(userID);
  print(lawyerID);

  // if (userID!=''||userID.isNotEmpty) {
  //   widget = HomeLayout();
  // } else if(lawyerID != '' || lawyerID.isNotEmpty){
  //   widget = LawyerLayout();

  // }else{
  //   widget = LoginScreen();

  // // }
  if (userID != '' && userID != null) {
    widget = HomeLayout();
  } else {
    if (lawyerID != '' && lawyerID != null) {
      widget = LawyerLayout();
    } else {
      widget = LoginScreen();
    }
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    //     var height = MediaQuery.of(context).size.height;
    final theme = ThemeData();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LawyerCubits()
                ..getUserData()
                ..getAllUsersMessage())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: mainColor,
            ),
          ),
          home: startWidget,
       
        ));
  }
}

// return ScreenUtilInit(
//      designSize: Size(width, height),
//      builder: () {
//        return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const StartScreen(),
//       );
//      },
//    );
