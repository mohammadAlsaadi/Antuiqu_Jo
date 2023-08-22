// ignore_for_file: unused_local_variable

import 'package:antique_jo/screen/auth_screen/owner_signup_page/owner_signup_screen.dart';
import 'package:flutter/material.dart';

Widget passwordException(BuildContext context) {
  double pageWidth = MediaQuery.of(context).size.width;
  double pageHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.only(left: pageWidth * 0.06, right: pageWidth * 0.06),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 236, 236, 236),
      ),
      padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
      child: Padding(
        padding: EdgeInsets.all(pageWidth * 0.01),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A - Z, at least one uppercase letter',
                style: TextStyle(
                  color: capitalLetterValid ? Colors.green : Colors.red,
                  fontSize: 13,
                ),
              ),
              Text(
                '# \$ @ ! % * ^ &, at least one special character',
                style: TextStyle(
                  color: specialCharacterValid ? Colors.green : Colors.red,
                  fontSize: 13,
                ),
              ),
              Text(
                '0 1 ... 8 9, at least one digit number',
                style: TextStyle(
                  color: numberValid ? Colors.green : Colors.red,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
