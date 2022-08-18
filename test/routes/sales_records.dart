import 'package:flutter/material.dart';
import 'package:croco/croco.dart';


class SalesRecords extends StatelessWidget {
  const SalesRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CrocoGrid(
        panelsList: [
          Panel(
            xStartPoint: 1,
            yStartPoint: 1,
            xAxisSquares: 3,
            yAxisSquares: 3,
          )
        ],
      )
    );
  }
}