import 'package:croco/widgets/croco_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:croco/croco.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    return MediaQuery(
      data: MediaQueryData(),
      child: ProviderScope(
        child: CrocoTheme(
          themeDataExtra: CrocoThemes.deepSea.themeExtra,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'croco',
            theme: CrocoThemes.deepSea.theme,
            home: MyHomePage(),
          ),
        ),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainView(
          simpleSideBar: SimpleSideBar(
            childrenList: [
              HeaderSimpleSideBar(
                text: "Croco Sales",
              ),
              SimpleItemSideBar(
              ),
              SimpleItemSideBar(
                title: "Sales Managment"
              )
            ],
          ),
          viewChild: CrocoGrid(
            tilesList: [
              Tile(
                header: true,
                headerText: "Client Info",
                extraHeaderInfo: "User records",
                xStartPoint: 1,
                yStartPoint: 1,
                xAxisSquares: 2,
                yAxisSquares: 2,
                childOn: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: CrocoFormDense(
                    index: 1,
                    name: "Client Info",
                    children: [
                      CrocoFormItemDense(
                        labelText: "Client Name",
                        validation: Validation.isEmpty,
                      )
                    ]
                  )
                ),
              ),
              Tile(
                xStartPoint:1,
                yStartPoint:3,
                xAxisSquares:2,
                yAxisSquares:2,
                childOn: Container(
                  color: Theme.of(context).colorScheme.surface,
                ),

              ),
              Tile(
                xStartPoint: 3,
                yStartPoint: 4,
                xAxisSquares: 3,
                yAxisSquares: 1,
                childOn: Container(
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).colorScheme.surface,
                  child: ConsolidationForm(
                    index: 1,
                  )
                ),
              ),
              Tile(
                header: true,
                headerText: "Address Manager",
                extraHeaderInfo: "User records",
                xStartPoint: 3,
                yStartPoint: 1,
                xAxisSquares: 3,
                yAxisSquares: 3,
                childOn: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: CrocoFormDense(
                    index: 1,
                    name: "Address Manager",
                    formValidation: FormValidation.self,
                    children: [
                      CrocoFormItemDense(
                        labelText: "Address",
                        halfSize: true,
                        validation: Validation.isEmpty,
                      ),
                      CrocoFormItemDense(
                        labelText: "District",
                        halfSize: true,
                      ),
                      CrocoFormItemDense(
                        labelText: "Reference",
                      ),
                      CrocoFormItemDense(
                        labelText: "Zone",
                        halfSize: true,
                        alone: true,
                      )
                    ],
                  ),
                )
              ),
            ]
          )
        )
      )
    );
  }
}