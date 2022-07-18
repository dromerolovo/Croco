import 'package:croco/croco.dart';
import 'package:flutter/cupertino.dart';
import '../buttons.dart';
import 'package:flutter/material.dart';
import '../../providers/forms_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

enum FormValidation { self, group}

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

//NOT SUPPORTED
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

//NOT SUPPORTED
class CrocoFormItem extends StatefulWidget {
  CrocoFormItem({
    Key? key,
    this.formItemSize = FormItemSize.medium,
    this.text = "Lorem Ipsum",
    this.extraInfoIcon = false,
    this.ornament,
    this.ornamentIcon = const Icon(Icons.account_circle, color: Colors.grey, size: 20),
    this.color,
    this.password = false,
    this.textSize = 14,
    this.roundBorders = true,
    this.responsiveness = Responsiveness.standart,
    this.callback
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
    Function? callback;

  @override
  State<CrocoFormItem> createState() => _CrocoFormItemState();
}

class _CrocoFormItemState extends State<CrocoFormItem> {

  bool focused = false;
  double? widthValue;
  ValueNotifier<String> formData = ValueNotifier("");

  void getWidthValue(BuildContext context) {
    if(widthValue == null) {
      widthValue = MediaQuery.of(context).size.width;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    formData.addListener(() {
      widget.callback!(formData.value);
    });
  }

  @override
  void dispose() {
    
    super.dispose();
    formData.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //Here is the problem
    

    getWidthValue(context);
    return Container(
      width: widget.responsiveness == Responsiveness.standart ? 
        MediaQuery.of(context).size.width > 1200 ? widget.formItemSize!.value * MediaQuery.of(context).size.width : widget.formItemSize!.value * 1200
        : widget.formItemSize!.value * widthValue!,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(width: widget.responsiveness == Responsiveness.standart ? 
                widget.formItemSize!.value * MediaQuery.of(context).size.width : null, 
                height: 25, 
                color: Colors.transparent),
              SizedBox(
                width: widget.responsiveness == Responsiveness.standart ? 
                  MediaQuery.of(context).size.width > 1200 ? widget.formItemSize!.value * MediaQuery.of(context).size.width 
                  : widget.formItemSize!.value * 1200 : widget.formItemSize!.value * widthValue!,
                child: CrocoInputTextBase(
                  roundBorders: widget.roundBorders,
                  password: widget.password,
                  color: widget.color!,
                  prefix: widget.ornament != null ? true : false,
                  callbackLogIn: (val) {
                    setState(() {
                    formData.value = val;
                    });
                  }, 
                  callback: (val) => 
                    setState(() {
                      focused = val;
                    })
                  )
                ),
              ]
            ),
            Positioned(
              bottom: 40,
              child: SelectableText(
                widget.text!,
                style: TextStyle(
                  color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
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
                  color: widget.color ?? Theme.of(context).colorScheme.primary,
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
                    right: BorderSide(color: focused ? widget.color! : CrocoTheme.of(context)!.themeDataExtra!.onSurface!)
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

//NOT SUPPORTED
class CrocoInputTextBase extends StatefulWidget {
  CrocoInputTextBase({
    Key? key,
    this.prefix = false,
    this.callback,
    this.color,
    this.password,
    this.roundBorders = true,
    this.callbackLogIn

    }) : super(key: key);

    bool? prefix;
    Function? callback;
    Color?  color;
    bool? password;
    bool? roundBorders;
    Function ? callbackLogIn;

  @override
  State<CrocoInputTextBase> createState() => _CrocoInputTextBaseState();
}

class _CrocoInputTextBaseState extends State<CrocoInputTextBase> {

  late FocusNode node;
  bool focused = false;
  late FocusAttachment nodeAttachment;

  TextEditingController controller = TextEditingController(text: "");

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
    return TextFormField(

      controller: controller,
      obscureText: widget.password == true ? true : false,
      focusNode: node,
      onChanged: (value) {
        widget.callbackLogIn!(value);
        setState(() {});
      },
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
          contentPadding: widget.prefix! ? const EdgeInsets.only(top:10, bottom: 10, left:32) : const EdgeInsets.only(top:10, bottom: 10, left:10),
          enabledBorder:  OutlineInputBorder(
            borderRadius: widget.roundBorders == true ? BorderRadius.circular(10) : BorderRadius.zero,
            borderSide: BorderSide(
              color: CrocoTheme.of(context)!.themeDataExtra!.formBorderColor!
            )
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

//ONLY SUPPORTED FOR MAINVIEW
class LogInForm extends StatefulWidget with CrocoBase  {
  LogInForm({
    Key? key,
    this.title = "Welcome Back",
    this.description = "Welcome back! Please enter your credentials",
    this.themeColor,
    this.roundBorders = true,
    this.centerHeaderText = false
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

  Map<dynamic, dynamic> formData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onSubmitCallback(Map<dynamic, dynamic> data) async {

    late String username;
    late String password;

    username = data['username'];
    password = data['password'];

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username, 
        password: password
      );
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        print("N user found for that email");
      } else if(e.code == "wrong-password") {
        print("Wrong password provider for that user");
      } else {
        print(e);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    print(formData);
    return Container(
      padding: EdgeInsets.only(top: 50),
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
                color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
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
                color: CrocoTheme.of(context)!.themeDataExtra!.textColor,
              )
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 24, left: 12, right: 26),
            child: CrocoFormItem(
              color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
              responsiveness: Responsiveness.standart,
              textSize: 12,
              text : "Username",
              roundBorders: widget.roundBorders,
              callback: (val) {
                setState(() {
                  formData['username'] = val;
                });
              } 
                
            )
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20, left: 12, right: 26),
            child: CrocoFormItem(
              color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
              responsiveness: Responsiveness.standart,
              textSize: 12,
              password: true,
              text : "Password",
              roundBorders: widget.roundBorders,
              callback: (val) =>
              setState(() {
                formData['password'] = val;
              }) 
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
                    color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
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
              backgroundColor: widget.themeColor ?? Theme.of(context).colorScheme.primary,
              splashColor: CrocoBase.lightenColorForHighlight(widget.themeColor ?? Theme.of(context).colorScheme.primary, 0.3),
              roundBorders: widget.roundBorders,
              callback: () {
                 onSubmitCallback(formData);
              },
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 28, top: 20),
            alignment: Alignment.topLeft,
            child: SimpleButtonWithIcon(
              splashColor: CrocoBase.lightenColorForHighlight(widget.themeColor ?? Theme.of(context).colorScheme.primary, 0.3),
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
                              fontWeight: FontWeight.w700,
                              color: widget.themeColor ?? Theme.of(context).colorScheme.primary,
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

class CrocoFormItemDense extends ConsumerStatefulWidget {
  CrocoFormItemDense({
    Key? key,
    this.labelText,
    this.halfSize = false,
    this.alone = false,
    this.colorTheme,
    this.validation,
    this.globalKey,
    this.index,
    this.name
    }) : super(key: key);

    CrocoFormItemDense.datePicker({
      Key? key,
      this.labelText,
      this.halfSize = true,
      this.alone = true,
      this.colorTheme,
      this.validation,
      this.globalKey,
      this.index,
      this.name,
      this.callback
    }) : 
      datePicker = true,
      super(key: key);

    String? labelText;
    bool? halfSize;
    Color? colorTheme;
    bool? alone;
    Validation? validation;
    GlobalKey<FormState>? globalKey;
    int? index;
    bool? datePicker;
    String? name;
    Function? callback;

  @override
  ConsumerState<CrocoFormItemDense> createState() => _CrocoFormItemDenseState();
}

class _CrocoFormItemDenseState extends ConsumerState<CrocoFormItemDense> {

  late FocusNode node;
  bool focused = false;
  late FocusAttachment nodeAttachment;

  GlobalKey globalKey = GlobalKey();
  TextEditingController controller = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    node = FocusNode();
    node.addListener(handleFocusChange);
    nodeAttachment = node.attach(context);

    if(widget.datePicker == true) {

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox box = globalKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      double y = position.dy;
      double x = position.dx;

      ref.read(dataPickerProvider.notifier).addDataPicker(DataPicker(
        globalKey: globalKey, 
        focused: false, 
        x: x, 
        y: y, 
        controller: controller,
        parentKey: widget.globalKey
      ));
    });
      
    }
  }

  void handleFocusChange () {
    if(node.hasFocus != focused) {
      setState(() {
        focused = node.hasFocus;
      });
    }
    if(node.hasFocus == true) {
      ref.read(formStatePodProvider.notifier).focusedForm(widget.globalKey, true);
    } 

    if(node.hasFocus == false) {
      ref.read(formStatePodProvider.notifier).focusedForm(widget.globalKey, false);
      if(widget.datePicker == true) {
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    node.removeListener(handleFocusChange);
    node.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var focusedPod = ref.watch(formStatePodProvider).firstWhere(((element) => element.globalKey == widget.globalKey), orElse: () => FormStatePod()).focused;
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: TextFormField(
        //TODO -> onSave: 
        onSaved: ((newValue) {
          widget.callback!(newValue);
          controller.text = "";
        }),
        controller: controller,
        key: globalKey,
        // readOnly: widget.datePicker == true ? true : false,
        validator: ((value) {
          if (focusedPod!) {
            if(widget.validation != null) {
              return widget.validation!.validation(value);
            } else {return null;}       
          }
        }),
        focusNode: node,
        onTap: () {
          node.requestFocus();
        },
        cursorColor: widget.colorTheme ?? Theme.of(context).colorScheme.primary,
        style: const TextStyle(
          fontFamily: "Segoe UI",
          fontSize: 14.5,
        ),
        decoration: InputDecoration(
          errorStyle: !focusedPod! ? const TextStyle(
            inherit: false,
            color: Colors.transparent,
            height: 0.001,
            fontFamily: "Segoe UI"
          ) : const TextStyle(
            fontFamily: "Segoe UI"
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.colorTheme ?? Theme.of(context).colorScheme.primary
            )
          ),
          errorBorder: focusedPod ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ) : UnderlineInputBorder(
            borderSide: BorderSide(color:Colors.grey[700]!)
          ) ,
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
            padding: const EdgeInsets.only(top:10),
            child: widget.datePicker == true ? 
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: (){
                  ref.read(dataPickerProvider.notifier).changeFocusStatus(globalKey, true);
                },
                child: Icon(
                  Icons.calendar_month,
                  color: focused == false ? Colors.grey[500] : widget.colorTheme ?? Theme.of(context).colorScheme.primary
                ),
              ),
            ) :  
             Icon(
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

// I know this is not an ideal solution, but is something that I came up with and it works more or less fine. I'm open to discuss better solutions though
class CrocoFormDense extends ConsumerStatefulWidget {
  CrocoFormDense({
    Key? key,
    this.children,
    this.formValidation,
    this.name,
    this.index,
    this.objectIdentifier
    
    }) : super(key: key);

    List<CrocoFormItemDense>? children;
    Widget? button;
    FormValidation? formValidation;
    String? name;
    int? index;
    String? objectIdentifier;
    

  @override
  ConsumerState<CrocoFormDense> createState() => _CrocoFormDenseState();
}

class _CrocoFormDenseState extends ConsumerState<CrocoFormDense> {

  List<Widget> processedList = [];
  final formKey = GlobalKey<FormState>();
  bool? focused = false;
  Map<dynamic, dynamic> data = {};

  void preProcessor(List<CrocoFormItemDense>? children, Widget? button ) {

    int count = -1;
    double evenCount = 0;

    for(var crocoFormItem in children!) {
      count++;

      crocoFormItem.globalKey = formKey;
      crocoFormItem.callback = 
      (val) => (data[crocoFormItem.name] = val);
      

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

    if(widget.formValidation == FormValidation.self) {

      processedList.add(
        Container(
          decoration: BoxDecoration(
          ),
          margin: EdgeInsets.only(left:20),
          alignment: Alignment.centerLeft,
          transform: count == 0 ? Matrix4.translationValues(0, -20, 0) : Matrix4.translationValues(0, -20 + (-40 * evenCount), 0),
          child: SquaredButton(
            parentGlobalKey: formKey,
            // index: widget.index
          ),
        )
      );
    } 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preProcessor(widget.children, widget.button);
    Future.delayed(Duration.zero, (){
      ref.read(formStatePodProvider.notifier).addFormStatePod(FormStatePod(
        globalKey: formKey,
        validationState: false,
        name: widget.name,
        focused: false,
        index: widget.index,
        formValidation: widget.formValidation
      ));
    });

  }
 
  @override
  Widget build(BuildContext context) {
    var focused = ref.watch(formStatePodProvider).firstWhere((element) => element.globalKey == formKey, orElse: () => FormStatePod()).focused;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (() {
            if(formKey.currentState!.validate()) {
              ref.read(formStatePodProvider.notifier).changeValidationStatus(formKey, true);
            } else {
              ref.read(formStatePodProvider.notifier).changeValidationStatus(formKey, false);
            }
          }),
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