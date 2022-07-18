import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../widgets/forms/croco_forms.dart' show FormValidation;

class FormData {

  FormData({this.data, this.key, this.index, this.uuid});

  final Map<dynamic, dynamic>? data;
  final GlobalKey<FormState>? key;
  final int? index;
  final Uuid? uuid;

  FormData copyWith({Map<dynamic, dynamic>? data, GlobalKey<FormState>? key, int? index, Uuid? uuid}) {
    
    return FormData(
      data: data ?? this.data,
      key: key?? this.key,
      index: index ?? this.index,
      uuid: uuid ?? this.uuid
    );
  }
}

class FormDataNotifier extends StateNotifier<List<FormData>> {

  FormDataNotifier() : super([]);

  void addFormData(FormData formData) {

    state = [...state, formData];
  }
}

final formDataProvider = StateNotifierProvider<FormDataNotifier, List<FormData>>((ref) {

  return FormDataNotifier();
});


final userData = FutureProvider((ref) => <dynamic, dynamic>{});