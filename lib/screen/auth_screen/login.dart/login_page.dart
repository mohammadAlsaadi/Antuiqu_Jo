// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_import, avoid_print
import 'package:antique_jo/data/login_register/Login_Register_bloc/login_register_bloc.dart';
import 'package:antique_jo/screen/auth_screen/customer_signup_page.dart/customer_signup_page.dart';
import 'package:antique_jo/screen/auth_screen/login.dart/login_function.dart';
import 'package:antique_jo/screen/auth_screen/owner_signup_page/owner_signup_screen.dart';
import 'package:antique_jo/screen/cusromer_home/customer_home_screen.dart';
import 'package:antique_jo/screen/owner_home/owner_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:antique_jo/utils/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/fonts/fonts.dart';

class LoginPage extends StatefulWidget {
  final bool? isOwner;
  const LoginPage({Key? key, required this.isOwner}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;
//______________________firebase Auth
  String errorMessage = "";
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginRegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: pageWidth * 0.2),
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
          listener: (context, state) {
            if (state is VisibilityToggledState) {
              isObsecure = state.isObsecure;
            }
            if (state is LoginRegisterLoaded) {
              _navigateToHomePage();
            } else if (state is LoginRegisterFailure) {
              const Text('something wrong , try  again later');
            }
          },
          builder: (context, state) {
            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: pageHeight * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.02),
                        child: TextFormField(
                          controller: _emailController,
                          validator: LoginFunction.validateEmail,
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
                        padding: EdgeInsets.all(pageHeight * 0.02),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: isObsecure,
                          validator: LoginFunction.validatePassword,
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
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<LoginRegisterBloc>(context)
                                      .add(ToggleVisibilityEvent(isObsecure));

                                  // setState(() {
                                  //   _isObsecure = !_isObsecure;
                                  // });
                                },
                                icon: Icon(!isObsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: pageHeight * 0.09),
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
                          onPressed: () {
                            BlocProvider.of<LoginRegisterBloc>(context)
                                .add(LoginSuccessEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: pageWidth * 0.44),
                        child: Row(
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: loginText,
                            ),
                            TextButton(
                                onPressed: () {
                                  if (widget.isOwner == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OwnerSignUpPage(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomerSignUpPage(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Register",
                                  style: loginFontButton,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  void _navigateToHomePage() async {
    try {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          if (widget.isOwner == true) {
            return const OwnerHomePage(
              isOwner: true,
            );
          } else {
            return const CustomerHomePage(
              isOwner: false,
            );
          }
        }),
        (route) => false,
      );
    } catch (e) {
      print("Login error__________________________________: $e");
    }
  }
}
