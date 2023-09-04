// Card(
//                                   shadowColor:
//                                       carsList[index].isBooked ? grey : null,
//                                   color: backgroundColor,
//                                   child: Stack(children: [
//                                     SizedBox(
//                                       width: containerImageWidth,
//                                       height: containerImageHeight,
//                                       child: Stack(children: [
//                                         CachedNetworkImage(
//                                           imageUrl: carsList[index].carImage,
//                                           width: containerImageWidth,
//                                           height: containerImageHeight,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) =>
//                                               Shimmer.fromColors(
//                                             baseColor: const Color.fromARGB(
//                                                 255, 177, 177, 177),
//                                             highlightColor: Colors.grey[100]!,
//                                             child: Container(
//                                               width: containerImageWidth,
//                                               height: containerImageHeight,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.error),
//                                         ),
//                                         Align(
//                                           alignment: Alignment.bottomCenter,
//                                           child: Container(
//                                             width: containerImageWidth,
//                                             height: fogContainerHeight,
//                                             alignment: Alignment.bottomCenter,
//                                             decoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                                 colors: <Color>[
//                                                   const Color.fromARGB(
//                                                           255, 71, 71, 71)
//                                                       .withAlpha(210),
//                                                   const Color.fromARGB(
//                                                           31, 79, 79, 79)
//                                                       .withAlpha(210),
//                                                   const Color.fromARGB(
//                                                           179, 88, 88, 88)
//                                                       .withAlpha(210),
//                                                 ],
//                                               ),
//                                             ),
//                                             child: Stack(
//                                               children: [
//                                                 Positioned(
//                                                   right: containerImageWidth *
//                                                       0.85,
//                                                   top:
//                                                       fogContainerHeight * 0.03,
//                                                   bottom: 50,
//                                                   child: SizedBox(
//                                                     width: 40,
//                                                     height: 40,
//                                                     child: Image.asset(
//                                                         "assets/images/${carsList[index].carType}.png"),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                     right: containerImageWidth *
//                                                         0.55,
//                                                     top: fogContainerHeight *
//                                                         0.07,
//                                                     child: Align(
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                               carsList[index]
//                                                                   .carName,
//                                                               style:
//                                                                   nameOfCarFont),
//                                                           Text(
//                                                               carsList[index]
//                                                                   .carModel,
//                                                               style:
//                                                                   modelOfCarFont),
//                                                         ],
//                                                       ),
//                                                     )),
//                                                 Positioned(
//                                                   right: containerImageWidth *
//                                                       0.05,
//                                                   top:
//                                                       fogContainerHeight * 0.03,
//                                                   child: Text(
//                                                       '${carsList[index].carPrice} \$',
//                                                       style: priceOfCarFont),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 0.4, right: 0.5),
//                                           child: Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Container(
//                                               decoration: const BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topLeft:
//                                                         Radius.circular(20),
//                                                   ),
//                                                   color: white),
//                                               width: 85,
//                                               height: 30,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 0),
//                                                 child: Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 5),
//                                                       child: Text("Details",
//                                                           style:
//                                                               detailButtonFont),
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left:
//                                                               cardWidth * 0.02),
//                                                       child: const Icon(
//                                                         Icons.arrow_forward_ios,
//                                                         color: appBarColor,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ]),
//                                     )
//                                   ]),
//                                 ),