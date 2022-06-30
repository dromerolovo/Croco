import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class FormStatePod{

  FormStatePod({
    this.globalKey,
    this.validationState = false,
    this.name,
    this.focused = false,
    this.index
  });

  final GlobalKey<FormState>? globalKey;
  final bool? validationState;
  final String? name;
  final bool? focused;
  final int? index;

  FormStatePod copyWith({GlobalKey<FormState>? globalKey, bool? validationState, String? name, bool? focused, int? index}) {
    return FormStatePod(
      globalKey : globalKey ?? this.globalKey,
      validationState: validationState ?? this.validationState,
      name: name ?? this.name,
      focused: focused ?? this.focused,
      index: index ?? this.index


    );
  }
}

class FormStatePodNotifier extends StateNotifier<List<FormStatePod>> {

  FormStatePodNotifier() : super([]);

  void addFormStatePod(FormStatePod formStatePod) {

    state = [...state, formStatePod];
  }

  void changeValidationStatus(GlobalKey<FormState>? globalKey, bool status) {

    state = [
      for(final formStatePod in state) 

      if(formStatePod.globalKey == globalKey)

      formStatePod.copyWith(validationState: status)

      else

        formStatePod

    ];
  }

  void focusedForm(GlobalKey<FormState>? globalKey, bool? focused) {
    state = [

      for(final formStatePod in state) 
      
      if(formStatePod.globalKey == globalKey)

      formStatePod.copyWith(focused: focused)

      else

        formStatePod

    ];
  }
}

final formStatePodProvider = StateNotifierProvider<FormStatePodNotifier, List<FormStatePod>>((ref) {
  return FormStatePodNotifier();
});

final formStatePodFiltered = StateProvider.family(((ref, int? index) {
  
  final forms = ref.watch(formStatePodProvider);
  
  return forms.where((element) => element.index == index);
}));




