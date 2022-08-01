import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../widgets/forms/croco_forms.dart' show FormValidation;

class FormData {

  FormData({this.data = const <String, String>{}, this.key, this.index, this.uuid, this.objectIdentifier});

  final Map<String, String>? data;
  final GlobalKey<FormState>? key;
  final int? index;
  final Uuid? uuid;
  final String? objectIdentifier;


  FormData copyWith({Map<String, String>? data, GlobalKey<FormState>? key, int? index, Uuid? uuid, String? objectIdentifier}) {
    
    return FormData(
      data: data ?? this.data,
      key: key?? this.key,
      index: index ?? this.index,
      uuid: uuid ?? this.uuid,
      objectIdentifier: objectIdentifier ?? this.objectIdentifier
    );
  }
}

class FormDataNotifier extends StateNotifier<FormData> {

  FormDataNotifier() : super(FormData());

  void addFormData(FormData formData) {

    state = formData;
  }
}

final formDataProvider = StateNotifierProvider<FormDataNotifier, FormData>((ref) {

  return FormDataNotifier();
});


final dataMap = Provider((ref) => <String, String>{});

final objectIdentifiersProvider = Provider((ref) => <String, String>{});

final numberOfFormsProvider = Provider(((ref) => <int, int>{}));

final verificationCountProvider = Provider(((ref) => <int, int>{}));
