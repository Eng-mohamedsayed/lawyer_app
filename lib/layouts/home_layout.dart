import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text(
          'Lawyer Online',
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
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
                  function: () {},
                  background: mainColor,
                  text: 'ابدا استشارتك مع محامي الان',
                  textColor: Colors.white,
                  textFontSize: 20.sp,
                  width: 300.w,
                  height: 60.h),
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
