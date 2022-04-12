import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/cubit/states.dart';
import 'package:lawyer_app/layouts/users/chat/chat_messages.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/styles/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        var cubit = LawyerCubits.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('جميع المحامين'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigateTo(context,
                            ChatMessages(model: cubit.allUsersChat[index]));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: mainColor,
                            backgroundImage: NetworkImage(
                                cubit.allUsersChat[index].photo.toString()),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            cubit.allUsersChat[index].username.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: mainColor,
                      ),
                  itemCount: cubit.allUsersChat.length)),
        );
      },
    );
  }
}

/*

 Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: mainColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Mohamed Sayed',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
*/