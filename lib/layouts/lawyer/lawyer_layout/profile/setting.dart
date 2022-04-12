import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/profile/edit_lawyer_profile.dart';
import 'package:lawyer_app/modules/login/login_screen.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController yearsController = TextEditingController();
  TextEditingController datesController = TextEditingController();
  TextEditingController infoController = TextEditingController();

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

        yearsController.text = cubit.model!.yearsExp!.isNotEmpty
            ? cubit.model!.yearsExp.toString()
            : '';
        datesController.text =
            cubit.model!.dates!.isNotEmpty ? cubit.model!.dates.toString() : '';
        infoController.text =
            cubit.model!.info!.isNotEmpty ? cubit.model!.info.toString() : '';

        return Scaffold(
            body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: mainColor,
                        backgroundImage: cubit.model!.photo!.isNotEmpty
                            ? NetworkImage(cubit.model!.photo!.toString())
                            : NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvPW4n2sq5EZhgjLF3U0iEZAMfkAE-J0nOA&usqp=CAU')
                                as ImageProvider,
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.blueAccent,
                      //     border: Border.all(
                      //         color: Colors.blueAccent,
                      //         width: 50.0,
                      //         style: BorderStyle.solid),
                      //     image: DecorationImage(
                      //         fit: BoxFit.cover,
                      //         image: cubit.model!.photo!.isNotEmpty ||
                      //                 cubit.model!.photo != ''
                      //             ? NetworkImage(cubit.model!.photo!)
                      //             : AssetImage('assets/images/start.jpg')
                      //                 as ImageProvider),
                      //   ),

                      Text(
                        cubit.model!.username.toString(),
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  // TextField(

                  //     controller: infoController,
                  //     decoration: const InputDecoration(
                  //       hintText: 'ابحث بالاسم',
                  //       contentPadding: EdgeInsets.all(10),
                  //     )),
                  defaultTextField(
                      read: true,
                      maxLength: 6,
                      controller: infoController,
                      borderColor: mainColor,
                      labelText: Text(
                        'نبذة عنك',
                        style: TextStyle(fontSize: 22, color: mainColor),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultTextField(
                      read: true,
                      controller: yearsController,
                      borderColor: mainColor,
                      labelText: Text(
                        'سنوات الخبرة',
                        style: TextStyle(fontSize: 22, color: mainColor),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultTextField(
                    read: true,
                    controller: datesController,
                    maxLength: 3,
                    borderColor: mainColor,
                    labelText: Text('مواعيد التفرغ',
                        style: TextStyle(fontSize: 22, color: mainColor)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultButton(
                      background: mainColor,
                      height: 50.h,
                      function: () {
                        navigateTo(context, EditLawyerProfile());
                      },
                      text: 'تعديل الملف الشخصى',
                      textColor: Colors.white,
                      textFontSize: 18,
                      width: 200.w),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
