import 'package:croco/croco.dart';
import 'package:flutter/material.dart';
import '../widgets/forms/croco_forms.dart';

class LogInView extends StatefulWidget {
  LogInView({
    Key? key,
    this.imagePath,
    this.logInForm,
    this.widgetToRouting
    }) : super(key: key);

    String? imagePath;
    Widget? logInForm;
    Widget? widgetToRouting;

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              alignment: Alignment.center,
              child: widget.logInForm  != null ? widget.logInForm : LogInForm(widgetToRouting: widget.widgetToRouting,)
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
    );
  }
}