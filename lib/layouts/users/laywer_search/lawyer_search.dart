import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_information/lawyer_info.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/profile/setting.dart';
import 'package:lawyer_app/layouts/users/chat/chat_screen.dart';
import 'package:lawyer_app/layouts/users/laywer_search/lawyer_details.dart';

import 'package:lawyer_app/shared/components/components.dart';
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

    return BlocConsumer<LawyerCubits, LawyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LawyerCubits.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  LawyerCubits.get(context).searchList = [];
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
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
                SizedBox(
                  height: 20.h,
                ),
                Center(
                    child: Text(
                  'ابدا استشارتك مع محامي الان',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                          onSubmitted: (String value) {
                            cubit.serachByName(username: value);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.list),
                            hintText: 'ابحث بالاسم',
                            contentPadding: EdgeInsets.all(10),
                          )),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                          onSubmitted: (String value) {
                            cubit.serachByCat(category: value);
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.list),
                              hintText: 'ابحث بالتخصص',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                cubit.searchList.length > 0
                    ? Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 2,
                              childAspectRatio: 1 / 0.8,
                              crossAxisCount: 2,
                            ),
                            itemCount: cubit.searchList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      LawyerDetails(
                                        model: cubit.searchList[index],
                                      ));
                                  // navigateTo(
                                  //     context,
                                  //     LawyerInformation(
                                  //       index: index,
                                  //     ));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${cubit.searchList[index].username}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                '${cubit.searchList[index].category}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
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
                                ),
                              );
                            }),
                      )
                    : const Center(
                        child: Text('لا توجد نتائج'),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: const Footer(),
        );
      },
    );
  }
}
