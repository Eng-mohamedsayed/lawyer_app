import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/layouts/users/chat/chat_screen.dart';
import 'package:lawyer_app/models/problems_model.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class UserOffersScreen extends StatefulWidget {
  ProblemsModel problemsModel;
  String probID;

  UserOffersScreen(
      {Key? key, required this.problemsModel, required this.probID})
      : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController offerController = TextEditingController();

  @override
  State<UserOffersScreen> createState() => _UserOffersScreenState();
}

class _UserOffersScreenState extends State<UserOffersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LawyerCubits.get(context).getUserOffers(probID: widget.probID);
  }

  @override
  Widget build(BuildContext context) {
    @override
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

        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('العروض'),
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
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: UserOffersScreen.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.problemsModel.title.toString(),
                                  style: TextStyle(
                                      color: Colors.blue[900], fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  widget.problemsModel.desc.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        cubit.myOffers.isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                  itemCount: cubit.myOffers.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (state
                                        is! LawyerGetUserOffersLoadingStates) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: mainColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[200]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: mainColor,
                                                    backgroundImage:
                                                        NetworkImage(cubit
                                                            .myOffers[index]
                                                            .profileImage
                                                            .toString()),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    cubit.myOffers[index]
                                                        .username
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    cubit.myOffers[index]
                                                        .category
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(cubit.myOffers[index].offer
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: mainColor,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            : const Center(
                                child: Text(
                                  'لا توجد عروض',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                ),
              ),
            ));
      },
    );
  }
}
