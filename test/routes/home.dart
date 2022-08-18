import 'package:flutter/material.dart';
import 'package:croco/croco.dart';



class Home extends StatelessWidget {
  const Home({
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CrocoGrid(
        panelsList: [
          Panel(
            xStartPoint: 1,
            yStartPoint: 1,
          )
        ],
      )
    );
  }
}