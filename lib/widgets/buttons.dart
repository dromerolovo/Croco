import 'package:croco/state/forms_state.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../croco_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Migration to Theme pending
class SimpleButton extends StatelessWidget {
  SimpleButton({
    Key? key,
    Color? this.backgroundColor,
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
    return Material(
      child: SizedBox(
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0)
          ),
          splashColor: splashColor,
          onTap: (() {}),
          child: Ink(
            decoration: BoxDecoration(
                borderRadius: roundBorders! ? BorderRadius.circular(10) : BorderRadius.circular(0),
                color: backgroundColor ?? Theme.of(context).colorScheme.primary
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
      ),
    );
  }
}

//Migration to theme pending
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
    return Material(
      child: InkWell(
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
      ),
    );
  }
}

class SquaredButton extends ConsumerStatefulWidget {
  SquaredButton(
    {Key? key,
    this.backgroundColor,
    this.textColor,
    this.text = "Save",
    this.callback,
    this.parentGlobalKey,
    this.index,
    this.globalKeysList
    }) : super(key: key);

    Color? backgroundColor;
    Color? textColor;
    String? text;
    Function? callback;
    GlobalKey<FormState>? parentGlobalKey;
    int? index;
    List<GlobalKey<FormState>>? globalKeysList;
    

  @override
  ConsumerState<SquaredButton> createState() => _SquaredButtonState();
}

class _SquaredButtonState extends ConsumerState<SquaredButton> {

  //TODO: When submitting a form of a group: If there are some forms that are not answered right(negative validation)
  // The form that is properly validated and is part of a group gets sended anyway. And there isnt an error message of
  // the other forms.


  @override
  Widget build(BuildContext context) {
    //Check

    var validationList = ref.watch(formStatePodProvider).where((element) => element.index == widget.index).toList();
    
    //Check
    List<bool> verificationList = [];
    for(var validation in validationList) {
      verificationList.add(validation.validationState!);
    }
    return SizedBox(
      width: 80 / 1.1,
      height: 38.31 / 1.1,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
        child: InkWell(
          splashColor: CrocoBase.lightenColorForHighlight(Theme.of(context).colorScheme.primary),
          onTap: (() {

            if(widget.parentGlobalKey != null && widget.index == null) {
              ref.read(formStatePodProvider.notifier).focusedForm(widget.parentGlobalKey, true);
              Future.delayed(const Duration(milliseconds: 1300 ), (() =>  ref.read(formStatePodProvider.notifier).focusedForm(widget.parentGlobalKey, false)));
              Future.delayed(Duration(microseconds: 15), () {
              if(widget.parentGlobalKey!.currentState!.validate()) {
                
                widget.parentGlobalKey!.currentState!.save();
                

              }
            });
            } else if(widget.parentGlobalKey == null && widget.index != null) {

              ref.read(formStatePodProvider.notifier).focusedFormCollection(widget.index, true);
               Future.delayed(const Duration(milliseconds: 1300), (() =>  ref.read(formStatePodProvider.notifier).focusedFormCollection(widget.index, false)));
               Future.delayed(Duration(microseconds: 15), () {
              
                for(var formKey in widget.globalKeysList!) {
                  if(formKey.currentState!.validate()) {

                    if(verificationList.firstWhere((element) => element == false, orElse: () => true)) {

                      formKey.currentState!.save();
                      ref.read(formStatePodProvider.notifier).focusedForm(formKey, false);
                    }
                    
                  }
                }
              
            });
            } else if(widget.parentGlobalKey != null && widget.index != null) {
              throw("SquaredButton can't be provided with a globalKey and an index");
            } else if(widget.parentGlobalKey == null && widget.index == null) {
              throw("SquaredButton don't have any key or index");
            }
           
            
            

            
          }),
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // color: widget.backgroundColor ?? Theme.of(context).colorScheme.primary
            ),
            child: Text(
              widget.text!,
              style: TextStyle(
                color: widget.textColor ?? Theme.of(context).colorScheme.onPrimary
              )
            )
          ),
        ),
      )
    );
  }
}