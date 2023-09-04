import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/customer_home/customer_bloc/customer_home_bloc.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatefulWidget {
  final CarInfo carData;
  final bool isOwner;
  const DetailPage({super.key, required this.carData, required this.isOwner});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> carList = {};
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CustomerHomeBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<CustomerHomeBloc, CustomerHomeState>(
            listener: (context, state) {
              if (state is BookCarSuccessedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("The cae is booked !")),
                );
                Navigator.pop(context);
              } else if (state is BookCarFailedState) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Text("Something is wrong! , try again"),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  color: white,
                  child: Stack(
                    children: [
                      Positioned(
                        child: SizedBox(
                          width: pageWidth,
                          height: pageHeight * 0.4,
                          child: CachedNetworkImage(
                            imageUrl: widget.carData.carImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: pageWidth,
                                height: pageHeight * 0.4,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: pageHeight * 0.01,
                          left: pageWidth * 0.04,
                          child: SizedBox(
                            width: pageWidth * 0.08,
                            height: pageHeight * 0.04,
                            child: CircleAvatar(
                              backgroundColor: white,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_sharp,
                                    color: appBarColor,
                                    size: 20,
                                  )),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          top: pageHeight * 0.3,
                        ),
                        child: Container(
                          width: pageWidth,
                          height: pageHeight * 0.65,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: white,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: pageHeight * 0.14,
                                left: pageWidth * 0.15,
                                child: Text(
                                  widget.carData.carType,
                                  style: typeOfCarFont,
                                ),
                              ),
                              Positioned(
                                top: pageHeight * 0.06,
                                left: pageWidth * 0.7,
                                child: Text(
                                  "${widget.carData.carPrice} \$",
                                  style: priceOfCarFont,
                                ),
                              ),
                              Positioned(
                                  top: pageHeight * 0.12,
                                  left: pageWidth * 0.69,
                                  child: Visibility(
                                    visible: widget.isOwner == false,
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.carData.isBooked
                                            ? null
                                            : BlocProvider.of<CustomerHomeBloc>(
                                                    context)
                                                .add(BookCarEvent(
                                                    carModel: widget.carData));
                                      },
                                      child: Container(
                                        width: pageWidth * 0.2,
                                        height: pageHeight * 0.05,
                                        decoration: BoxDecoration(
                                            color: widget.carData.isBooked
                                                ? grey
                                                : appBarColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Center(
                                          child: Text(
                                            widget.carData.isBooked
                                                ? 'Booked'
                                                : "Book now",
                                            style: buttonFont,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  top: pageHeight * 0.12,
                                  left: widget.carData.isBooked
                                      ? pageWidth * 0.69
                                      : pageWidth * 0.6,
                                  child: Visibility(
                                    visible: widget.isOwner == true,
                                    child: Container(
                                      width: widget.carData.isBooked
                                          ? pageWidth * 0.2
                                          : pageWidth * 0.3,
                                      height: pageHeight * 0.05,
                                      decoration: BoxDecoration(
                                          color: widget.carData.isBooked
                                              ? grey
                                              : appBarColor,
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      child: Center(
                                        child: Text(
                                          widget.carData.isBooked
                                              ? 'Booked'
                                              : "Not booked yet",
                                          style: buttonFont,
                                        ),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  top: pageHeight * 0.18,
                                  left: pageWidth * 0.15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: widget.carData.carName,
                                          style: subTypeOfCarFont,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '   ${widget.carData.carModel}',
                                                style: modelOfCarDetailFont),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: pageHeight * 0.04,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "The Renaul Arkana is a compact \n (C-segment) crossover",
                                            style: infoOfCarDetailFont,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: pageHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "GVM :",
                                                  style: carInformationLable,
                                                ),
                                                SizedBox(
                                                  width: pageWidth * 0.1,
                                                ),
                                                Text(
                                                  "5 Tons",
                                                  style: carInformationValue,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: pageHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Number of previous owner :",
                                                  style: carInformationLable,
                                                ),
                                                SizedBox(
                                                  width: pageWidth * 0.1,
                                                ),
                                                Text(
                                                  "3",
                                                  style: carInformationValue,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: pageHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Odometer :",
                                                  style: carInformationLable,
                                                ),
                                                SizedBox(
                                                  width: pageWidth * 0.1,
                                                ),
                                                Text(
                                                  "52,315 miles",
                                                  style: carInformationValue,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: pageHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Seating :",
                                                  style: carInformationLable,
                                                ),
                                                SizedBox(
                                                  width: pageWidth * 0.1,
                                                ),
                                                Text(
                                                  "5 seats",
                                                  style: carInformationValue,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: pageHeight * 0.03),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Drivetain :",
                                                  style: carInformationLable,
                                                ),
                                                SizedBox(
                                                  width: pageWidth * 0.1,
                                                ),
                                                Text(
                                                  "Four wheel drive",
                                                  style: carInformationValue,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: pageHeight * 0.04,
                                    left: pageWidth * 0.09,
                                    right: pageWidth * 0.09),
                                child: SizedBox(
                                  width: pageWidth * 0.22,
                                  height: pageHeight * 0.06,
                                  child: Image.asset(
                                    "assets/images/${widget.carData.carType}.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Positioned(
                      //   top: pageHeight * 0.21,
                      //   left: pageWidth * 0.28,
                      //   child: Text(
                      //     widget.car.carDate,
                      //     style: modelOfCarDetailFont,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
