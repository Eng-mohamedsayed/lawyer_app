import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/footer.dart';

class LawyerRegister extends StatelessWidget {
  const LawyerRegister({Key? key}) : super(key: key);

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
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'انشاء حساب كمحامى',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextField(
                        iconColor: mainColor,
                        borderColor: mainColor,
                        hintText: 'اسم المستخدم',
                        suffixIcon: Icons.person,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      defaultTextField(
                        iconColor: mainColor,
                        borderColor: mainColor,
                        hintText: 'البريد الالكتروني',
                        suffixIcon: Icons.email,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      defaultTextField(
                        iconColor: mainColor,
                        borderColor: mainColor,
                        hintText: 'رقم الهاتف',
                        suffixIcon: Icons.phone,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      defaultTextField(
                        iconColor: mainColor,
                        borderColor: mainColor,
                        hintText: 'كلمة السر',
                        suffixIcon: Icons.lock,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      defaultTextField(
                        iconColor: mainColor,
                        borderColor: mainColor,
                        hintText: 'تأكيد كلمة السر ',
                        suffixIcon: Icons.lock,
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Container(
                        width: 200.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                            border: Border.all(color: mainColor)),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('رفع ملف ال cv',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22.sp),
                                  textAlign: TextAlign.center),
                              SizedBox(
                                width: 15.w,
                              ),
                              const Icon(Icons.file_upload_outlined),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      defaultButton(
                          background: mainColor,
                          function: () {},
                          text: 'انشاء حساب جديد',
                          textFontSize: 22.sp,
                          textColor: Colors.white,
                          width: 200.w,
                          height: 50.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
