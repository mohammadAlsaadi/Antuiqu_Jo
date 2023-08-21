import 'package:antique_jo/data/blocs/type_of_user/type_of_user_bloc.dart';
import 'package:antique_jo/screen/auth_screen/login.dart/login_page.dart';
import 'package:antique_jo/screen/type_of_user/type_of_user_widget.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/fonts/fonts.dart';

class TypeOfUser extends StatefulWidget {
  const TypeOfUser({super.key});

  @override
  State<TypeOfUser> createState() => _TypeOfUserState();
}

class _TypeOfUserState extends State<TypeOfUser> {
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    // double cardWidth = pageWidth * 0.2;
    // double cardHeight = pageHeight * 0.1;

    return BlocProvider(
      create: (context) => TypeOfUserBloc(),
      child: Scaffold(
        body: BlocConsumer<TypeOfUserBloc, TypeOfUserState>(
          listener: (context, state) {
            if (state is ChossingOwner) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(isOwner: true)),
              );
            } else if (state is ChossingCustomer) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(
                          isOwner: false,
                        )), // Replace with the actual customer home page
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                width: pageWidth,
                height: pageHeight,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/'),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '\tWelcome To ', style: header2BlackFont),
                          TextSpan(
                              text: ' Antique Jo', style: header1GreenFont),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageWidth * 0.1),
                        child: Text(
                          "Please let us know which user type best describes you",
                          style: infoOfCarDetailFont,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ownerCard(context),
                      SizedBox(
                        height: pageHeight * 0.02,
                      ),
                      userCard(context)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
