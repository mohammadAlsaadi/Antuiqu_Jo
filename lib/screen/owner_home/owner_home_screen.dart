// ignore_for_file: unused_local_variable, avoid_print

import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/detail_page/detail_bloc/detail_bloc.dart';
import 'package:antique_jo/data/login_register/Login_Register_bloc/login_register_bloc.dart';
import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/data/owner_home/owner_home_bloc/owner_home_bloc.dart';
import 'package:antique_jo/data/profile/profile_bloc/profile_bloc.dart';
import 'package:antique_jo/screen/Profile/profile.dart';
import 'package:antique_jo/screen/add_edit/add_edit_page.dart';
import 'package:antique_jo/screen/detail_page/detail_page.dart';
import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class OwnerHomePage extends StatefulWidget {
  final bool isOwner;
  final OwnerInfo? ownerData;
  const OwnerHomePage({super.key, required this.isOwner, this.ownerData});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  List<CarInfo> carsList = [];
  bool isLoading = false;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus}');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // print('Got a message whilst in the foreground!');
        // print('Message data: ${message.data}');
        // print('Message from: ${message.from}');

        print(
            'message title : ${message.notification?.title} || body: ${message.notification?.body}');
        AwesomeDialog(
            context: context,
            title: message.notification!.title,
            body: Text('body :         ${message.notification!.body}'));
        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });
    }
    String? token = await messaging.getToken(
      vapidKey: "BGpdLRs......",
    );
    print('token ::::::::$token');
  }

  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }
  }

  @override
  void initState() {
    requestPermission();

    initalMessage();

    super.initState();
  }

  OwnerInfo? ownerInfo;

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double cardWidth = MediaQuery.of(context).size.width * 0.97;
    double cardHeight = MediaQuery.of(context).size.height * 0.26;
    double containerImageWidth = cardWidth - 70.5;
    double containerImageHeight = cardHeight - 11;
    double fogContainerHeight = containerImageHeight * 0.4;

    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginRegisterBloc>(
            create: (context) => LoginRegisterBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<OwnerHomeBloc>(
            create: (context) => OwnerHomeBloc()..add(InitialHomeEvent()),
          ),
          BlocProvider(create: (contex) => DetailBloc()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<LoginRegisterBloc, LoginRegisterState>(
              listener: (context, state) {
                if (state is LogoutState) {
                  const CircularProgressIndicator(
                    color: appBarColor,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TypeOfUser(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is LoadingProfileDataState) {
                  const CircularProgressIndicator();
                }
                if (state is LoadedOwnerProfileDataState) {
                  ownerInfo = state.ownerInfo;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Profil(isOwner: true, ownerInfo: ownerInfo),
                      ));
                }
              },
            ),
            BlocListener<OwnerHomeBloc, OwnerHomeState>(
              listener: (context, state) {
                if (state is LoadedCarState) {
                  carsList = state.carData;
                }
                if (state is CarFailureState) {
                  const Text("Something is wrong!");
                }
                if (state is DeleteCarSuccessfullyState) {
                  // BlocProvider.of<OwnerHomeBloc>(context)
                  //     .add(InitialHomeEvent());

                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                  Fluttertoast.showToast(
                    msg: "The car is deleted",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: grey,
                    textColor: backgroundColor,
                    fontSize: 16.0,
                  );
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => super.widget));
                } else if (state is CarFailureState) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text("Something is wrong!")),
                  // );
                }
              },
            )
          ],
          child: BlocBuilder<OwnerHomeBloc, OwnerHomeState>(
            builder: (scaffoldContext, state) {
              // if (state is LoadingCarState) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              return Scaffold(
                drawer: Drawer(
                  // shadowColor: appBarColor,
                  // backgroundColor: appBarColor,

                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0, -2),
                          end: Alignment(0, 0.5),
                          colors: [
                            Color(0xff4a6741),
                            Color(0xff3f5a36),
                            Color(0xff374f2f),
                            Color(0xff304529),
                            Color(0xff22311d),
                          ]),
                    ),
                    child: ListView(children: [
                      DrawerHeader(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "more options ",
                            style: appBarFont,
                          )),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.person, color: buttonWhite),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Profile",
                                style: TextStyle(color: buttonWhite)),
                          ],
                        ),
                        onTap: () {
                          BlocProvider.of<ProfileBloc>(scaffoldContext)
                              .add(LoadOwnerProfileEvent(isOwner: true));
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.logout_outlined, color: buttonWhite),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Logout",
                                style: TextStyle(color: buttonWhite)),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                              context: scaffoldContext,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: appBarColor,
                                  title: const Text(
                                    'Logout',
                                    style: TextStyle(color: white),
                                  ),
                                  content: isLoading
                                      ? const CircularProgressIndicator() // Show loading indicator if isLoading is true
                                      : const Text(
                                          'Are you sure you want to logout?',
                                          style: TextStyle(color: white),
                                        ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          BlocProvider.of<LoginRegisterBloc>(
                                                  scaffoldContext)
                                              .add(LogoutEvent()),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                                color: appBarColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      )
                    ]),
                  ),
                ),
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  title: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: pageWidth * 0.09,
                        ),
                        Text("Owner Home Page", style: appBarFont),
                      ],
                    ),
                  ),
                  backgroundColor: appBarColor,
                ),
                body: RefreshIndicator(
                  onRefresh: () {
                    return Navigator.pushReplacement(
                        scaffoldContext,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: pageWidth * 0.05, top: pageHeight * 0.02),
                    child: ListView.builder(
                      itemCount: carsList.length,
                      itemBuilder: (ownerBlocContext, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: cardWidth,
                              height: cardHeight,
                              child: GestureDetector(
                                onTap: () {
                                  // BlocProvider.of<DetailBloc>(context).add(
                                  //     SendDataToDetailPageEvent(index: index));
                                  CarInfo carData = carsList[index];

                                  Navigator.push(
                                    scaffoldContext,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          carData: carData,
                                          isOwner: widget.isOwner),
                                    ),
                                  );
                                },
                                onLongPress: () => showModalBottomSheet(
                                  backgroundColor: backgroundColor,
                                  context: scaffoldContext,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                        bottom: Radius.circular(30)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Container(
                                        color: white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: ListTile(
                                                  onTap: () {
                                                    Navigator.push(
                                                        ownerBlocContext,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddEditPage(
                                                            isEdit: true,
                                                            carEdit:
                                                                carsList[index],
                                                          ),
                                                        ));
                                                  },
                                                  title: Center(
                                                    child: Text("Edit",
                                                        style: cardOption),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: backgroundColor,
                                              height: 10,
                                            ),
                                            ListTile(
                                              onTap: () {
                                                showDialog(
                                                    context: scaffoldContext,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            appBarColor,
                                                        title: const Text(
                                                          'Delete car',
                                                          style: TextStyle(
                                                              color: white),
                                                        ),
                                                        content: const Text(
                                                          'Are you sure you want to Delete car?',
                                                          style: TextStyle(
                                                              color: white),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: white),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () => BlocProvider.of<
                                                                        OwnerHomeBloc>(
                                                                    ownerBlocContext)
                                                                .add(DeleteCarEvent(
                                                                    carUID: carsList[
                                                                            index]
                                                                        .carUUID)),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color:
                                                                          appBarColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              title: Center(
                                                child: Text("Delete",
                                                    style: cardOption),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                child: Card(
                                    color: backgroundColor,
                                    child: Hero(
                                      tag: 'car_${carsList[index].carImage}',
                                      child: Stack(children: [
                                        SizedBox(
                                          width: containerImageWidth,
                                          height: containerImageHeight,
                                          child: Stack(children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  carsList[index].carImage,
                                              width: containerImageWidth,
                                              height: containerImageHeight,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: const Color.fromARGB(
                                                    255, 177, 177, 177),
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: containerImageWidth,
                                                  height: containerImageHeight,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: containerImageWidth,
                                                height: fogContainerHeight,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: <Color>[
                                                      const Color.fromARGB(
                                                              255, 71, 71, 71)
                                                          .withAlpha(210),
                                                      const Color.fromARGB(
                                                              31, 79, 79, 79)
                                                          .withAlpha(210),
                                                      const Color.fromARGB(
                                                              179, 88, 88, 88)
                                                          .withAlpha(210),
                                                    ],
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      right:
                                                          containerImageWidth *
                                                              0.85,
                                                      top: fogContainerHeight *
                                                          0.03,
                                                      bottom: 50,
                                                      child: SizedBox(
                                                        width: 40,
                                                        height: 40,
                                                        child: Image.asset(
                                                            "assets/images/${carsList[index].carType}.png"),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        right:
                                                            containerImageWidth *
                                                                0.55,
                                                        top:
                                                            fogContainerHeight *
                                                                0.07,
                                                        child: Align(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  carsList[
                                                                          index]
                                                                      .carName,
                                                                  style:
                                                                      nameOfCarFont),
                                                              Text(
                                                                  carsList[
                                                                          index]
                                                                      .carModel,
                                                                  style:
                                                                      modelOfCarFont),
                                                            ],
                                                          ),
                                                        )),
                                                    Positioned(
                                                      right:
                                                          containerImageWidth *
                                                              0.05,
                                                      top: fogContainerHeight *
                                                          0.03,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              '${carsList[index].carPrice} \$',
                                                              style:
                                                                  priceOfCarFont),
                                                          Text(
                                                            " per week",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                color: grey,
                                                                fontSize: 9),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.4, right: 0.5),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                          color: white),
                                                  width: 85,
                                                  height: 30,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text("Details",
                                                              style:
                                                                  detailButtonFont),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      cardWidth *
                                                                          0.02),
                                                          child: const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: appBarColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        )
                                      ]),
                                    )),
                              )),
                        );
                      },
                    ),
                  ),
                ),
                floatingActionButton: CircleAvatar(
                  maxRadius: Checkbox.width + 10,
                  backgroundColor: backgroundColor,
                  child: FloatingActionButton(
                    elevation: 30,
                    hoverColor: backgroundColor,
                    heroTag: "button2",
                    backgroundColor: appBarColor,
                    onPressed: _navigateToAddCar,
                    child: const Icon(
                      Icons.add,
                      color: buttonWhite,
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void _navigateToAddCar() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditPage(isEdit: false),
      ),
    );
  }
}
