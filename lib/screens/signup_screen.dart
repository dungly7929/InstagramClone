import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningdart/resources/auth_method.dart';
import 'package:learningdart/resources/signupdatamodel.dart';
import 'package:learningdart/resources/validators.dart';
import 'package:learningdart/utils/colors.dart';
import 'package:learningdart/utils/utils.dart';
import 'package:learningdart/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _btnEnabled = false;
  final model = SignUpDataModel(username: '', email: '', password: '', bio: '');
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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        onChanged: () => setState(() {
          _btnEnabled = _formKey.currentState!.validate();
        }),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                //svg picture
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),

                const SizedBox(
                  height: 16,
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
                  height: 16,
                ),

                //Textfield input for username
                TextFormField(
                  controller: _usernameController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value) => model.username,
                  validator: (value) => evalUsername(value),
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_box),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Please input your Username",
                      labelText: "Username *"),
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  onChanged: (value) => model.email,
                  validator: (value) => evalEmail(value),
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Please input your email",
                      labelText: "Email *"),
                ),

                const SizedBox(
                  height: 16,
                ),
                //Textfile input for password
                TextFormField(
                  controller: _passwordController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (value) => model.password,
                  validator: (value) => evalEmail(value),
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Please input your password",
                      labelText: "Password *"),
                ),

                const SizedBox(
                  height: 16,
                ),
                //Textfield input for bio
                TextFormField(
                  controller: _bioController,
                  cursorColor: Colors.blueAccent,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value) => model.bio,
                  validator: (value) => evalBio(value),
                  decoration: InputDecoration(
                      icon: Icon(Icons.book_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Please input your Bio",
                      labelText: "Bio *"),
                ),

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
                  height: 48,
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
          ),
        ),
      ),
    );
  }
}
