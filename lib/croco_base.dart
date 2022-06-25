import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ENUMS & EXTENSIONS

enum Responsiveness {static, standart}

enum BreakPoints {small, medium, Xmedium}

extension BreakPointsValue on BreakPoints {

  double get value {
    switch(this) {
      case BreakPoints.small: return 500;

      case BreakPoints.medium: return 767;

      case BreakPoints.Xmedium: return 970;
    }
  }
}

// WIDGETS & HELPERS

class BreakpointsNotification extends Notification {

  late double breakpointCount;

  BreakpointsNotification(this.breakpointCount);

}

class CrocoWidgetNotifier extends StatelessWidget {

  bool? breakpointActivation;
  Function? callback;
  BreakPoints? breakpoint;

  CrocoWidgetNotifier(Key? key, this.breakpoint,this.breakpointActivation, this.callback) : super(key: key);

  void activateBreakPoint(BreakPoints breakPoint, BuildContext context, bool breakpointCount) {
    var width = MediaQuery.of(context).size.width;

    if(width <= breakPoint.value) {
      callback!(true);
      BreakpointsNotification(breakPoint.value).dispatch(context);
    } else if(width > breakPoint.value) {
      callback!(false);
      BreakpointsNotification(breakPoint.value).dispatch(context);
    }

  }
  @override
  Widget build(BuildContext context) {
    activateBreakPoint(breakpoint!, context, breakpointActivation!);
    return SizedBox.shrink();
  }
}

//METHDS AND FIELDS CROCOBASE

mixin CrocoBase {

    // divide the width of the box with this value
  final double cardSizeVertical1 = 1.166668;

  // multiply the width of the box with this value
  final double cardSizeHorizontal1 = 1.71;

  //TODO: Check is color > certain luminance
  static Color darkenColorForHighlight(Color colorInput, [double darkenAmount = 0.2]) {
    final hsl = HSLColor.fromColor(colorInput);
    final hslDarken = hsl.withLightness(hsl.lightness - darkenAmount);
    
    final colorOutput = hslDarken.toColor();
    return colorOutput;
  }

  static Color lightenColorForHighlight(Color colorInput, [double lightenAmount = 0.2]) {

    final hsl =  HSLColor.fromColor(colorInput);
    final hslLighten = hsl.withLightness(hsl.lightness + lightenAmount);

    final colorOutput = hslLighten.toColor();
    return colorOutput;

  }

  //Method to return Box Decoration with box shadow and logic for dark background -> light elements, light background -> dark elements.
  BoxDecoration getBoxDecoration(Color backgroundColor, bool withRoundBorder, bool withShadow ) {
    return(
      BoxDecoration(
        color: backgroundColor,
        borderRadius: withRoundBorder ? BorderRadius.circular(10) : BorderRadius.circular(0),
        boxShadow: [ withShadow ? 
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0)
          ) : const BoxShadow()
        ]
      )
    );
  }

}


class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: RichText(
        text: TextSpan(
          text: "CROCO",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500
            )
          ),
          children: [
            TextSpan(
              text: ".",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500
                )
              )
            )
          ]
        ), 
      )
    );
  }
}





  

