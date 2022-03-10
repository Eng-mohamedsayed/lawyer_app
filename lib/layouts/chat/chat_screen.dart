import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
          title: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'المحامي',
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.cancel,
                size: 36,
              ),
            ),
          ],
          backgroundColor: mainColor,
          elevation: 0.0,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildMessage();
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15.h,
                            ),
                        itemCount: 1)),
                Spacer(),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'اكتب الان'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      CircleAvatar(
                        radius: 25,
                        backgroundColor: mainColor,
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: mainColor,
                      //       ),
                      //       color: mainColor,
                      //       borderRadius: BorderRadius.circular(100)),
                      //   child: MaterialButton(
                      //     onPressed: () {},
                      //     minWidth: 1,
                      //     child: const Icon(
                      //       EvaIcons.messageSquare,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildMessage() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text(
          'مرحبا بك كيف استطيع مساعدتك',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  Widget buildMyMessage() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: const Text(
          'السلام عليكم',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
