import 'dart:html';
import 'package:croco/croco.dart';
import 'package:croco/providers/firebase/firebase_data.dart';
import 'package:croco/providers/firebase/utils.dart';
import 'package:flutter/material.dart';
import '../croco_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainView extends ConsumerStatefulWidget {
  MainView({
    Key? key,
    Widget? this.logo,
    Color? this.colorHeader,
    Color? this.colorBackground,
    required SimpleSideBar this.simpleSideBar,
    Widget? this.viewChild,
    Color? this.colorIcon,
    }) : super(key: key);

    Widget? logo;
    Color? colorHeader;
    Color? colorBackground;
    SimpleSideBar? simpleSideBar;
    Widget? viewChild;
    Color? colorIcon;

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> with CrocoBase, SingleTickerProviderStateMixin {


  bool? breakPointActivation = false;
  bool? toggleMenu = false;


  @override
  Widget build(BuildContext context) {
    return NotificationListener<BreakpointsNotification>(
      onNotification: (notification) {
        Future.delayed(Duration.zero, (() {
          setState(() {
          });
        }));
        return true;
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              color: widget.colorBackground ?? Theme.of(context).colorScheme.background
            ),
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  color: widget.colorHeader?? Theme.of(context).colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400]!,
                      width: 0.35,
                    )
                  )
                ),
                child: Row(
                  children: [
                    CrocoWidgetNotifier(
                      null,
                      BreakPoints.Xmedium,
                      breakPointActivation,
                      (val) => 
                        Future.delayed(Duration(milliseconds: 500), (() {
                          setState(() {
                            breakPointActivation = val;
                          });
                        }))
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: breakPointActivation == true ? Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              toggleMenu = true;
                            });
                          }),
                          child: Icon(
                            Icons.menu,
                            color: widget.colorIcon ?? CrocoTheme.of(context)!.themeDataExtra!.onSurface,
                            size: 30
                          ),
                        )
                      ) : SizedBox.shrink(),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: widget.logo ?? const Logo()
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: SelectableText(
                        "v0.0.1-beta",
                        style: TextStyle(
                          color: CrocoTheme.of(context)!.themeDataExtra!.textColor
                        )
                      )
                    )
                  ]
                )
              )
            ),
            Positioned(
              top: 50,
              left: breakPointActivation == false ? 250 : 0,
              child: InkWell(
                mouseCursor: SystemMouseCursors.basic,
                onTap: (){},
                onHover: ((value) {
                  if( value == true) {
                    toggleMenu = false;
                  }
                }),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width
                  ),
                  alignment:  Alignment.center,
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height - 50,
                  width: breakPointActivation == false ? MediaQuery.of(context).size.width - 250 : MediaQuery.of(context).size.width,
                  child: widget.viewChild
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Container(
                alignment: Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: breakPointActivation == false || toggleMenu == true ? 
                  InkWell(
                    mouseCursor: SystemMouseCursors.basic,
                    onTap: () {
                    },
                    onHover: (value) {
                      setState(() {
                        if(value == true) {
                          toggleMenu = true;
                        } else if( value == false) {
                          toggleMenu = false;
                        }
                      });
                    },
                    child: widget.simpleSideBar
                  ) : const SizedBox.shrink(),
                )
              ),
            ),
            
          ],
        )
      )
    );
  }
}