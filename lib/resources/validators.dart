import 'package:flutter/material.dart';
import 'dart:async';

class Validatros {
  bool eValidValidEmail(String emailValue) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    return regex.hasMatch(emailValue);
  }
}

bool eValidPassword(input) {
  final RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  if (!regex.hasMatch(input)) {
    return false;
  }
  return true;
}

//valid Username input
evalUsername(value) {
  if (value.isEmpty) {
    return "username is required";
  } else {
    if (value.length < 6) {
      return "your username is too short !";
    } else {
      return null;
    }
  }
}

//validEmail input
evalEmail(value) {
  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (value.isEmpty) {
    return "email is required";
  } else if (!regex.hasMatch(value)) {
    return 'please enter the valid email';
  } else {
    return null;
  }
}

evalBio(value) {
  if (value.isEmpty) {
    return "Please enter your bio";
  }
  return null;
}

final validatorBloc = Validatros;
