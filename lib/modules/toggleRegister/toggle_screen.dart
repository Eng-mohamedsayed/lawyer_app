import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/modules/register/lawyer_register.dart';
import 'package:lawyer_app/modules/register/user_register.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/footer.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'انشاء حساب',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              defaultButton(
                  background: mainColor,
                  function: () {
                    navigateTo(context, LawyerRegister());
                  },
                  text: 'محامى',
                  textFontSize: 22.sp,
                  textColor: Colors.white,
                  width: 150.w,
                  height: 50.h),
              SizedBox(height: ScreenUtil().setHeight(20)),
              defaultButton(
                  background: mainColor,
                  function: () {
                    navigateTo(context, UserRegister());
                  },
                  text: 'مستخدم',
                  textFontSize: 22.sp,
                  textColor: Colors.white,
                  width: 150.w,
                  height: 50.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
