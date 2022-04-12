import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/layouts/users/chat/chat_screen.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/footer.dart';

class LegalTextsScreen extends StatelessWidget {
  List<String> titles = [
    "الدستور المصري",
    "قانون الاثبات",
    "قانون الجنسية",
    "قانون العقوبات",
    "قانون المدنى",
    "قانون المرافعات",
    "قانون حماية المنافسة ومنع الممارسة الاحتكارية"
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool val = false;
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
      backgroundColor: Colors.grey[200],
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.w),
              child: Center(
                child: Text(
                  'النصوص القانونية المصرية',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1 / 0.6,
                    crossAxisCount: 2,
                  ),
                  itemCount: titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: mainColor,
                              activeColor: Colors.red,
                              value: val,
                              onChanged: (value) {},
                            ),
                            Flexible(
                                child: Text(
                              titles[index],
                              style: TextStyle(fontSize: 18.sp),
                            ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            defaultButton(
                function: () {},
                background: mainColor,
                text: 'اذهب',
                textColor: Colors.white,
                textFontSize: 20.sp,
                width: 150.w,
                height: 60.h),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
