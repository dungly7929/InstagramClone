import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:learningdart/models/user.dart' as model;

class MobileSreenLayout extends StatefulWidget {
  const MobileSreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileSreenLayout> createState() => _MobileSreenLayoutState();
}

class _MobileSreenLayoutState extends State<MobileSreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text(user.email),
      ),
    );
  }
}
