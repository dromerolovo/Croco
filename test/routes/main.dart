import 'package:flutter/material.dart';
import 'package:croco/croco.dart';



class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainView(
          simpleSideBar: SimpleSideBar(
            childrenList: [
              HeaderSimpleSideBar(
                text: "Croco Sales",
              ),
              SimpleItemSideBar(
                route: "/main-view/home",
                title: "Home",
              ),
              SimpleItemSideBar(
                route: "/main-view/sales-records",
              ),
              SimpleItemSideBar(
                title: "Sales Managment",
                route: "/main-view/sales-managment",
              )
            ],
          ),
        )
      )
    );
  }
}

