import 'package:flutter/material.dart';
import 'package:lawyer_app/cubit/cubit.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/problems/problems_screen.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/reservations.dart';
import 'package:lawyer_app/layouts/lawyer/lawyer_layout/profile/setting.dart';
import 'package:lawyer_app/shared/components/constants.dart';
import 'package:lawyer_app/shared/network/local/cashe_helper.dart';
import 'package:lawyer_app/shared/widgets/lawyer_drawer.dart';

class LawyerLayout extends StatefulWidget {
  @override
  State<LawyerLayout> createState() => _LawyerLayoutState();
}

class _LawyerLayoutState extends State<LawyerLayout> {
  @override
  void initState() {
    super.initState();
    LawyerCubits.get(context).getLawyerData();
    lawyerID = CasheHelper.getData(key: 'laywerID');
    print('*********************************************');
    print(lawyerID);
    print('*********************************************');

    LawyerCubits.get(context).getChatForLawyer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: LawyerDrawer(),
          appBar: AppBar(
            title: const Text('Lawyer Online'),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.contacts), text: "Problems"),
                Tab(icon: Icon(Icons.settings), text: "Setting")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ProblemScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
