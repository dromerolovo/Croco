import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:croco/croco.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../themes/themes.dart';

class CrocoApp extends StatelessWidget {
  CrocoApp({
    Key? key,
    required this.crocoTheme,
    required this.home

    }) : super(key: key);

    CrocoThemes crocoTheme;
    Widget home;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: ProviderScope(
        child: CrocoTheme(
          themeDataExtra: crocoTheme.themeExtra,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'croco',
            theme: crocoTheme.theme,
            home: home
          )
        )
      )
    );
  }
}