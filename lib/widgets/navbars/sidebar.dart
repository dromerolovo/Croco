import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/main/globals.dart';
import '../../themes/themes.dart';



class HeaderSimpleSideBar extends ConsumerWidget {
  HeaderSimpleSideBar({
    Key? key,
    String? this.text = "HEADER",
    Color? this.color = Colors.white,
    double? this.internalProcessOp,
    }) : super(key: key);

    String? text;
    Color? color;
    double? internalProcessOp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      padding: EdgeInsets.only(bottom: 16),
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 240
        ),
        child: Row(
          children: [
            SelectableText(
              text!,
              style: TextStyle(
                color: color
              )
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 15),
                transform: Matrix4.translationValues(0, 1, 0),
                height: 1,
                color: Colors.white,
              ),
            )
          ]
        ),
      )
    );
  }
}

class SimpleItemSideBar extends ConsumerWidget {
  SimpleItemSideBar({
    Key? key,
    this.title = "Sales Record",
    this.fontColor = Colors.white,
    this.icon,
    this.backgroundColor,
    this.route
    }) : 
    super(key: key);

    String? title;
    Color? fontColor;
    Icon? icon;
    Color? backgroundColor;
    String? route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
      child: ListTile(
        leading: icon != null ? icon : null,
        dense: true,
        onTap: (){
          Globals.mainViewNavigator.currentState!.pushReplacementNamed(route!);
        },
        hoverColor: CrocoTheme.of(context)!.themeDataExtra!.onHoverOnSurfaceVariant,
        title: Container(
          transform: icon != null ? Matrix4.translationValues(-8, 0, 0) : null,
          padding: icon != null ? EdgeInsets.only() : EdgeInsets.only(left: 5),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: fontColor ?? CrocoTheme.of(context)!.themeDataExtra!.textColor
            )
          ),
        )
      ),
    );
  }
}

class HigherItemSideBar extends StatelessWidget {
  HigherItemSideBar({
    Key? key,
    String? this.title,
    Color? this.fontColor,
    List<SimpleItemSideBar>? this.childrenList,
    Color? this.iconColor = Colors.white,
    Icon? this.icon
    }) : 
    super(key: key);

    String? title;
    Color? fontColor;
    Icon? icon;
    List<SimpleItemSideBar>? childrenList;
    Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[700],
      child: ExpansionTile(
        collapsedIconColor: iconColor,
        iconColor: iconColor,
        leading: icon,
        title:Container(
          transform: icon != null ? Matrix4.translationValues(-8, 0, 0) : null,
          padding: icon != null ? EdgeInsets.only() : EdgeInsets.only(left: 5),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: fontColor ?? CrocoTheme.of(context)!.themeDataExtra!.textColor,
            )
          )
        ),
        children: [
          for(var children in childrenList!) children
        ],
      )
    );
  }
}


class SimpleSideBar extends StatefulWidget {
  SimpleSideBar({
    Key? key,
    Color? this.backgroundColor,
    Color? this.fontColor,
    List<Widget>? this.childrenList,
    String? this.mainTitleText = "Navigation Menu"

    }) : super(key: key);

    Color? backgroundColor;
    Color? fontColor;
    List<Widget>? childrenList;
    String? mainTitleText;

  @override
  State<SimpleSideBar> createState() => _SimpleSideBarState();
}

class _SimpleSideBarState extends State<SimpleSideBar> {

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints:  BoxConstraints(
        maxWidth: 250,
        maxHeight: MediaQuery.of(context).size.height
      ),
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
      height: double.infinity,
      width: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            alignment: Alignment.centerLeft,
            child: SelectableText(
              widget.mainTitleText!,
              style: TextStyle(
                color: CrocoTheme.of(context)!.themeDataExtra!.onSurfaceVariant,
                fontWeight: FontWeight.w300
              )
            )
          ),
          Expanded(
            child: ListView(
              children:[
                for(var item in widget.childrenList!) item
              ]
            ),
          )
        ]
      )
      
    );
  }
}