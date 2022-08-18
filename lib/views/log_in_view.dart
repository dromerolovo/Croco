import 'package:croco/croco.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../widgets/forms/croco_forms.dart';

class LogInView extends ConsumerStatefulWidget {
  LogInView({
    Key? key,
    this.imagePath,
    this.logInForm,
    this.routesAndWidget
    }) : super(key: key);

    String? imagePath;
    Widget? logInForm;
    Map<String, Widget>? routesAndWidget;

  @override
  ConsumerState<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {

  @override
  void initState() {
    Future.delayed(Duration.zero, (() {
    }));
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                alignment: Alignment.center,
                child: widget.logInForm  != null ? widget.logInForm : LogInForm()
                )
              ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                alignment: Alignment.center,
                child: Image.asset(
                  widget.imagePath ?? CrocoTheme.of(context)!.themeDataExtra!.logInImage!,
                  width: 500
                )
              )
            )
          ]
        )
      ),
    );
  }
}