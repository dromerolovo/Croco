

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/forms/croco_forms.dart' show FormValidation;

@immutable
class FormStatePod{

  const FormStatePod({
    this.globalKey,
    this.validationState = false,
    this.name,
    this.focused = false,
    this.index,
    this.formValidation,
    this.firedButton = false,
    this.objectIdentifier,
  });

  final GlobalKey<FormState>? globalKey;
  final bool? validationState;
  final String? name;
  final bool? focused;
  final int? index;
  final FormValidation? formValidation;
  final bool? firedButton;
  final String? objectIdentifier;

  FormStatePod copyWith({GlobalKey<FormState>? globalKey, bool? validationState, String? name, bool? focused, int? index, FormValidation? formValidation, bool? firedButton}) {
    return FormStatePod(
      globalKey : globalKey ?? this.globalKey,
      validationState: validationState ?? this.validationState,
      name: name ?? this.name,
      focused: focused ?? this.focused,
      index: index ?? this.index,
      formValidation: formValidation ?? this.formValidation,
      firedButton: firedButton ?? this.firedButton,
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

  void focusedFormCollection(int? index, bool? focused) {
    state = [
      for(final formStatePod in state)

      if(formStatePod.index == index)

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


@immutable
class DataPicker {

  DataPicker({

    this.globalKey,
    this.focused,
    this.x,
    this.y,
    this.controller,
    this.parentKey

  });

  final GlobalKey? globalKey;
  final bool? focused;
  final double? x;
  final double? y;
  final TextEditingController? controller;
  final GlobalKey<FormState>? parentKey;


  DataPicker copyWith({GlobalKey? globalKey, bool? focused, double? x, double? y, TextEditingController? controller, GlobalKey<FormState>? parentKey}) {

    return DataPicker(

      globalKey: globalKey ?? this.globalKey,
      focused: focused ?? this.focused,
      x: x ?? this.x,
      y: y ?? this.y,
      controller: controller ?? this.controller,
      parentKey: parentKey ?? this.parentKey

    );
  }
}

class DataPickerNotifier extends StateNotifier<List<DataPicker>> {

  DataPickerNotifier() : super([]);

  void addDataPicker(DataPicker dataPicker) {

    state = [...state, dataPicker];
  }

  void changeFocusStatus(GlobalKey globalKey, bool? focused) {

    state = [

      for(final dataPicker in state)

      if(dataPicker.globalKey == globalKey)

      dataPicker.copyWith(focused: focused)

    ];
  }
}

final dataPickerProvider = StateNotifierProvider<DataPickerNotifier, List<DataPicker>>((ref) {

  return DataPickerNotifier();
  
});




