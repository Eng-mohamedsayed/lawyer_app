import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
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
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextField(
                      prefixIcon: Icons.person,
                      borderColor: mainColor,
                      hintText: 'البريد الالكترونى أو رقم الهاتف',
                    ),
                    SizedBox(height: ScreenUtil().setWidth(20)),
                    defaultTextField(
                      borderColor: mainColor,
                      prefixIcon: Icons.lock,
                      hintText: 'كلمة السر',
                    ),
                    SizedBox(height: ScreenUtil().setWidth(20)),
                    Text(
                      'نسيت كلمة السر؟',
                      style: TextStyle(fontSize: 20.sp, color: mainColor),
                    )
                  ],
                ),
              ),
              defaultButton(
                  background: mainColor,
                  textColor: Colors.white,
                  function: () {},
                  text: 'تسجيل الدخول',
                  textFontSize: 20.sp,
                  width: 150.w,
                  height: 40.h),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ' لست مشترك؟',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'اشترك الان',
                      style: TextStyle(fontSize: 20.sp, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
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
  }
}
