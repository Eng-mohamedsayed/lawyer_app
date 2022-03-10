import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/layouts/LegalTexts/legat_texts.dart';
import 'package:lawyer_app/layouts/chat/chat_screen.dart';
import 'package:lawyer_app/layouts/home_layout.dart';
import 'package:lawyer_app/layouts/lawyer_information/lawyer_info.dart';
import 'package:lawyer_app/layouts/laywer_search/lawyer_search.dart';
import 'package:lawyer_app/modules/login/login_screen.dart';
import 'package:lawyer_app/modules/register/lawyer_register.dart';
import 'package:lawyer_app/modules/register/user_register.dart';
import 'package:lawyer_app/modules/start/start_screen.dart';
import 'package:lawyer_app/modules/toggleRegister/toggle_screen.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    //     var height = MediaQuery.of(context).size.height;
    final theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: mainColor,
        ),
      ),
      home: ChatScreen(),
    );
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
