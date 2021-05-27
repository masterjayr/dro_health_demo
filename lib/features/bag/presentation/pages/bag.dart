import 'dart:async';

import 'package:dro_health/core/constants/colors.dart';
import 'package:dro_health/core/constants/dimensions.dart';
import 'package:dro_health/features/bag/presentation/bloc/delete_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/bloc/get_bag_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class Bag extends StatefulWidget {
  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  // StreamController<int> controller = StreamController<int>();
  int totalValue = 0;
  void getAllDrugs(BuildContext context) {
    BlocProvider.of<GetBagBloc>(context).add(GetInBagEvent());
  }

  void deleteDrug(BuildContext context, int id) {
    Get.log("Id to delete is $id");
    BlocProvider.of<DeleteBagBloc>(context).add(DeleteFromBagEvent(id: id));
  }

  @override
  void initState() {
    super.initState();
    getAllDrugs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: droPurple,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MaterialCommunityIcons.bag_personal_outline,
                color: Colors.white),
            SizedBox(width: 5),
            Text('Bag',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: droPurple,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(child: infoContainer()),
            SizedBox(height: 30),
            BlocListener<GetBagBloc, GetBagState>(listener: (context, state) {
              if (state is GetLoaded) {
                for (int i = 0; i < state.drugs.length; i++) {
                  int value = int.parse(state.drugs[i].price.substring(1));
                  Get.log("A Value $value");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      totalValue += value;
                    });
                  });
                }
              }
            }, child: BlocBuilder<GetBagBloc, GetBagState>(
              builder: (context, state) {
                if (state is GetLoading) {
                  return Center(
                      child: Text("Loading ...",
                          style: TextStyle(color: Colors.white)));
                } else if (state is GetLoaded) {
                  return Expanded(
                      flex: 10,
                      child: ListView.separated(
                        itemCount: state.drugs.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 30);
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  state.drugs[index].isSelected =
                                      !state.drugs[index].isSelected;
                                });
                              },
                              child: Column(
                                children: [
                                  itemContainer(
                                      imageUrl: state.drugs[index].imageUrl,
                                      name: state.drugs[index].name,
                                      type: state.drugs[index].type,
                                      price: state.drugs[index].price,
                                      isSelected: state.drugs[index].isSelected,
                                      quantity: state.drugs[index].quantity),
                                  state.drugs[index].isSelected
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                              BlocListener<DeleteBagBloc,
                                                      DeleteBagState>(
                                                  listener: (context, dstate) {
                                                if (dstate is DeleteLoaded) {
                                                  getAllDrugs(context);
                                                } else if (dstate is Error) {
                                                  print("An error occurred!");
                                                }
                                              }, child: BlocBuilder<
                                                      DeleteBagBloc,
                                                      DeleteBagState>(
                                                builder: (context, dstate) {
                                                  if (dstate is DeleteEmpty) {
                                                    return IconButton(
                                                      icon: Icon(
                                                          MaterialCommunityIcons
                                                              .trash_can_outline,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        deleteDrug(
                                                            context,
                                                            state.drugs[index]
                                                                .id);
                                                      },
                                                    );
                                                  } else if (dstate
                                                      is DeleteLoading) {
                                                    return IconButton(
                                                      icon: Icon(
                                                          MaterialCommunityIcons
                                                              .delete,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        deleteDrug(
                                                            context,
                                                            state.drugs[index]
                                                                .id);
                                                      },
                                                    );
                                                  } else if (dstate
                                                      is DeleteError) {
                                                    return IconButton(
                                                      icon: Icon(
                                                          MaterialCommunityIcons
                                                              .trash_can_outline,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        deleteDrug(
                                                            context,
                                                            state.drugs[index]
                                                                .id);
                                                      },
                                                    );
                                                  } else {
                                                    return IconButton(
                                                      icon: Icon(
                                                          MaterialCommunityIcons
                                                              .trash_can_outline,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        deleteDrug(
                                                            context,
                                                            state.drugs[index]
                                                                .id);
                                                      },
                                                    );
                                                  }
                                                },
                                              )),
                                              Row(
                                                children: [
                                                  InkWell(
                                                      onTap: state.drugs[index]
                                                                  .quantity ==
                                                              1
                                                          ? () {}
                                                          : () {
                                                              setState(() {
                                                                state
                                                                    .drugs[
                                                                        index]
                                                                    .quantity -= 1;

                                                                totalValue -= int
                                                                    .parse(state
                                                                        .drugs[
                                                                            index]
                                                                        .price
                                                                        .substring(
                                                                            1));
                                                              });
                                                            },
                                                      child: calculateContainer(
                                                          MaterialCommunityIcons
                                                              .minus)),
                                                  Text(
                                                      '${state.drugs[index].quantity}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          state.drugs[index]
                                                              .quantity += 1;
                                                          totalValue +=
                                                              int.parse(state
                                                                  .drugs[index]
                                                                  .price
                                                                  .substring(
                                                                      1));
                                                        });
                                                      },
                                                      child: calculateContainer(
                                                          MaterialCommunityIcons
                                                              .plus)),
                                                ],
                                              )
                                            ])
                                      : Offstage()
                                ],
                              ));
                        },
                      ));
                } else if (state is GetEmpty) {
                  return Center(child: Text("Still Loading ..."));
                } else if (state is GetError) {
                  return Center(child: Text("An error occurred"));
                } else {
                  return Container();
                }
              },
            )),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Text('₦${totalValue.toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                width: 200,
                height: getScreenHeight(context) * 0.05,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)))),
                    child: Text('Checkout',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget avatarContainer(String imageUrl) {
    return ClipOval(
        child: Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      width: 70.0,
      height: 70.0,
    ));
  }

  Widget calculateContainer(IconData icon) {
    return Container(
      height: 40,
      width: getScreenWidth(context) * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black),
    );
  }

  Widget itemContainer(
      {String imageUrl,
      String name,
      String type,
      String price,
      int quantity,
      bool isSelected}) {
    int calculatedPrice = int.parse(price.trim().substring(1)) * quantity;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isSelected ? Offstage() : avatarContainer(imageUrl),
                SizedBox(width: 10),
                Text('${quantity}X',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Text(type,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ],
                )
              ],
            ),
            Text('₦${calculatedPrice.toString()}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
      ],
    );
  }

  Widget infoContainer() {
    return Container(
      height: getScreenHeight(context) * 0.04,
      width: getScreenWidth(context) * 0.75,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Tap on an item for add, remove, delete, options',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10)),
        ),
      ),
    );
  }
}
