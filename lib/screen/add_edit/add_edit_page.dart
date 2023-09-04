// ignore_for_file: avoid_print

import 'package:antique_jo/data/add_edit/add_edit_bloc/add_edit_bloc.dart';
import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:antique_jo/api_manager/pexels_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class AddEditPage extends StatefulWidget {
  final bool isEdit;
  final CarInfo? carEdit;
  const AddEditPage({super.key, required this.isEdit, this.carEdit});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  int selectedIndexForType = -1;
  int selectedIndexForcolor = -1;
  int selectedIndexForImage = -1;
  String type = '';
  String colorCar = '';

  bool typeSelect = false;
  bool colorSelect = false;
  String carUIDForEdit = '';

  List<String> typeImages = [
    'Mercedes',
    'bmw',
    'audi',
    'Dodge',
    'ford',
  ];

  List<Color> carColors = [
    const Color(0xff000000),
    const Color(0xff9E9E9E),
    const Color(0xffFFFFFF),
    const Color(0xffFF9800),
    const Color(0xff673AB7),
    const Color(0xff9C27B0),
  ];
  List<String> lstOfColors = [
    '000000', // blak
    '9E9E9E', // grey
    'FFFFFF', // White;
    "FF9800", // orange

    '673AB7', // blue

    '9C27B0', // pink
  ];
  List<String> imageUrls = [];
  bool shouldRebuild = false;

  final _formKey = GlobalKey<FormState>();

  final PexelsRepository _repository = PexelsRepository();
  late String carImage = '';
  TextEditingController _carNameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _modelOfCarController = TextEditingController();
  String imageOfCarSelected = '';
  late String typeOfCar;
  late int selectCarColor;
  late int selectCarType;
  @override
  void initState() {
    if (widget.isEdit) {
      _carNameController = TextEditingController(text: widget.carEdit!.carName);
      _priceController = TextEditingController(text: widget.carEdit!.carPrice);
      _modelOfCarController =
          TextEditingController(text: widget.carEdit!.carModel);
      carImage = widget.carEdit!.carImage;
      typeOfCar = widget.carEdit!.carType;
      colorCar = widget.carEdit!.carColor;
      selectedIndexForcolor = widget.carEdit!.selectedColor;
      selectedIndexForType = widget.carEdit!.selectedType;
      typeSelect = true;
      colorSelect = true;
      carUIDForEdit = widget.carEdit!.carUUID;
    } else {
      _carNameController = TextEditingController();
      _priceController = TextEditingController();
      _modelOfCarController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AddEditBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Center(
            child:
                Text(widget.isEdit ? "Edit Car" : "Add Car", style: appBarFont),
          ),
        ),
        body: BlocConsumer<AddEditBloc, AddEditState>(
          listener: (context, state) {
            if (state is TypeOfCarState) {
              selectedIndexForType = state.stateOfIndex;
              type = typeImages[selectedIndexForType];
              shouldRebuild = true;
            }
            if (state is ColorOfCarState) {
              selectedIndexForcolor = state.stateOfIndex;
              colorCar = lstOfColors[selectedIndexForcolor];
              shouldRebuild = true;
            }
            if (state is ImageOfCarState) {
              carImage = state.imageCar;
              imageOfCarSelected = state.imageCar;
            }
            if (state is CarLoadingState) {
              const CircularProgressIndicator();
            } else if (state is AddCarSuccessfullyState) {
              _handelTheAdd();
            } else if (state is EditCarSuccessfullyState) {
              _handelTheAdd();
            } else if (state is CarFailureState) {
              const Text('Something is wrong, try again');
            }
          },
          // buildWhen: (previous, currentState) {
          //   return currentState is ColorOfCarState ||
          //       currentState is TypeOfCarState ||
          //       currentState is AddCarLoadingState ||
          //       currentState is AddCarSuccessfullyState ||
          //       currentState is AddCarFailureState;
          // },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: pageHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.013),
                        child: SizedBox(
                          height: 75,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: typeImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AddEditBloc>(context).add(
                                      SelectTypeOfCarEvent(
                                          selectedIndex: index));
                                  typeSelect = true;
                                },
                                child: selectedIndexForType == index
                                    ? Stack(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            width: 100,
                                            height: 100,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Center(
                                              child: Image.asset(
                                                'assets/images/${typeImages[index]}.png',
                                                fit: BoxFit.cover,
                                                width: 65,
                                                height: 65,
                                              ),
                                            ),
                                          ),
                                          const Positioned(
                                              right: 20,
                                              bottom: 45,
                                              child: SizedBox(
                                                width: 20,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  child: Icon(Icons.check,
                                                      size: 20,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ],
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/${typeImages[index]}.png',
                                            fit: BoxFit.cover,
                                            width: 65,
                                            height: 65,
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pageHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.013),
                        child: SizedBox(
                          height: 65,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: carColors.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AddEditBloc>(context).add(
                                        SelectColorOfCarEvent(
                                            selectedIndex: index));
                                    colorSelect = true;
                                  },
                                  child: selectedIndexForcolor == index
                                      ? Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Container(
                                                width: 65,
                                                height: 65,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    shape: BoxShape.circle,
                                                    color: carColors[index]),
                                              ),
                                            ),
                                            const Positioned(
                                                right: 20,
                                                bottom: 35,
                                                child: SizedBox(
                                                  width: 20,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Icon(Icons.check,
                                                        size: 20,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              shape: BoxShape.circle,
                                              color: carColors[index],
                                            ),
                                          ),
                                        ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pageHeight * 0.02,
                      ),
                      Visibility(
                        visible: typeSelect && colorSelect,
                        child: FutureBuilder<List<String>>(
                          future: _repository.searchPhotos(
                            carSearchQuery: type,
                            carColor: colorCar,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: grey,
                              ));
                            } else if (snapshot.hasError) {
                              return Text(
                                  'An error occurred: ${snapshot.error}');
                            } else {
                              imageUrls = snapshot.data!;
                              return SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: imageUrls.length,
                                  itemBuilder: (context, index) {
                                    bool isSelected;
                                    if (carImage == imageUrls[index]) {
                                      isSelected = true;
                                    } else {
                                      isSelected = false;
                                    }

                                    return SizedBox(
                                        width: 160,
                                        height: 100,
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<AddEditBloc>(
                                                    context)
                                                .add(SelectImageOfCarEvent(
                                                    carImage:
                                                        imageUrls[index]));
                                            print(imageUrls[index]);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                pageHeight * 0.013),
                                            child: Container(
                                              width: 160,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Colors.green
                                                      : Colors.transparent,
                                                  width: 5.0,
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: imageUrls[index],
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                    height: 100,
                                                    width: 150,
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              212,
                                                              212,
                                                              212),
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        color: Colors.white,
                                                        width: 100,
                                                        height: 160,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.013),
                        child: Text(
                          "Details ",
                          style: infoOfCarDetailFont,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.02),
                        child: TextFormField(
                          controller: _carNameController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter a car name!" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Car Name",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.car_crash,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            _carNameController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.02),
                        child: TextFormField(
                          controller: _priceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the description of your vehicle';
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
                            labelText: "Car Price",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.attach_money_rounded,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            _priceController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(pageHeight * 0.02),
                        child: TextFormField(
                          controller: _modelOfCarController,
                          validator: (value) =>
                              value!.isEmpty ? "Enter a date!" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Car Model",
                            labelStyle: const TextStyle(
                              color: appBarColor,
                            ),
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: appBarColor,
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (value) {
                            _modelOfCarController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: pageWidth * 0.35),
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
                            CarInfo newCarModel = await carModelData();
                            if (widget.isEdit) {
                              BlocProvider.of<AddEditBloc>(context)
                                  .add(EditCarEvent(carModel: newCarModel));
                            } else {
                              BlocProvider.of<AddEditBloc>(context)
                                  .add(AddNewCarEvent(carModel: newCarModel));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(widget.isEdit ? "Edit Car" : "Add Car"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pageHeight * 0.02,
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  void _handelTheAdd() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    Navigator.pop(context);
  }

  Future<CarInfo> carModelData() async {
    String carUID = generateUID();
    String userUID = await SharedPreferenceManager.getString(key: 'currentUID');

    CarInfo newCarModel = CarInfo(
        carType: typeImages[selectedIndexForType],
        carColor: lstOfColors[selectedIndexForcolor],
        carModel: _modelOfCarController.text,
        carName: _carNameController.text,
        carImage: imageOfCarSelected,
        carUUID: widget.isEdit ? carUIDForEdit : carUID,
        ownerID: userUID,
        customerID: '',
        isBooked: false,
        carPrice: _priceController.text,
        selectedColor: selectedIndexForcolor,
        selectedType: selectedIndexForType);

    return newCarModel;
  }

  String generateUID() {
    const uuid = Uuid();
    return uuid.v4();
  }
}
