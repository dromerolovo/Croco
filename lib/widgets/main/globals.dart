import 'package:flutter/material.dart';


class Globals {

  //Global Navigators
  static GlobalKey<NavigatorState> mainNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> mainViewNavigator = GlobalKey<NavigatorState>();

  static Map<String, Widget> routesAndWidget = <String, Widget>{};

}