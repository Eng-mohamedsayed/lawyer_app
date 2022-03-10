import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:lawyer_app/shared/widgets/footer.dart';

class LawyerInformation extends StatelessWidget {
  const LawyerInformation({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'اسم المحامي',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'الوصف',
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'سنوات الخبرة',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'عام',
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'التخصصات',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '--------',
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'مواعيد التفرغ',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '--------',
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          //Use Background Image Instead of Child
                          //Example -->  // backgroundImage: NetworkImage(''),
                          radius: 50,
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar(
                            itemSize: 16,
                            initialRating: 3,
                            minRating: 1,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2),
                            ratingWidget: RatingWidget(
                                full: const Icon(
                                  EvaIcons.star,
                                  color: Colors.amber,
                                ),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                ),
                                empty: const Icon(
                                  EvaIcons.starOutline,
                                  color: Colors.grey,
                                )),
                            onRatingUpdate: (rating) {
                              print(rating);
                            })
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: mainColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: const [
                            Text(
                              '15 دقيقة',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '50 ج.م',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: mainColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: const [
                            Text(
                              '30 دقيقة',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '75 ج.م',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: mainColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: const [
                            Text(
                              '60 دقيقة',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '100 ج.م',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.w,
                ),
                Row(
                  children: [
                    defaultButton(
                        function: () {},
                        background: mainColor,
                        text: 'اختر طريقة الدفع',
                        textColor: Colors.white,
                        textFontSize: 20.sp,
                        width: 180.w,
                        height: 60.h),
                    SizedBox(
                      width: 20.w,
                    ),
                    defaultButton(
                        function: () {},
                        background: mainColor,
                        text: 'احجز الان',
                        textColor: Colors.white,
                        textFontSize: 20.sp,
                        width: 110.w,
                        height: 60.h),
                  ],
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
