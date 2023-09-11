// ignore_for_file: avoid_print

import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/customer_home/customer_bloc/customer_home_bloc.dart';
import 'package:antique_jo/data/login_register/Login_Register_bloc/login_register_bloc.dart';
import 'package:antique_jo/screen/detail_page/detail_page.dart';

import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CustomerHomePage extends StatefulWidget {
  final bool isOwner;

  const CustomerHomePage({super.key, required this.isOwner});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  List<CarInfo> carsList = [];
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
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        //   print('Message from: ${message.from}');
        // AwesomeDialog(
        //     context: context,
        //     title: 'title',
        //     body: Text('body :         ${message.notification!.body}'));
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
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    });
    initalMessage();

    super.initState();
  }

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
        BlocProvider(
          create: (context) => LoginRegisterBloc(),
        ),
        BlocProvider(
          create: (context) => CustomerHomeBloc()..add(AllCarFitchEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginRegisterBloc, LoginRegisterState>(
            listener: (context, state) {
              if (state is LogoutState) {
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
          BlocListener<CustomerHomeBloc, CustomerHomeState>(
              listener: (context, state) {
            if (state is LoadingCarsState) {
              const Center(child: CircularProgressIndicator());
            }
            if (state is LoadedCarsState) {
              carsList = state.carData;
            }
            // if (state is BookCarSuccessedState) {
            //   const SnackBar(content: Text("The car is booked "));
            //   BlocProvider.of<CustomerHomeBloc>(context)
            //       .add(InitialCustomerHomeEvent());
            // } else if (state is BookCarFailedState) {
            //   showDialog(
            //     context: context,
            //     builder: (context) =>
            //         const Text("Something is wrong! , try again"),
            //   );
            //   Navigator.pop(context);
            // }
          })
        ],
        child: BlocBuilder<CustomerHomeBloc, CustomerHomeState>(
          builder: (context, state) {
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
                          Icon(Icons.logout_outlined, color: buttonWhite),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Logout", style: TextStyle(color: buttonWhite)),
                        ],
                      ),
                      onTap: () {
                        BlocProvider.of<LoginRegisterBloc>(context)
                            .add(LogoutEvent());
                      },
                    )
                  ]),
                ),
              ),
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                title: Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Customer Home Page",
                        style: appBarFont,
                      ),
                    ],
                  ),
                ),
                backgroundColor: appBarColor,
              ),
              body: Padding(
                padding: EdgeInsets.only(
                    left: pageWidth * 0.05, top: pageHeight * 0.02),
                child: ListView.builder(
                  itemCount: carsList.length,
                  itemBuilder: (context, index) {
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
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      carData: carData,
                                      isOwner: widget.isOwner),
                                ),
                              );
                            },
                            child: Card(
                              shadowColor:
                                  carsList[index].isBooked ? grey : null,
                              color: backgroundColor,
                              child: Stack(children: [
                                SizedBox(
                                  width: containerImageWidth,
                                  height: containerImageHeight,
                                  child: Stack(children: [
                                    CachedNetworkImage(
                                      imageUrl: carsList[index].carImage,
                                      width: containerImageWidth,
                                      height: containerImageHeight,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            255, 177, 177, 177),
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: containerImageWidth,
                                          height: containerImageHeight,
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    Positioned(
                                      child: Visibility(
                                          visible: carsList[index].isBooked,
                                          child: SizedBox(
                                            child: Banner(
                                              message: 'Booked',
                                              location: BannerLocation.topStart,
                                              color: white,
                                              textStyle: bannerFont,
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: containerImageWidth,
                                        height: fogContainerHeight,
                                        alignment: Alignment.bottomCenter,
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
                                              right: containerImageWidth * 0.85,
                                              top: fogContainerHeight * 0.03,
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
                                                    containerImageWidth * 0.55,
                                                top: fogContainerHeight * 0.07,
                                                child: Align(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          carsList[index]
                                                              .carName,
                                                          style: nameOfCarFont),
                                                      Text(
                                                          carsList[index]
                                                              .carModel,
                                                          style:
                                                              modelOfCarFont),
                                                    ],
                                                  ),
                                                )),
                                            Positioned(
                                              right: containerImageWidth * 0.05,
                                              top: fogContainerHeight * 0.03,
                                              child: Text(
                                                  '${carsList[index].carPrice} \$',
                                                  style: priceOfCarFont),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 0.4, right: 0.5),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                              ),
                                              color: white),
                                          width: 85,
                                          height: 30,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text("Details",
                                                      style: detailButtonFont),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: cardWidth * 0.02),
                                                  child: const Icon(
                                                    Icons.arrow_forward_ios,
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
                            ),
                          )),
                    );
                  },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: grey,
                  fixedColor: appBarColor,
                  backgroundColor: backgroundColor,
                  currentIndex: _selectIndex,
                  onTap: (int indexSelected) {
                    setState(() {
                      _selectIndex = indexSelected;
                    });

                    if (_selectIndex == 1) {
                      BlocProvider.of<CustomerHomeBloc>(context)
                          .add(MyCarFitchEvent());
                    } else {
                      BlocProvider.of<CustomerHomeBloc>(context)
                          .add(AllCarFitchEvent());
                    }
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.car_crash,
                      ),
                      label: 'All cars',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.car_rental_outlined),
                      label: 'my cars',
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }

  int _selectIndex = 0;
}
