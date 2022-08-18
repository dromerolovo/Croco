import 'package:flutter/material.dart';
import 'package:croco/croco.dart';
import './routes/routes.dart';


const Map<String, Widget> routesAndWidgets = <String,Widget>{
  "/main-view": Main(),
  "/main-view/home": Home(),
  "/main-view/sales-records": SalesRecords(),
  "/main-view/sales-managment": SalesManagment()
};


void main() async {
  initializeCrocoApp(routesAndWidgets, CrocoThemes.vaporwave);
}

