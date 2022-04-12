import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer_app/layouts/users/home_layout.dart';
import 'package:lawyer_app/modules/login/login_screen.dart';
import 'package:lawyer_app/shared/components/components.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';

class LawyerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          InkWell(
              onTap: () {
                navigateTo(context, LawyerLayout());
              },
              child:
                  createDrawerBodyItem(icon: EvaIcons.home, text: 'الرئيسية')),
          InkWell(
            onTap: () {
              // navigateTo(context, HomeLayout());
            },
            child: createDrawerBodyItem(
                icon: EvaIcons.messageCircleOutline, text: 'المحادثات'),
          ),
          Divider(),
          InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  CasheHelper.removeData(key: 'laywerID');
                  CasheHelper.removeData(key: 'uID');

                  navigateTo(context, LoginScreen());
                });
              },
              child: createDrawerBodyItem(
                  icon: EvaIcons.logOut, text: 'تسجيل الخروج')),
        ],
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text.toString()),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
