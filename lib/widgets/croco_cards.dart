
import 'package:flutter/material.dart';
import '../croco_base.dart';

//NOT SUPPORTED
class CrocoSimpleIconCard extends StatelessWidget with CrocoBase {
   CrocoSimpleIconCard({
    Key? key,
    dynamic icon,
    this.backgroundColor = Colors.lightGreen,
    dynamic elementsColor,
    this.headerText = "Lorem Ipsum",
    this.withShadow = true,
    this.withRoundBorder = true,
    this.text = "Lorem ipsum dolor sit amet, sit consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    }) : 
    this.elementsColor = elementsColor ?? backgroundColor.computeLuminance() > 0.5? Colors.grey : Colors.white,
    this.icon = icon ?? Icon(Icons.account_circle, color: backgroundColor.computeLuminance() > 0.5? Colors.grey : Colors.white , size: 120),
    super(key: key);

  final Icon icon;
  final Color elementsColor;
  final Color backgroundColor;
  final bool withShadow;
  final bool withRoundBorder;
  final String headerText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 750 / 2.4,
      width: 750 / 2.4 / cardSizeVertical1,
      decoration: CrocoBase.getBoxDecoration(backgroundColor, withRoundBorder, withShadow),
      alignment: Alignment.topCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: const EdgeInsets.only(top: 15) ,child: icon),
            Container(
              color: backgroundColor,
              margin: const EdgeInsets.only(top: 10),
              child: SelectableText(
                headerText,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Segoe UI",
                  color: elementsColor,
                )
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              color: elementsColor,
              width: 100,
              height: 1.5,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: SelectableText(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Segoe UI",
                  color: elementsColor == Colors.grey ? Colors.grey[600] : elementsColor,

                )

              )
            )
          ],
        )
    );
  }
}


//NOT SUPPORTED
class CrocoSimpleIconInfoCard extends StatefulWidget {

    final Icon icon;
    final Color backgroundColor;
    final Color iconBackgroundColor;
    final bool withRoundBorder;
    final bool withShadow;
    final Color elementsColor;
    final String headerText;
    final String text;

  CrocoSimpleIconInfoCard({
     Key? key,
     dynamic icon,
     this.backgroundColor = Colors.lightGreen,
     this.iconBackgroundColor = const Color(0xFF1B5E20),
     dynamic elementsColor,
     this.headerText = "Lorem Ipsum",
     this.withShadow = true,
     this.withRoundBorder = true,
     this.text = "Lorem ipsum dolor sit amet, sit consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
   }) : 
    elementsColor = elementsColor ?? backgroundColor.computeLuminance() > 0.5? Colors.grey : Colors.white,
    icon = icon ?? Icon(Icons.admin_panel_settings_rounded, color: iconBackgroundColor.computeLuminance() > 0.5? backgroundColor : Colors.white , size: 30),
    super(key: key);

  @override
  State<CrocoSimpleIconInfoCard> createState() => _CrocoSimpleIconInfoCard();

}

class _CrocoSimpleIconInfoCard extends State<CrocoSimpleIconInfoCard> with CrocoBase, SingleTickerProviderStateMixin{

  bool breakpoint = false;
  bool breakpointActivation = false;

  //State values for animation
  double width = 750 / 3.2 * 1.71;
  double height = 750 / 3.2;


  @override
  Widget build(BuildContext context) {
    return NotificationListener<BreakpointsNotification>(
      onNotification: (notification) {
        Future.delayed(Duration.zero, (){
          setState(() {
            if(breakpointActivation == false) {
              width = 750 / 2.4;
              height = 750 / 2.4 / cardSizeVertical1 ;
            } else if(breakpointActivation == true) {
              width = 750 / 3.2 * 1.71;
              height = 750 / 3.2;
            }
          });
        });

        return true;

      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: width,
        height: height ,
        decoration: CrocoBase.getBoxDecoration(widget.backgroundColor, widget.withRoundBorder, widget.withShadow),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 45,
                height: 45,
                margin: const EdgeInsets.only(left: 25, top: 30),
                decoration:  BoxDecoration(
                  color: widget.iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: widget.icon
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, top: 20),
              alignment: Alignment.centerLeft,
              child: SelectableText(
                  widget.headerText,
                  textAlign: TextAlign.left,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Segoe UI",
                    color: widget.elementsColor,
                  )
                )
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, top: 20, right: 30),
              child: SelectableText(
                widget.text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Segoe UI",
                  color: widget.elementsColor == Colors.grey ? Colors.grey[600] : widget.elementsColor,
                )
              )
            ),
             CrocoWidgetNotifier(
               null,
               BreakPoints.small,
               breakpointActivation,
               (val) => 
                Future.delayed(Duration.zero, (() {
                  setState(() {
                    breakpointActivation = val;
                  });
                })
             )
            )
          ] 
        )
      ),
    );
  }
}

//NOT SUPPORTED
class CrocoStylizedHeaderCard extends StatefulWidget  {
  CrocoStylizedHeaderCard({
    Key? key,
    Color? this.fontColor = Colors.grey,
    Color? this.backgroundColorInit = Colors.white,
    Color? this.backgroundColorOnHover = Colors.lightGreen,
    Color? this.fontColorOnHover = Colors.white,
    String? this.imgPath = 'Colibri.png',

    }) : super(key: key);

    Color? fontColor;
    Color? backgroundColorInit;
    Color? backgroundColorOnHover;
    Color? fontColorOnHover;
    String? imgPath;

  @override
  State<CrocoStylizedHeaderCard> createState() => _CrocoStylizedHeaderCardState();
}

class _CrocoStylizedHeaderCardState extends State<CrocoStylizedHeaderCard> with SingleTickerProviderStateMixin, CrocoBase {

  double elevation = 8;
  Color? fontColorTitleOnHover;
  Color? fontColorTitle;
  Color? fontColorTitleInit;
  Color? fontColor;
  Color? backgroundColor;
  double width = 416.66;
  double height = 316;
  bool? focused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    if(widget.backgroundColorInit!.computeLuminance() > 0.5) {
      fontColorTitleInit = CrocoBase.darkenColorForHighlight(widget.fontColor!);
    } else {
      fontColorTitleInit = widget.fontColor;
    }

    if(widget.backgroundColorOnHover!.computeLuminance() > 0.5) {
      fontColorTitleOnHover = CrocoBase.darkenColorForHighlight(widget.fontColorOnHover!);
    } else {
      fontColorTitleOnHover = widget.fontColorOnHover;
    }

    backgroundColor = widget.backgroundColorInit;

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap:() {},
      onHover: ((value) {
        if(value == true) {
          setState(() {
          elevation = 30;
          backgroundColor = widget.backgroundColorOnHover;
          fontColorTitle = fontColorTitleOnHover;
          fontColor =  widget.fontColorOnHover;
          focused = true;
        });
        } else if(value == false) {
          setState(() {
            elevation = 8;
            backgroundColor = widget.backgroundColorInit;
            fontColorTitle = fontColorTitleInit;
            fontColor = widget.fontColor;
            focused = false;
          });
        }
        
      }),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: elevation,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          constraints: BoxConstraints(maxHeight: height, maxWidth: width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    widget.imgPath!,
                    width: 500
                    )
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                          color: backgroundColor,
                          border: const Border(
                            top: BorderSide(color: Colors.grey, width: 0.5),
                          )
                        ),
                    curve: Curves.easeIn,
                    duration: focused! ? Duration(milliseconds: 350) : Duration(milliseconds: 100),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 10),
                          margin: EdgeInsets.only(left: 26, top: 18,),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Stylized Header",
                            style: TextStyle(
                              fontFamily: "Segoe UI",
                              color: fontColorTitle,
                              fontSize: 21,
                              fontWeight: FontWeight.w600
                            )
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 26, top: 18, right: 26),
                          child: Text(
                            "Lorem Ipsum dolor sit amet, consectetur adpiscing elit, sed do eiusmod tempor.",
                            style: TextStyle(
                              color: fontColor,
                              fontSize: 14
                            )
                          )
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 2),
                          margin: EdgeInsets.only(left: 26, top: 10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                style: TextStyle(
                                  color: fontColorTitle,
                                  fontWeight: FontWeight.bold
                                ),
                                "Explore Lorem"
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.call_made_rounded,
                                  color: fontColorTitle,
                                  size: 20
                                ),
                              )
                            ]
                          ),
                          
                        )
                      ]
                    ),
                  ),
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}





