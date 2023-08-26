// ignore_for_file: unused_field, avoid_print

import 'package:antique_jo/data/blocs/Login_Register_bloc/login_register_bloc.dart';
import 'package:antique_jo/data/repository/auth/firebase_auth.dart';
import 'package:antique_jo/models/owner/owner_Info.dart';
import 'package:antique_jo/screen/auth_screen/customer_signup_page.dart/customer_signup_widget.dart';
import 'package:antique_jo/screen/auth_screen/owner_signup_page/owner_signup_function.dart';
import 'package:antique_jo/screen/owner_home/owner_home_screen.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

bool capitalLetterValid = false;
bool specialCharacterValid = false;
bool numberValid = false;

class OwnerSignUpPage extends StatefulWidget {
  const OwnerSignUpPage({super.key});

  @override
  State<OwnerSignUpPage> createState() => _OwnerSignUpPageState();
}

class _OwnerSignUpPageState extends State<OwnerSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool phoneHasError = false;
  bool _isPasswordValid = true;
  bool _isObsecure = true;
  bool _isObsecure2 = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginRegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
          listener: (context, state) {
            if (state is LoginRegisterLoading) {
              const CircularProgressIndicator();
            } else if (state is LoginRegisterLoaded) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerHomePage(),
                ),
                (route) => false,
              );
            } else if (state is LoginRegisterFailure) {
              const Text("Something is wrong !");
            }
          },
          builder: (context, state) {
            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: pageHeight * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: TextFormField(
                          controller: _emailController,
                          validator: SignUpFunction.validateEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: TextFormField(
                          controller: _passwordController,
                          focusNode: passwordFocusNode,
                          obscureText: _isObsecure,
                          onChanged: (value) {
                            setState(() {
                              _isPasswordValid =
                                  SignUpFunction.isPasswordValid(value);
                            });
                          },
                          validator: SignUpFunction.validatePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: appBarColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObsecure = !_isObsecure;
                                  });
                                },
                                icon: Icon(
                                    !_isObsecure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: appBarColor)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                        ),
                      ),
                      passwordFocusNode.hasFocus
                          ? passwordException(context)
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: TextFormField(
                          controller: _confpasswordController,
                          obscureText: _isObsecure2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required ,Please enter a password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "confirm Password",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: appBarColor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObsecure2 = !_isObsecure2;
                                  });
                                },
                                icon: Icon(
                                  !_isObsecure2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: appBarColor,
                                )),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (value) {
                            _confpasswordController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) =>
                              value!.isEmpty ? " name required  " : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: " User name ",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.person_2_rounded,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            _nameController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: TextFormField(
                          controller: _shopNameController,
                          validator: (value) =>
                              value!.isEmpty ? " Shop name required  " : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: " Shop name ",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.store_mall_directory_outlined,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) async {
                            _nameController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.05),
                        child: IntlPhoneField(
                          dropdownIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: appBarColor,
                          ),
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              setState(() {
                                phoneHasError = true;
                              });
                            } else {
                              setState(() {
                                phoneHasError = false;
                              });
                            }
                            return null;
                          },
                          initialCountryCode: "JO",
                          focusNode: focusNode,
                          cursorColor: appBarColor,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color:
                                      phoneHasError ? Colors.red : Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color:
                                      phoneHasError ? Colors.red : Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      phoneHasError ? Colors.red : Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Phone Number',
                          ),
                          languageCode: "en",
                          onCountryChanged: (country) {
                            print('Country changed to: ${country.name}');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: pageHeight * 0.01),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(appBarColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_phoneNumberController.text.isNotEmpty) {
                              setState(() {
                                phoneHasError = false;
                              });
                            }
                            if (_phoneNumberController.text.isEmpty &&
                                _formKey.currentState!.validate() == false) {
                              setState(() {
                                phoneHasError = true;
                              });
                            }
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              String? userUID =
                                  Auth.userUIDFromFirebaseAuth().toString();

                              OwnerInfo newOwnerModel = OwnerInfo(
                                  ownerEmail: _emailController.text,
                                  ownerPassword: _passwordController.text,
                                  ownerUUID: userUID,
                                  ownerFullName: _nameController.text,
                                  ownerPhoneNumber: _phoneNumberController.text,
                                  ownerShopName: _shopNameController.text);

                              BlocProvider.of<LoginRegisterBloc>(context).add(
                                  OwnerSignUpEvent(
                                      newOwnerModel: newOwnerModel,
                                      email: _emailController.text,
                                      password: _passwordController.text));

                              const snackBar = SnackBar(
                                content: Text('Sign up successful'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
