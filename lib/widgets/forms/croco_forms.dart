import 'package:croco/croco.dart';
import 'package:flutter/cupertino.dart';
import './validators.dart';
import '../buttons.dart';
import 'package:flutter/material.dart';
import '../../croco_base.dart';

enum FormItemSize {small, medium, large, xlarge}

extension FormItemSizeValue on FormItemSize {
  
  double get value {
    switch(this) {
      case FormItemSize.small : return 0.135;
      case FormItemSize.medium : return 0.18;
      case FormItemSize.large : return 0.27;
      case FormItemSize.xlarge : return 0.45;
    }
  }
}

enum FormItemOrnament { prefix, sufix}

class CrocoOrnamentIconFormItem extends StatelessWidget {

  CrocoOrnamentIconFormItem({
    Key? key,
    Icon? icon = const Icon(color: Colors.grey, Icons.account_circle),
    }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return (
      Positioned(
        top:25,
        child: Container(
          width: 30,
          height:30,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey)
            )
          ),
          child: Icon(
            color: Colors.grey,
            Icons.account_circle
          )
        )
      )
    );
  }
} 

//Migration to theme and form state/validation pending
class CrocoFormItem extends StatefulWidget {
  CrocoFormItem({
    Key? key,
    FormItemSize? this.formItemSize = FormItemSize.medium,
    String? this.text = "Lorem Ipsum",
    bool? this.extraInfoIcon = false,
    FormItemOrnament? this.ornament,
    Icon? this.ornamentIcon = const Icon(Icons.account_circle, color: Colors.grey, size: 20),
    Color? this.color = Colors.lightGreen,
    bool? this.password = false,
    double? this.textSize = 14,
    bool? this.roundBorders = true,
    Responsiveness? this.responsiveness = Responsiveness.standart,
    }) : 
    super(key: key);

    FormItemSize? formItemSize;
    String? text;
    bool? extraInfoIcon;
    FormItemOrnament? ornament;
    Icon? ornamentIcon;
    Color? color;
    bool? password;
    double? textSize;
    bool? roundBorders;
    Responsiveness? responsiveness;

  @override
  State<CrocoFormItem> createState() => _CrocoFormItemState();
}

class _CrocoFormItemState extends State<CrocoFormItem> {

  bool? focused = false;
  double? widthValue;

  void getWidthValue(BuildContext context) {
    if(widthValue == null) {
      widthValue = MediaQuery.of(context).size.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    getWidthValue(context);
    return Container(
      width: widget.responsiveness == Responsiveness.standart ? 
        MediaQuery.of(context).size.width > 1200 ? widget.formItemSize!.value * MediaQuery.of(context).size.width : widget.formItemSize!.value * 1200
        : widget.formItemSize!.value * widthValue!,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children : [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(width: widget.responsiveness == Responsiveness.standart ? 
                widget.formItemSize!.value * MediaQuery.of(context).size.width : null, 
                height: 25, 
                color: Colors.transparent),
            //   LimitedBox(
            //   maxWidth: MediaQuery.of(context).size.width > 1200 ? formItemSize!.value * MediaQuery.of(context).size.width : formItemSize!.value * 1200,
            //   child: CrocoInputTextBase(), //Just in case....
            // ),
              SizedBox(
                width: widget.responsiveness == Responsiveness.standart ? 
                  MediaQuery.of(context).size.width > 1200 ? widget.formItemSize!.value * MediaQuery.of(context).size.width 
                  : widget.formItemSize!.value * 1200 : widget.formItemSize!.value * widthValue!,
                child: CrocoInputTextBase(
                  roundBorders: widget.roundBorders,
                  password: widget.password,
                  color: widget.color!,
                  prefix: widget.ornament != null ? true : false,
                  callback: (val) => Future.delayed(Duration.zero, (() {
                    setState(() {
                      focused = val;
                    });
                  }))
                  )
                ),
              ]
            ),
            Positioned(
              bottom: 40,
              child: SelectableText(
                widget.text!,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: widget.textSize,
                ),
              ),
            ),
            widget.extraInfoIcon! ? 
            Positioned(
              bottom: 38,
              left: 95,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){},
                child: Icon(
                  Icons.info,
                  color: widget.color!,
                  size: 20
                ),
              )
            ) : SizedBox.shrink(),
            widget.ornament != null ? Positioned(
              top:25,
              child: Container(
                width: 30,
                height:30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: focused! ? widget.color! : Colors.grey)
                  )
                ),
                child: widget.ornamentIcon
              )
            ) : SizedBox.shrink()
          ]
        ),
      ),
    );
  }
}

//Migration to theme and form state/validation pending
class CrocoForm extends StatefulWidget {
  CrocoForm({
    Key? key,
    String? this.titleText = "Form Title - Form title",
    String? this.descriptionText = "This is a description text, use it as you would like it.",
    List<CrocoFormItem>? this.widgetsOnRow,
    Color? this.color = Colors.lightGreen,
    }) : 
    super(key: key);

    String? titleText;
    String? descriptionText;
    List<CrocoFormItem>? widgetsOnRow;
    Color? color;

  @override
  State<CrocoForm> createState() => _CrocoFormState();
}

class _CrocoFormState extends State<CrocoForm> with WidgetsBindingObserver {

    List<CrocoFormItem>? widgetsOnRowProcessed;
    GlobalKey globalKey = GlobalKey();
    double? adjustSpace = 50;

    @override
  void initState() {
    //Todo this needs improvement
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(globalKey.currentContext!.size!.height < 400) {
        adjustSpace = 28;
      } else {
        adjustSpace = 50;
      }
      print(globalKey.currentContext!.size!.height);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {  
    
    setState(() {
      Iterable<CrocoFormItem> widgetsIterable;

      widgetsIterable = widget.widgetsOnRow!.map((item) {
        item.color = widget.color;
        return item;
      });
      widgetsOnRowProcessed = widgetsIterable.toList();
    });
    print(widgetsOnRowProcessed);
    return Container(
      color: Colors.transparent,
      key: globalKey,
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: adjustSpace!, left: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            widget.titleText!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: SelectableText(
              widget.descriptionText!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200
              )
            )
          ),
          // for (Widget widget in widgetsOnRow!) Padding(padding: const EdgeInsets.only(right: 30), child: widget
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    runSpacing: 10,
                    children: [for (CrocoFormItem widget in widgetsOnRowProcessed!) Padding(padding: const EdgeInsets.only(right: 30), child: widget)]
                  )
                )
              ]
            )
          )
        ],
      )
    );
  }
}

//Should not be used directly, only inside other classes.
class CrocoInputTextBase extends StatefulWidget {
  CrocoInputTextBase({
    Key? key,
    bool? this.prefix = false,
    Function? this.callback,
    Color? this.color,
    bool? this.password,
    bool? this.roundBorders = true,

    }) : super(key: key);

    bool? prefix;
    Function? callback;
    Color?  color;
    bool? password;
    bool? roundBorders;

  @override
  State<CrocoInputTextBase> createState() => _CrocoInputTextBaseState();
}

class _CrocoInputTextBaseState extends State<CrocoInputTextBase> {

  late FocusNode node;
  bool focused = false;
  late FocusAttachment nodeAttachment;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
    node.addListener(handleFocusChange);
    nodeAttachment = node.attach(context);
  }

  void handleFocusChange(){
    if(node.hasFocus != focused) {
      setState(() {
        focused = node.hasFocus;
      });

      widget.callback!(focused);

    }
  }

  @override
  void dispose() {
    node.removeListener(handleFocusChange);
    node.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.password == true ? true : false,
      focusNode: node,
      onTap:() {
        node.requestFocus();
      },
      style: const TextStyle(
        fontSize: 14,
      ),
        cursorColor: widget.color!,
        decoration: InputDecoration(
          hoverColor: widget.color!,
          isDense: true,
          contentPadding: widget.prefix! ? const EdgeInsets.only(top:10, bottom: 10, left:32) : const EdgeInsets.only(top:10, bottom: 10, left:2),
          border:  OutlineInputBorder(
            borderRadius: widget.roundBorders == true ? BorderRadius.circular(10) : BorderRadius.zero
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: widget.roundBorders == true ? BorderRadius.circular(10) : BorderRadius.zero,
            borderSide: BorderSide(
              color: widget.color!
            )
          )
        )
      );
  }
}

//Migration to theme and form state/validation pending
class LogInForm extends StatefulWidget with CrocoBase  {
  LogInForm({
    Key? key,
    String? this.title = "Welcome Back",
    String? this.description = "Welcome back! Please enter your credentials",
    Color? this.themeColor,
    bool? this.roundBorders = true,
    bool? this.centerHeaderText = false
    }) : super(key: key);

    String? title;
    String? description;
    Color? themeColor;
    bool? roundBorders;
    bool? centerHeaderText;
    

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> with SingleTickerProviderStateMixin, CrocoBase {

  double height = 540;
  double width = 320;
  bool focused = false;
  Color? themeColorLight;
  Color? bordersColor;
  Color? themeColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.themeColor == null ? themeColor = Theme.of(context).colorScheme.primary : themeColor = widget.themeColor;

    themeColorLight = CrocoBase.lightenColorForHighlight(themeColor!, 0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: widget.centerHeaderText == false ? EdgeInsets.only(left: 10) : EdgeInsets.only(right: 20),
            alignment: widget.centerHeaderText == false ? Alignment.topLeft : Alignment.center,
            child: SelectableText(
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              "Welcome Back"
            )
          ),
          Container(
            margin: widget.centerHeaderText == false ? EdgeInsets.only(left: 12, top: 10) : EdgeInsets.only(top: 10, right: 11),
            alignment: widget.centerHeaderText == false ? Alignment.topLeft : Alignment.center,
            child: SelectableText(
              "Welcome back! Please enter your credentials.",
              style: TextStyle(
                color: Colors.grey[700]
              )
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 24, left: 12, right: 26),
            child: CrocoFormItem(
              color: themeColor,
              responsiveness: Responsiveness.standart,
              textSize: 12,
              text : "Username",
              roundBorders: widget.roundBorders,
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20, left: 12, right: 26),
            child: CrocoFormItem(
              color: themeColor,
              responsiveness: Responsiveness.standart,
              textSize: 12,
              password: true,
              text : "Password",
              roundBorders: widget.roundBorders,
            )
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20, left: 12),
            child: InkWell(
              hoverColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: (() {}),
              onHover: (event) {
                setState(() {
                  event == true ? focused = true : focused = false;
                });
              },
              child: AnimatedDefaultTextStyle(
                curve: Curves.ease,
                duration: Duration(milliseconds: 500),
                style: TextStyle(
                    fontWeight: focused ? FontWeight.bold : FontWeight.normal,
                    color: themeColor,
                    fontSize: 12
                  ),
                child: Text(
                  "Forgot Password",
                ),
              )
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 28, top: 20),
            alignment: Alignment.topLeft,
            child: SimpleButton(
              backgroundColor: themeColor,
              splashColor: themeColorLight,
              roundBorders: widget.roundBorders,
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 28, top: 20),
            alignment: Alignment.topLeft,
            child: SimpleButtonWithIcon(
              splashColor: themeColorLight,
              roundBorders: widget.roundBorders,
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?"
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          onTap:(() {
                            
                          }),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: themeColor
                            )
                          )
                        ),
                      )
                    ],
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}

class CrocoFormItemDense extends StatefulWidget {
  CrocoFormItemDense({
    Key? key,
    String? this.labelText,
    bool? this.halfSize = false,
    bool? this.alone = false,
    Color? this.colorTheme,
    Validation? this.validation,
    }) : super(key: key);

    String? labelText;
    bool? halfSize;
    Color? colorTheme;
    bool? alone;
    Validation? validation;

  @override
  State<CrocoFormItemDense> createState() => _CrocoFormItemDenseState();
}

class _CrocoFormItemDenseState extends State<CrocoFormItemDense> {

  late FocusNode node;
  bool focused = false;
  late FocusAttachment nodeAttachment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    node = FocusNode();
    node.addListener(handleFocusChange);
    nodeAttachment = node.attach(context);
  }

  void handleFocusChange () {
    if(node.hasFocus != focused) {
      setState(() {
        focused = node.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    node.removeListener(handleFocusChange);
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: TextFormField(
        validator: ((value) {
          if(widget.validation != null) {
            return widget.validation!.validation(value);
          }
           
        }),
        focusNode: node,
        onTap: () {
          node.requestFocus();
        },
        cursorColor: widget.colorTheme ?? Theme.of(context).colorScheme.primary,
        style: TextStyle(
          fontFamily: "Segoe UI",
          fontSize: 14.5,
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontFamily: "Segoe UI"
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.colorTheme ?? Theme.of(context).colorScheme.primary
            )
          ),
          floatingLabelStyle: TextStyle(
            fontFamily: "Segoe UI",
            color: widget.colorTheme ?? Theme.of(context).colorScheme.primary
          ),
          focusColor: widget.colorTheme ?? Theme.of(context).colorScheme.primary,
          isDense: true,
          labelText: widget.labelText ?? "Text Input",
          labelStyle: TextStyle(
            color: CrocoTheme.of(context)!.themeDataExtra!.onSurface,
            fontFamily: "Segoe UI",
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top:10),
            child: Icon(
              CupertinoIcons.pen,
              color: focused == false ? Colors.grey[500] : widget.colorTheme ?? Theme.of(context).colorScheme.primary
            ),
          ),
          suffixIconColor: CrocoTheme.of(context)!.themeDataExtra!.onSurface
        )
      )
    );
  }
}

// I know this is not an ideal solution, but is something that I came up with and it works just fine. I'm open to discuss better solutions though
class CrocoFormDense extends StatefulWidget {
  CrocoFormDense({
    Key? key,
    List<CrocoFormItemDense>? this.children,
    this.button
    }) : super(key: key);

    List<CrocoFormItemDense>? children;
    Widget? button;
    

  @override
  State<CrocoFormDense> createState() => _CrocoFormDenseState();
}

class _CrocoFormDenseState extends State<CrocoFormDense> {

  List<Widget> processedList = [];
  final formKey = GlobalKey<FormState>();

  void preProcessor(List<CrocoFormItemDense>? children, Widget? button ) {

    int count = -1;
    double evenCount = 0;

    for(var crocoFormItem in children!) {
      count++;

      if(crocoFormItem.halfSize == true) {
        if(count < children.length - 1) {
          if(children[count + 1].halfSize == true && children[count + 1].alone == false && crocoFormItem.alone == false) {
            count != 0 ? evenCount++ : null;
            processedList.add(
              Container(
                transform: count == 0 ? Matrix4.translationValues(0, -20, 0) : Matrix4.translationValues(0, -20 + (-40 * evenCount), 0),
                child: Row(
                  children: [
                    Expanded(child: crocoFormItem,),
                    Expanded(child: children[count + 1])
                  ],
                ),
              )
            );
          }
        }

        if(crocoFormItem.alone == true) {
          count != 0 ? evenCount++ : null;
          processedList.add(
            Container(
              transform: count == 0 ? Matrix4.translationValues(0, -20, 0) : Matrix4.translationValues(0, -20 + (-40 * evenCount) , 0),
              child: Row(
                children:[
                  Expanded(child: crocoFormItem),
                  Expanded(child: SizedBox())
                ]
              ),
            )
          );
        }

      } else if(crocoFormItem.halfSize == false) {
        count != 0 ? evenCount++ : null;
        processedList.add(
          Container(
            transform: count == 0 ? Matrix4.translationValues(0, -20, 0) : Matrix4.translationValues(0, -20 + (-40 * evenCount), 0),
            child: crocoFormItem
          )
        );
      }
      
      
    }

    processedList.add(
      Container(
        margin: EdgeInsets.only(left:20),
        alignment: Alignment.centerLeft,
        transform: count == 0 ? Matrix4.translationValues(0, -20, 0) : Matrix4.translationValues(0, -20 + (-40 * evenCount), 0),
        child: SquaredButton(
          parentGlobalKey: formKey,
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preProcessor(widget.children, widget.button);
  }
 
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              for(var itemForm in processedList) itemForm,
            ]
          ),
        )
      ),
    );
  }
}