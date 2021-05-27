import 'package:dro_health/core/constants/colors.dart';
import 'package:dro_health/core/constants/dimensions.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/bag/presentation/bloc/add_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/pages/bag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SingleDrug extends StatefulWidget {
  final Drug singleDrug;

  const SingleDrug({Key key, this.singleDrug}) : super(key: key);
  @override
  _SingleDrugState createState() => _SingleDrugState();
}

class _SingleDrugState extends State<SingleDrug> {
  int initialValue = 1;

  void addToBag(BuildContext context) {
    Get.log("INITIAL VALUE ===> $initialValue");
    BlocProvider.of<AddBagBloc>(context).add(AddToBagEvent(
        drug: Drug(
            id: widget.singleDrug.id,
            price: widget.singleDrug.price,
            name: widget.singleDrug.name,
            amount: widget.singleDrug.amount,
            category: widget.singleDrug.category,
            type: widget.singleDrug.type,
            imageUrl: widget.singleDrug.imageUrl,
            manufacturer: widget.singleDrug.manufacturer,
            quantity: initialValue)));
  }

  @override
  Widget build(BuildContext context) {
    Get.log("THE SINGLE DRUG ID ${widget.singleDrug.id}");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
              onPressed: () {
                Get.back();
              },
              color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(widget.singleDrug.imageUrl)),
                SizedBox(height: 10),
                Text(widget.singleDrug.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                Text('Soft Gel - ${widget.singleDrug.amount}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Row(
                  children: [
                    Container(
                      height: getScreenHeight(context) * 0.1,
                      width: getScreenWidth(context) * 0.1,
                      decoration: BoxDecoration(
                        color: greyColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('SOLD BY',
                            style: TextStyle(color: Colors.grey[400])),
                        Text(widget.singleDrug.manufacturer,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: getScreenHeight(context) * 0.05,
                          width: getScreenWidth(context) * 0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: greyColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(MaterialCommunityIcons.minus),
                                onPressed: initialValue == 1
                                    ? () {}
                                    : () {
                                        setState(() {
                                          initialValue -= 1;
                                        });
                                      },
                              ),
                              Text('${initialValue.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    initialValue += 1;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Pack(s)',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 20,
                            )),
                      ],
                    ),
                    Expanded(child: Container()),
                    Text('${widget.singleDrug.price}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('PRODUCT DETAILS',
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    drugDetail(
                        info1: 'PARK SIZE',
                        info2: '3x10',
                        icon: MaterialCommunityIcons.format_size),
                    SizedBox(width: 50),
                    drugDetail(
                        info1: 'PRODUCT ID',
                        info2: 'PRODCBHIATY',
                        icon: MaterialCommunityIcons.qrcode),
                  ],
                ),
                SizedBox(height: 15),
                drugDetail(
                    info1: 'CONSTITUENTS',
                    info2: widget.singleDrug.name,
                    icon: MaterialCommunityIcons.hospital_box),
                SizedBox(height: 15),
                drugDetail(
                    info1: 'DISPENSED IN',
                    info2: 'Packs',
                    icon: MaterialCommunityIcons.hospital_box),
                SizedBox(height: 30),
                Center(
                  child: Text(
                      '1 park of ${widget.singleDrug.name} contains 3 units of 10 Tablet(s)',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      )),
                ),
                // Expanded(child: Container()),
                SizedBox(height: 40),
                BlocListener<AddBagBloc, AddBagState>(
                    listener: (context, state) {
                  if (state is AddLoaded) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            dialogContainer(context));
                  } else if (state is Error) {
                    print("An error occurred!");
                  }
                }, child: BlocBuilder<AddBagBloc, AddBagState>(
                  builder: (context, state) {
                    if (state is AddEmpty) {
                      return addToBagBtn(
                          label: "Add To Bag",
                          onPressed: () => addToBag(context));
                    } else if (state is AddLoading) {
                      return addToBagBtn(
                        label: "Adding To Bag....",
                        onPressed: () => addToBag(context),
                      );
                    } else if (state is AddError) {
                      return addToBagBtn(
                          label: "Add To Bag",
                          onPressed: () => addToBag(context));
                    } else {
                      return addToBagBtn(
                          label: "Add To Bag",
                          onPressed: () => addToBag(context));
                    }
                  },
                ))
              ],
            ),
          ),
        ));
  }

  Widget addToBagBtn({String label, Function onPressed}) {
    return Center(
      child: Container(
        width: 200,
        height: getScreenHeight(context) * 0.05,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(droPurple),
              backgroundColor: MaterialStateProperty.all<Color>(droPurple),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: droPurple)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MaterialCommunityIcons.bag_personal_outline,
                  color: Colors.white),
              SizedBox(width: 10),
              Text(label, style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogContainer(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: dialogContent(context),
    );
  }

  Widget customBtn(String text, Function onPressed) {
    return Center(
      child: Container(
        width: getScreenWidth(context) * 0.5,
        // height: getScreenHeight(context) * 0.5,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(turquoise),
              backgroundColor: MaterialStateProperty.all<Color>(turquoise),
            ),
            child: Text(text, style: TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: getScreenHeight(context) * 0.25,
          width: getScreenWidth(context) * 0.7,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 10),
              Text("Garlic Oil has been added to your bag",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              customBtn('View Bag', () {
                Navigator.of(context).pop();
                Get.to(() => Bag());
              }),
              SizedBox(height: 5),
              customBtn('Done', () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
            ],
          ),
        ),
        Positioned(
          child: Column(
            children: [
              lappingCheck(),
              Text("Successful",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20))
            ],
          ),
          right: 0,
          left: 0,
          top: -26,
        ),
      ],
    );
  }

  Widget lappingCheck() {
    return CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            radius: 25.0,
            backgroundColor: turquoise,
            child: Icon(MaterialCommunityIcons.check,
                size: 40, color: Colors.white)));
  }

  Widget drugDetail({String info1, String info2, IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: darkPurple),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$info1',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            Text('$info2',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
}
