import 'dart:ui';

import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class DescriptionText extends StatefulWidget {
  DescriptionText({
    Key? key,
    this.textList
    }) : super(key: key);

    List<String>? textList;

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {

  Size? parentWidth;
  static const  double _fontSize = 16;
  List<Container> listOfTextBuckets = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  List<Container> preProcessor(List<String> textList) {
    
    List<Container> listOfTextBuckets = [];
    int count = 0;

    for (var text in textList) {
      count++;
      listOfTextBuckets.add(
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SelectableText(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              height: 1.3,
              color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
              fontWeight: FontWeight.w300
            )
          )
        )
      );
    }

    return listOfTextBuckets;
    
  }

  @override
  Widget build(BuildContext context) {
    listOfTextBuckets = preProcessor(widget.textList!);
    return Container(
      child: Column(
        children: [
          for(var textBucket in listOfTextBuckets) textBucket
        ]
      )
    );
  }
}


class DescriptionPanelHeader extends StatelessWidget {
  DescriptionPanelHeader({
    Key? key,
    this.headerText
    }) : super(key: key);

    String? headerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 17),
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment.topLeft,
          child: SelectableText(
            headerText!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24
            )
          )
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 8, right: 15),
          color: CrocoTheme.of(context)!.themeDataExtra!.onSurface,
          height: 0.7
        ),
      ],
    );
  }
}

class DescriptionPanel extends StatefulWidget {
  DescriptionPanel({
    Key? key,
    this.children
    }) : super(key: key);

    List<Widget>? children;

  @override
  State<DescriptionPanel> createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<DescriptionPanel> {

  GlobalKey _globalKey = GlobalKey();
  double? height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      height = _globalKey.currentContext!.size!.height;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          key: _globalKey,
          padding: EdgeInsets.only(bottom: 15),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for(var widget in widget.children!) widget
              ],
            )
          ),
        );
      }
    );
  }
}