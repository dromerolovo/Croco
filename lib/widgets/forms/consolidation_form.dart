import 'package:croco/croco.dart';
import 'package:croco/providers/data_state.dart';
import 'package:croco/providers/forms_state.dart';
import 'package:croco/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../themes/themes.dart';


class ConsolidationForm extends ConsumerStatefulWidget {
  const ConsolidationForm({
    Key? key,
    this.index,
    required this.objectIdentifier,
    required this.numberOfForms
    }) : super(key: key);

    final int? index;
    final String objectIdentifier;
    final int numberOfForms;


  @override
  ConsumerState<ConsolidationForm> createState() => _ConsolidationFormState();
}

class _ConsolidationFormState extends ConsumerState<ConsolidationForm> {

  List<GlobalKey<FormState>> listOfKeys = [];
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(objectIdentifiersProvider)[widget.index.toString()] = widget.objectIdentifier;
    ref.read(numberOfFormsProvider)[widget.index!] = widget.numberOfForms;
    ref.read(verificationCountProvider)[widget.index!] = 0;
  }

  @override
  Widget build(BuildContext context) {
    count++;
    var formsList = ref.watch(formStatePodFiltered(widget.index)).where((element) => element.formValidation == FormValidation.group);

    if(count >= 1) {
      for(var form in formsList) {
        listOfKeys.add(form.globalKey!);
      }
    }
    
    return Container(
      margin: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            height: 120,
            child: Container(
              padding: EdgeInsets.only(top: 15),
              width: 200,
              height: 120,
              alignment: Alignment.centerLeft,
              child: Scrollbar(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    for(var form in formsList)
                    ListTile(
                      dense: true,
                      title: SelectableText(
                        form.name ?? "",
                        style: TextStyle(
                          color: CrocoTheme.of(context)!.themeDataExtra!.onSurface
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AvatarGlow(
                          glowColor: form.validationState == true ? Colors.green : Colors.red,
                          endRadius: 18,
                          child: Material(
                            elevation: 4,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            shadowColor: Colors.grey[700],
                            child: AnimatedContainer(
                              width: 20,
                              height: 20,
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color: form.validationState == true ? Colors.green : Colors.red,
                                shape: BoxShape.circle
                              ),
                            )
                          )
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 70),
            padding: EdgeInsets.only(bottom: 10),
            child: SquaredButton(
              index: widget.index,
              globalKeysList: listOfKeys,

            )
          )
        ]
      )
    );
  }
}