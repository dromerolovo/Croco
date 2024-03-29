import 'package:croco/providers/forms_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../themes/themes.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum HeaderSize {alwaysSmall, twoSizes, flexible}

extension HeaderSizeGetter on HeaderSize {

  double getHeaderSize(double tileHeight) {

    switch(this) {
      case HeaderSize.alwaysSmall:
        return 35.866;
      case HeaderSize.twoSizes:
        if(tileHeight > 322.79999) {
          return 54.355;
        } else {
          return 35.866;
        }
      case HeaderSize.flexible:
        return tileHeight / 9;
      
    }
  }
}

class Panel extends StatelessWidget {
   Panel({
    Key? key,
    this.xStartPoint = 2,
    this.yStartPoint = 2,
    this.xAxisSquares = 2,
    this.yAxisSquares = 2,
    this.backgroundColor,
    this.header,
    this.icon,
    this.iconColor,
    this.headerText = "Header Title",
    this.extraHeaderInfo = "",
    this.childOn
    }) : 
    super(key: key);

    int? xAxisSquares;
    int? yAxisSquares;
    int? xStartPoint;
    int? yStartPoint;
    Color? backgroundColor;
    bool? header;
    String? headerText;
    String? extraHeaderInfo;
    Icon? icon;
    Color? iconColor;
    Widget? childOn;


  @override
  Widget build(BuildContext context) {
    return childOn ?? Container(); 
  }
}

class CrocoGrid extends ConsumerStatefulWidget {
  CrocoGrid({
    Key? key,
    this.xAxisGridSquares = 8,
    this.yAxisGridSquares = 4,
    this.externalPadding = 20,
    this.paddingInBetween = 10,
    this.panelsList,
    this.backgroundParentColor,
    this.headerSize = HeaderSize.twoSizes,


    }) : super(key: key);

    int? xAxisGridSquares;
    int? yAxisGridSquares;
    double? externalPadding;
    double? paddingInBetween;
    List<Panel>? panelsList;
    Color? backgroundParentColor;
    HeaderSize? headerSize;


  @override
  ConsumerState<CrocoGrid> createState() => _CrocoGridState();
}

class _CrocoGridState extends ConsumerState<CrocoGrid> {

  GlobalKey globalKey = GlobalKey();
  double? parentHeight;
  double? parentWidth;

  double? sizeOfTileWidth;
  double? sizeOfTileHeight;

  List<Positioned>? stack = [];


  List<Positioned> preProcessor(List<Panel> tilesList) {
    List<List<int>> processingMatrix = [];
    List<Positioned> positionedList = [];

    for(var i = 0; i < widget.xAxisGridSquares!; i++ ) {
        List<int> processingColumn = [];
        for(var j = 0; j < widget.yAxisGridSquares!; j++) {
          processingColumn.add(0);
        }
        processingMatrix.add(processingColumn);
      
    }


    for(var tile in tilesList) {

      var x = tile.xAxisSquares; //MainAxis sizee
      var y = tile.yAxisSquares; //CrossAxis size

      var xStart = tile.xStartPoint;
      var yStart = tile.yStartPoint;

      var xStartNormal = xStart! - 1;
      var yStartNormal = yStart! - 1;

      //Normalize to 0 start order collection x / y values
      var xNormal = x! - 1;
      var yNormal = y! - 1;
      //Positioned Values
      double positionedTop = 0;
      double positionedLeft = 0;

      //Size Values
      double tileHeight = 0;
      double tileWidth = 0;

      //Calculating positionedTop and Left

      void calculatingPositionAndSize() {

        positionedTop += ((yStart - 1) * widget.paddingInBetween!) + (sizeOfTileHeight! * (yStart - 1));
        positionedLeft += ((xStart - 1) * widget.paddingInBetween!) + (sizeOfTileWidth! * (xStart - 1));

        tileHeight = ( sizeOfTileHeight! * y ) + ((y - 1 ) * widget.paddingInBetween!);
        tileWidth = ( sizeOfTileWidth! * x ) + ((x - 1 ) * widget.paddingInBetween!);


      }

      calculatingPositionAndSize();

      //Offset values
      var startPoint = processingMatrix[xStartNormal][yStartNormal];
      if(startPoint == 1) {
        throw("There is already a Tile in given location. Try a different location");
      }

      for(var i = 0; i < x; i++) {

        for(var j = 0; j < y; j++) {

          if(processingMatrix[xStartNormal + i][yStartNormal + j] == 1) {
            throw("There is no avilable space in this location. Try a different location");
          } else if(processingMatrix[xStartNormal + i][yStartNormal + j] == 0) {
            processingMatrix[xStartNormal + i][yStartNormal + j] = 1;
          }
        }
      }

      var calculation = tileHeight / 9;


      positionedList.add(
        Positioned(
          top: positionedTop,
          left: positionedLeft,
          child: Container(
            decoration: BoxDecoration(
              color: tile.backgroundColor ?? Theme.of(context).colorScheme.surface,
            ),
            alignment: Alignment.center,
            width: tileWidth,
            height: tileHeight,
            child: tile.header == true ? Column(    
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: widget.headerSize!.getHeaderSize(tileHeight),
                  width: tileWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: tile.icon ?? Icon(
                          Icons.analytics,
                          color: tile.iconColor ?? Theme.of(context).colorScheme.primary,
                          size: 30
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SelectableText(
                          tile.headerText!,
                          style:  TextStyle(
                            color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 2),
                        child: SelectableText(
                          tile.extraHeaderInfo == "" ? "" : "- ${tile.extraHeaderInfo!}",
                          style:  TextStyle(
                            color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                          )
                        )
                      )
                    ],
                  )
                ),
                Container(
                  height: 10 / 1.5,
                  color: widget.backgroundParentColor ?? Theme.of(context).colorScheme.background
                ),
                Container(
                  height: tileHeight - widget.headerSize!.getHeaderSize(tileHeight) - 10 / 1.5,
                  child: tile.childOn ?? Container()
                )
              ]
            ) : tile.childOn ?? Container(),
          )
        )
      );
    }

    return positionedList;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        parentWidth = globalKey.currentContext!.size!.width;
        parentHeight = globalKey.currentContext!.size!.height;

        sizeOfTileWidth = ((parentWidth !- (widget.xAxisGridSquares! - 1) * widget.paddingInBetween!) -  widget.externalPadding! * 2) / widget.xAxisGridSquares!;
        sizeOfTileHeight = ((parentHeight !- (widget.yAxisGridSquares! - 1) * widget.paddingInBetween!) - widget.externalPadding! * 2) / widget.yAxisGridSquares!;

        stack = preProcessor(widget.panelsList!);

      });
    });
  }

  List<Positioned> preProcessorDataPicker(List<DataPicker>? dataPickerList) {
    List<Positioned> dataPickerListPost = [];

    for(var dataPicker in dataPickerList!) {
      dataPickerListPost.add(
        Positioned(
          top: dataPicker.y! - 50 - 15,
          left: dataPicker.x! - 260 - 15,
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            elevation: 15,
            child: Container(
              alignment: Alignment.center,
              height: 260,
              width: 260,
              color: Theme.of(context).colorScheme.surface,
              child:  SfDateRangePicker(
                onSubmit: (p0) {
                  
                  var verification = ref.read(formStatePodProvider.notifier).state[1].validationState;
                  RegExp exp = RegExp(r"([^\s]+)");
                  var date = exp.firstMatch(p0.toString())!.group(0);
                  //For some reason the acion of the controller is making the entire form bypass validation. 
                  //provisionally im going to change the state after the controller action. With the following line
                  //ref.read(formStatePodProvider.notifier).changeValidationStatus(dataPicker.parentKey, false);
                  
          
                  dataPicker.controller!.value = TextEditingValue(
                    text: date!
                  );
          
                  if(verification == false) { 
                    ref.read(formStatePodProvider.notifier).changeValidationStatus(dataPicker.parentKey, false);
                  }
                
                  ref.read(dataPickerProvider.notifier).changeFocusStatus(dataPicker.globalKey!, false);
                },
                onCancel: () {
                  ref.read(dataPickerProvider.notifier).changeFocusStatus(dataPicker.globalKey!, false);
                },
                showActionButtons: true,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    fontFamily: "Segoe UI",
                    fontSize: 14,
                    color: CrocoTheme.of(context)!.themeDataExtra!.textColor
                  )
                ),
              )
            ),
          )
        )
      );
    }

    return dataPickerListPost;
  }




  @override
  Widget build(BuildContext context) {
    var dataPickerList = ref.watch(dataPickerProvider).where((element) => element.focused == true).toList();
    var dataPickerListPost = preProcessorDataPicker(dataPickerList);
    return Container(
      alignment: Alignment.topLeft,
      key: globalKey,
      padding: EdgeInsets.all(widget.externalPadding!),
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 10)),
        builder: (context, snapshot) {
          return 
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 1286,
                      height: 695.599
                    ),
                    for(var tile in stack!) tile,
                    for(var dataPicker in dataPickerListPost ) dataPicker
                  ]
                ),
              );
        }
      )
    );
  }
}