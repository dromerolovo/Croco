import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:croco/croco.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main/globals.dart';



void initializeCrocoApp(Map<String, Widget> routesAndWidgets, CrocoThemes crocoTheme) async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  Globals.routesAndWidget = routesAndWidgets;

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(CrocoApp(
    crocoTheme: crocoTheme,
    routesAndWidgets: routesAndWidgets,
  ));
}

class CrocoApp extends ConsumerStatefulWidget {
  CrocoApp({
    Key? key,
    required this.crocoTheme,
    required this.routesAndWidgets,

    }) : super(key: key);

    CrocoThemes crocoTheme;
    Map<String, Widget> routesAndWidgets;

  @override
  ConsumerState<CrocoApp> createState() => _CrocoAppState();
}

class _CrocoAppState extends ConsumerState<CrocoApp> {

  String initialRouteString() {

    late String route;

    var firebaseAuthState = FirebaseAuth.instance.currentUser;
    if(firebaseAuthState != null) {
      route = "/main-view";
    } else if(firebaseAuthState == null) {
      route = "/log-in";
    } else {
      throw("Unknown route");
    }

    return route;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    

    //Debugging purposes
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Globals.mainNavigator.currentState!.popUntil((route) {
        print("Main Route -> ${route.settings.name}");
        return true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: ProviderScope(
        child: CrocoTheme(
          themeDataExtra: widget.crocoTheme.themeExtra,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'croco',
            theme: widget.crocoTheme.theme,
            navigatorKey: Globals.mainNavigator,
            initialRoute: initialRouteString(),
            routes: {
              '/log-in': (context) => LogInView(logInForm: LogInForm()),
              '/main-view': (context) => widget.routesAndWidgets["/main-view"]!,
              '/': (context) => const Center(child: CircularProgressIndicator())
            }
          )
        )
      )
    );
  }
}
