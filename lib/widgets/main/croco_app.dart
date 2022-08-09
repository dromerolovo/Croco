import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:croco/croco.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';


void initializeCrocoApp(Widget widget) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(widget);
}

class AppModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [];
}

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