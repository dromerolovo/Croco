import 'package:flutter/material.dart';
import 'package:croco/croco.dart';




void main() async {
  initializeCrocoApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    return CrocoApp(
      crocoTheme: CrocoThemes.deepSea,
      home: Scaffold(
        body: LogInView(
          logInForm: LogInForm(),
        )
      )
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
            panelsList: [
              Panel(
                header: true,
                headerText: "Client Info",
                extraHeaderInfo: "User records",
                xStartPoint: 1,
                yStartPoint: 1,
                xAxisSquares: 2,
                yAxisSquares: 2,
                childOn: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: CrocoFormDense(
                    formValidation: FormValidation.group,
                    index: 1,
                    name: "Client Info",
                    children: [
                      CrocoFormItemDense(
                        name: "client",
                        labelText: "Client Name",
                        validation: Validation.isEmpty,
                      )
                    ]
                  )
                ),
              ),
              Panel(
                header: true,
                headerText: "Description",
                extraHeaderInfo: "User Records",
                xStartPoint:1,
                yStartPoint:3,
                xAxisSquares:2,
                yAxisSquares:2,
                childOn: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: DescriptionPanel(
                    children: [
                      DescriptionPanelHeader(
                        headerText: "Overview",
                      ),
                      DescriptionText(
                        textList: const [
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.",
                          "ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
                        ]
                      ),
                      DescriptionPanelHeader(
                        headerText: "Client",
                      ),
                      DescriptionText(
                        textList: const [
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.",
                          "ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
                        ]
                      ),
                    ],
                  )
                ),

              ),
              Panel(
                header: true,
                headerText: "Consolidation",
                extraHeaderInfo: "User records",
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
              Panel(
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
                    index:1,
                    name: "Address Manager",
                    formValidation: FormValidation.group,
                    children: [
                      CrocoFormItemDense(
                        name: "address",
                        labelText: "Address",
                        halfSize: true,
                        validation: Validation.isEmpty,
                      ),
                      CrocoFormItemDense(
                        name: "district",
                        labelText: "District",
                        halfSize: true,
                      ),
                      CrocoFormItemDense(
                        name: "reference",
                        labelText: "Reference",
                      ),
                      CrocoFormItemDense.datePicker(
                        name: "zone",
                        labelText: "Zone",
                        halfSize: true,
                        alone: true,
                      ),
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