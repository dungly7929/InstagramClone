import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningdart/resources/auth_method.dart';
import 'package:learningdart/utils/colors.dart';
import 'package:learningdart/utils/utils.dart';
import 'package:learningdart/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    //use to check the keyboaard is open or not
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //svg picture
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(
              height: 18,
            ),
            //Cicular Widget to accept and show our selected file
            if (!isKeyboard)
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ))
                ],
              ),

            const SizedBox(
              height: 18,
            ),

            //Textfield input for username
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text),

            const SizedBox(
              height: 18,
            ),

            //Textfield input for email
            TextFieldInput(
              hintText: 'Enter your email.',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),

            const SizedBox(
              height: 18,
            ),

            //Textfile input for password
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 18,
            ),
            //Textfield input for bio
            TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text),

            const SizedBox(
              height: 18,
            ),

            //button signup
            InkWell(
              onTap: () async {
                String res = await AuthMethods().signUpUser(
                  email: _emailController.text,
                  password: _passwordController.text,
                  username: _usernameController.text,
                  bio: _bioController.text,
                  file: _image!,
                );
                print(res);
              },
              child: Container(
                child: const Text('Sign up'),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),

            Flexible(
              child: Container(),
              flex: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text('Already have an account ?'),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
