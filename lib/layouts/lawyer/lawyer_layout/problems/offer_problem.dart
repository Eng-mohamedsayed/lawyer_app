import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/models/problems_model.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class OfferScreen extends StatefulWidget {
  ProblemsModel problemsModel;
  String probID;

  OfferScreen({Key? key, required this.problemsModel, required this.probID})
      : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController offerController = TextEditingController();

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LawyerCubits.get(context).getOffers(probID: widget.probID);
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
      listener: (context, state) {
    
      },
      builder: (context, state) {
        var cubit = LawyerCubits.get(context);

        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('قدم عرضك'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: OfferScreen.formKey,
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
                        cubit.allOffers.isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                  itemCount: cubit.allOffers.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (state is! LawyerGetOfferLoadingStates) {
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
                                                            .allOffers[index]
                                                            .profileImage
                                                            .toString()),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    cubit.allOffers[index]
                                                        .username
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    cubit.allOffers[index]
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
                                              Text(cubit.allOffers[index].offer
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
                            : const Expanded(
                                child: Center(
                                  child: Text(
                                    'لا توجد عروض',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: defaultTextField(
                                controller: OfferScreen.offerController,
                                borderColor: mainColor,
                                hintText: 'اضف عرضك',
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.addOffer(
                                    offer:
                                        OfferScreen.offerController.text.trim(),
                                    uID: widget.problemsModel.userID!,
                                    probID: widget.probID,
                                    category: cubit.model!.category,
                                    username: cubit.model!.username,
                                    profileImage: cubit.model!.photo);
                              },
                              child: CircleAvatar(
                                backgroundColor: mainColor,
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ));
      },
    );
  }
}
