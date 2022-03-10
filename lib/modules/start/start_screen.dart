import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/start.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'حل مشكلتك مع محامى بضغطة زر الان',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
                FloatingActionButton(
                  backgroundColor: mainColor,
                  onPressed: () {},
                  child: const Icon(Ionicons.ios_arrow_down),
                )
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
