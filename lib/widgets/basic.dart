import 'package:flutter/material.dart';
import '../croco_base.dart';

class SimpleButton extends StatelessWidget {
  SimpleButton({
    Key? key,
    Color? this.backgroundColor = Colors.lightGreen,
    bool? this.roundBorders = true,
    Color? this.fontColor = Colors.white,
    Color? this.splashColor = const Color(0xFFC5E1A5)
    }) : super(key: key);

    Color? backgroundColor;
    bool? roundBorders;
    Color? fontColor;
    Color? splashColor;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0)
        ),
        splashColor: splashColor,
        onTap: (() {}),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0),
              color: backgroundColor
            ),
          child: Container(
            height: 34,
            alignment: Alignment.center,
            // color: backgroundColor,
            child: Text(
              "Sign in",
              style: TextStyle(
                color: fontColor
              )
            )
          ),
        ),
      ),
    );
  }
}

class SimpleButtonWithIcon extends StatelessWidget {
  SimpleButtonWithIcon({
    Key? key,
    Color? this.backgroundColor = Colors.white,
    bool? this.roundBorders = true,
    Color? this.fontColor = const Color(0xFF616161),
    dynamic this.imageIcon = '3.0x/google_logo.png',
    Color? this.splashColor = const Color(0xFFC5E1A5),
    }) : super(key: key);

    Color? backgroundColor;
    bool? roundBorders;
    Color? fontColor;
    dynamic imageIcon;
    Color? splashColor;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0)
      ),
      hoverColor: Colors.transparent,
      splashColor: splashColor,
      focusColor: Colors.transparent,
      onTap: (() {}),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[400]!
            ),
            borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0),
            color: backgroundColor
          ),
        child: Container(
          height: 34,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                child: Image.asset(
                  imageIcon,
                  filterQuality: FilterQuality.high,
                  width: 20,
                  height: 20
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(
                  color: fontColor
                )
                        ),
              )
            ]
          )
        ),
      ),
    );
  }
}