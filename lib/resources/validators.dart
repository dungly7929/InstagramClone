import 'package:flutter/material.dart';
import 'dart:async';

class Validatros {
  bool eValidValidEmail(String emailValue) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    return regex.hasMatch(emailValue);
  }

  String eValidPassword(String input) {
    final RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (input.isEmpty) {
      return "This can not be empty";
    } else if (!regex.hasMatch(input)) {
      return "Please input ";
    }
    return "hehe";
  }
}
