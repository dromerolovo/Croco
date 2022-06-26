import 'package:flutter/material.dart';
import '../croco_base.dart';

class CrocoTheme extends InheritedWidget {
  CrocoTheme({
    Key? key, 
    required this.child,
    this.themeDataExtra,
    }) : super(key: key, child: child);

  final Widget child;
  final ThemeDataExtra? themeDataExtra;

  static CrocoTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CrocoTheme>();
  }

  @override
  bool updateShouldNotify(CrocoTheme oldWidget) {
    return true;
  }
}

class ThemeDataExtra {

  ThemeDataExtra({
    this.onHoverOnSurfaceVariant,
    this.textColor,
    this.smallTextColor,
    this.onSurfaceVariant,
    this.onSurface,


  });

  final Color? onHoverOnSurfaceVariant;
  final Color? textColor;
  final Color? smallTextColor;
  final Color? onSurfaceVariant;
  final Color? onSurface;

}


//Croco Main

ThemeData zenForest = ThemeData(
  primaryColor: Colors.lightGreen,
  fontFamily: "Segoe UI",
  colorScheme: ColorScheme.fromSeed(
    primary: Colors.lightGreen,
    onPrimary: Colors.white,
    seedColor: Colors.lightGreen,
    brightness: Brightness.light,
    secondary: Colors.brown,
    background: Colors.brown[50],
    surface: Colors.white,
    surfaceVariant: Colors.grey[700]
  )
);

ThemeDataExtra zenForestExtra = ThemeDataExtra(
  onHoverOnSurfaceVariant: CrocoBase.lightenColorForHighlight(Colors.grey[700]!, 0.05),
  textColor: Colors.grey[700],
  smallTextColor: Colors.grey[700],
  onSurfaceVariant: Colors.grey[100],
  onSurface: Colors.grey[700]
);



ThemeData deepSea = ThemeData(
  primaryColor: Colors.teal,
  fontFamily: "Segoe UI",
  colorScheme: ColorScheme.fromSeed(
    primary: Colors.teal,
    onPrimary: Colors.white,
    brightness: Brightness.dark,
    seedColor: Colors.teal,
    secondary: Colors.tealAccent[400],
    surface: HSLColor.fromAHSL(1, 210, 0.26, 0.15).toColor(),
    background: HSLColor.fromAHSL(1, 211, 0.23, 0.19).toColor(),
    surfaceVariant: HSLColor.fromAHSL(1, 208, 0.23, 0.24).toColor()
  )
);

ThemeDataExtra deepSeaExtra = ThemeDataExtra(
  onHoverOnSurfaceVariant: CrocoBase.darkenColorForHighlight(HSLColor.fromAHSL(1, 208, 0.23, 0.24).toColor(), 0.05),
  textColor: Colors.grey[100],
  smallTextColor: Colors.grey[50],
  onSurfaceVariant: Colors.grey[100],
  onSurface: Colors.grey[100]
);



enum CrocoThemes { zenForest, deepSea }


extension CrocoThemesValue on CrocoThemes {

  ThemeData get theme {
    switch(this) {
      case CrocoThemes.zenForest: return zenForest;
      case CrocoThemes.deepSea: return deepSea;
    }
  }

  ThemeDataExtra get themeExtra {
    switch(this) {
      case CrocoThemes.zenForest: return zenForestExtra;
      case CrocoThemes.deepSea: return deepSeaExtra;
    }
  }
}



