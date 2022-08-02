import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileSreenLayout extends StatefulWidget {
  const MobileSreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileSreenLayout> createState() => _MobileSreenLayoutState();
}

class _MobileSreenLayoutState extends State<MobileSreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is mobile'),
      ),
    );
  }
}
