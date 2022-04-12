import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/models/message_model.dart';
import 'package:lawyer_app/models/user_model.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class ChatMessages extends StatefulWidget {
  UsersModel model;
  ChatMessages({Key? key, required this.model}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LawyerCubits.get(context).getMessages(recieverID: widget.model.userID);
  }

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
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.model.photo.toString()),
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        '${widget.model.username}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
                      (LawyerCubits.get(context).messages.length > 0 &&
                              state is! LawyerGetMessageSuccessLoadingStates)
                          ? Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var message = LawyerCubits.get(context)
                                        .messages[index];
                                    if (LawyerCubits.get(context)
                                            .model!
                                            .userID ==
                                        message.senderID) {
                                      return buildMyMessage(message);
                                    } else {
                                      return buildMessage(message);
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                  itemCount: LawyerCubits.get(context)
                                      .messages
                                      .length))
                          : const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextFormField(
                                    controller: messageController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'اكتب الان'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),

                            InkWell(
                              onTap: () {
                                LawyerCubits.get(context).sendMessage(
                                    recieverID: widget.model.userID,
                                    dateTime: DateTime.now().toString(),
                                    message: messageController.text.trim());
                                messageController.text = '';
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: mainColor,
                                child: const Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
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
        });
  }

  Widget buildMessage(MessageModel messageModel) {
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
        child: Text('${messageModel.message}'),
      ),
    );
  }

  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text(
          '${messageModel.message}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
