import 'package:flutter/material.dart';

enum Validation {isEmpty, mail, cellphone}

extension ValidatorLogic on Validation {

   Function get validation {
    switch(this) {
      case Validation.isEmpty: return isEmptyValidation;
      case Validation.mail: return mailValidation;
      case Validation.cellphone: return cellphoneValidation;
    }
   }
}

dynamic isEmptyValidation(String? value) {

  if(value == null || value.isEmpty) {
    return "This field should not be empty";
  } else {
    return null;
  }
}

dynamic mailValidation(String? value) {


  if(value!.isEmpty) {
    return "This field should not be empty";
  } else if(!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
    return "This is not a mail";
  }
  else {
    return null;
  }
}

dynamic cellphoneValidation(String? value) {

  if(value!.isEmpty) {
    return "This field should not be empty";
  } else if(!RegExp(r"^[0-9]{9}").hasMatch(value)) {
    return "This is not a valid cellphone number";
  }
}



