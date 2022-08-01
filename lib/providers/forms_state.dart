

import 'dart:html';

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
    this.dataIsSaved = false,
    this.objectIdentifier,
  });

  final GlobalKey<FormState>? globalKey;
  final bool? validationState;
  final String? name;
  final bool? focused;
  final int? index;
  final FormValidation? formValidation;
  final bool? dataIsSaved;
  final String? objectIdentifier;

  FormStatePod copyWith({GlobalKey<FormState>? globalKey, bool? validationState, String? name, bool? focused, int? index, 
  FormValidation? formValidation, bool? dataIsSaved}) {
    return FormStatePod(
      globalKey : globalKey ?? this.globalKey,
      validationState: validationState ?? this.validationState,
      name: name ?? this.name,
      focused: focused ?? this.focused,
      index: index ?? this.index,
      formValidation: formValidation ?? this.formValidation,
      dataIsSaved: dataIsSaved ?? this.dataIsSaved,
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

  void changeDataIsSaved(GlobalKey<FormState>? globalKey, bool status) {

    state = [
      for(final formStatePod in state) 

      if(formStatePod.globalKey == globalKey)

      formStatePod.copyWith(dataIsSaved: status)

      else

        formStatePod
    ];
  }

  void changeDataIsSavedCollection(int? index, bool status) {

    state = [
      for(final formStatePod in state)

      if(formStatePod.index == index)

      formStatePod.copyWith(dataIsSaved: status)

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


class LogInFormState {

  LogInFormState({
    required this.usernameFocused,
    required this.passwordFocused,
    required this.usernameOnError,
    required this.passwordOnError,
    this.firebaseAuthMessage,
    this.eCode,
    this.arrangeFormTitle,
    //arrangeFormTitle. 0 = false, 1 = true username, 2 = true password
  });

  final bool usernameFocused;
  final bool passwordFocused;
  final bool usernameOnError;
  final bool passwordOnError;
  final String? firebaseAuthMessage;
  final String? eCode;
  final int? arrangeFormTitle;

  LogInFormState copyWith({bool? usernameFocused, bool? passwordFocused, bool? usernameOnError, bool? passwordOnError, 
    String? firebaseAuthMessage, String? eCode, int? arrangeFormTitle}) {

    return LogInFormState(
      usernameFocused: usernameFocused ?? this.usernameFocused,
      passwordFocused: passwordFocused ?? this.passwordFocused,
      usernameOnError: usernameOnError ?? this.usernameOnError,
      passwordOnError: passwordOnError ?? this.passwordOnError,
      firebaseAuthMessage: firebaseAuthMessage ?? this.firebaseAuthMessage,
      eCode: eCode ?? this.eCode,
      arrangeFormTitle: arrangeFormTitle ?? this.arrangeFormTitle
    );
  }

  @override
  String toString() {
    
    return """{usernameFocused: $usernameFocused\n passwordFocused: $passwordFocused\n usernameOnError: $usernameOnError
 passwordOnError: $passwordOnError\n firebaseAuthMessage: $firebaseAuthMessage\n eCode: $eCode\n $arrangeFormTitle}""";
  }
}

class LogInFormNotifier extends StateNotifier<LogInFormState> {

  LogInFormNotifier() : super(LogInFormState(usernameFocused: false, passwordFocused: false, usernameOnError: false, passwordOnError: false));

  void changeFocusStatus({bool? usernameFocused, bool? passwordFocused, bool? usernameOnError, bool? passwordOnError, 
    String? firebaseAuthMessage, String? eCode, int? arrangeFormTitle}) {

    state = state.copyWith(
      usernameFocused: usernameFocused,
      passwordFocused: passwordFocused,
      usernameOnError: usernameOnError,
      passwordOnError: passwordOnError,
      firebaseAuthMessage: firebaseAuthMessage,
      eCode: eCode,
      arrangeFormTitle: arrangeFormTitle
    );
  }
}

final logInFormProvider = StateNotifierProvider<LogInFormNotifier, LogInFormState>(((ref) {
  return LogInFormNotifier();
}));

final futureFormState = FutureProvider(
  (ref) => ref.read(logInFormProvider)
);

final usernameProvider = Provider<String>(((ref) => ""));

final passwordProvider = Provider<String>(((ref) => ""));