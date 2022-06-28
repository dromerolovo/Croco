import 'package:croco/state/forms_state.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../themes/themes.dart';


class ConsolidationForm extends ConsumerStatefulWidget {
  ConsolidationForm({
    Key? key,
    }) : super(key: key);


  @override
  ConsumerState<ConsolidationForm> createState() => _ConsolidationFormState();
}

class _ConsolidationFormState extends ConsumerState<ConsolidationForm> {
  @override
  Widget build(BuildContext context) {
    var formsList = ref.watch(formStatePodProvider);
    return Container(
      alignment: Alignment.centerLeft,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            height: 120,
            child: Container(
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
          )
        ]
      )
    );
  }
}