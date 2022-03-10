import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/styles/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:lawyer_app/shared/widgets/footer.dart';

class LawyerSearch extends StatelessWidget {
  const LawyerSearch({Key? key}) : super(key: key);

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
      backgroundColor: Colors.grey[300],
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
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
                child: Text(
              'ابدا استشارتك مع محامي الان',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                    prefixIcon: Icon(Icons.list),
                    hintText: 'ابحث بالاسم',
                    contentPadding: EdgeInsets.all(10),
                  )),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.list),
                          hintText: 'ابحث بالتخصص',
                          contentPadding: EdgeInsets.all(10))),
                ),
              ],
            ),
     
           const SizedBox(
              height: 40,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1 / 0.8,
                    crossAxisCount: 2,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'الاسم',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'التخصص',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RatingBar(
                                    itemSize: 8,
                                    initialRating: 3,
                                    minRating: 1,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2),
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
                      ),
                    );
                  }),
            ),
       
       
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
