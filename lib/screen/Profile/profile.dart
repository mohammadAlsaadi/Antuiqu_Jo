// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:antique_jo/data/login_register/login_register_models/customer/customers_info.dart';
import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/data/profile/profile_bloc/profile_bloc.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profil extends StatefulWidget {
  final OwnerInfo? ownerInfo;
  final CustomersInfo? customersInfo;

  final bool isOwner;

  const Profil({
    Key? key,
    this.ownerInfo,
    this.customersInfo,
    required this.isOwner,
  }) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _nameKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();

  CustomersInfo? customersInfo;
  OwnerInfo? ownerInfo;
  bool changeButton = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.isOwner
            ? widget.ownerInfo!.ownerFullName
            : widget.customersInfo!.customerFullName);
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text('Profile Informations'),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ChangeNameState) {
              _nameController.text = state.nameOfUser;
              changeButton = false;
              Fluttertoast.showToast(
                msg: "The name is change successfully",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: appBarColor,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: appBarColor,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, bottom: 0),
                              child: Icon(
                                Icons.perm_identity_rounded,
                                size: 35,
                                color: personColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: pageWidth * 0.05,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: profilBox,
                              ),
                              width: pageWidth * 0.7,
                              height: pageHeight * 0.06,
                              child: TextField(
                                key: _nameKey,
                                controller: _nameController,
                                textAlign: TextAlign.center,
                                style: nameOfProfilePage,
                                onChanged: (value) {
                                  changeButton = true;
                                },
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: appBarColor,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, bottom: 0),
                              child: Icon(
                                Icons.email_outlined,
                                size: 35,
                                color: personColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: pageWidth * 0.05,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: profilBox,
                              ),
                              width: pageWidth * 0.7,
                              height: pageHeight * 0.06,
                              child: Center(
                                child: widget.isOwner
                                    ? Text(
                                        widget.ownerInfo!.ownerEmail,
                                        style: profilePagefont,
                                      )
                                    : Text(widget.customersInfo!.customerEmail,
                                        style: profilePagefont),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: appBarColor,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, bottom: 0),
                              child: Icon(
                                Icons.phone_enabled_outlined,
                                size: 35,
                                color: personColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: pageWidth * 0.05,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: profilBox,
                              ),
                              width: pageWidth * 0.7,
                              height: pageHeight * 0.06,
                              child: Center(
                                child: widget.isOwner
                                    ? Text(
                                        '0${widget.ownerInfo!.ownerPhoneNumber}',
                                        style: profilePagefont)
                                    : Text(
                                        '0${widget.customersInfo!.customerPhoneNumber}',
                                        style: profilePagefont),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: appBarColor,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, bottom: 0),
                              child: Icon(
                                Icons.numbers_outlined,
                                size: 35,
                                color: personColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: pageWidth * 0.05,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: profilBox,
                              ),
                              width: pageWidth * 0.7,
                              height: pageHeight * 0.06,
                              child: Center(
                                child: widget.isOwner
                                    ? Text(widget.ownerInfo!.ownerUUID,
                                        style: profilePagefont)
                                    : Text(widget.customersInfo!.customerUUID,
                                        style: profilePagefont),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: pageHeight * 0.07),
                      child: Visibility(
                          visible: changeButton,
                          child: MaterialButton(
                              color: appBarColor,
                              child: Text("Save Change", style: nameOfCarFont),
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ChangeNameEvent(
                                        isOwner: widget.isOwner,
                                        nameOfUser: _nameController.text));
                              })),
                    )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
