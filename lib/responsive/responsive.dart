import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learningdart/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreensize) {
          //web Screen
          return webScreenLayout;
        }
        return mobileScreenLayout;
        //mobile screen
      },
    );
  }
}
