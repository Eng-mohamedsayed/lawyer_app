import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/layouts/users/chat/chat_screen.dart';
import 'package:lawyer_app/layouts/users/laywer_search/lawyer_search.dart';
import 'package:lawyer_app/layouts/users/user_problems/user_problem.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/components/constants.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/user_drawer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = CasheHelper.getData(key: 'uID');
    print('*********************************************');
    print(userID);
    print('*********************************************');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
        BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        designSize: Size(width, height),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        title: Text(
          'Lawyer Online',
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
           actions: [
          InkWell(
            onTap: () {
              navigateTo(context, ChatScreen());
            },
            child: const Icon(
              EvaIcons.messageCircleOutline,
              size: 32,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultButton(
                  function: () {
                    navigateTo(context, LawyerSearch());
                  },
                  background: mainColor,
                  text: 'ابدا استشارتك مع محامي الان',
                  textColor: Colors.white,
                  textFontSize: 20.sp,
                  width: 300.w,
                  height: 60.h),
              const SizedBox(
                height: 30,
              ),
              defaultButton(
                  function: () {},
                  background: mainColor,
                  text: 'نصوص ومواد قانونية',
                  textColor: Colors.white,
                  textFontSize: 20.sp,
                  width: 300.w,
                  height: 60.h),
              const SizedBox(
                height: 30,
              ),
              defaultButton(
                  function: () {
                    navigateTo(context, UserProblems());
                  },
                  background: mainColor,
                  text: 'اعرض مشكلتك الان',
                  textColor: Colors.white,
                  textFontSize: 20.sp,
                  width: 300.w,
                  height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
