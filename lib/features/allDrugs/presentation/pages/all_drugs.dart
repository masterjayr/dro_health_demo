import 'package:dro_health/core/constants/colors.dart';
import 'package:dro_health/core/constants/dimensions.dart';
import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:dro_health/features/allDrugs/presentation/bloc/all_drugs_bloc.dart';
import 'package:dro_health/features/allDrugs/presentation/pages/single_drug.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class AllDrugs extends StatefulWidget {
  @override
  _AllDrugsState createState() => _AllDrugsState();
}

class _AllDrugsState extends State<AllDrugs> {
  TextEditingController _searchQuery = TextEditingController();
  String _searchText = '';
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getAllDrugs(context);
    });
  }

  List<Drug> searchDrugList = [];
  List<Drug> allDrugs = [];

  _AllDrugsState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }

  List<Drug> _buildSearchList() {
    if (_searchText.isEmpty) {
      return searchDrugList = allDrugs;
    } else {
      searchDrugList = allDrugs
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${searchDrugList.length}');
      return searchDrugList;
    }
  }

  void getAllDrugs(BuildContext context) {
    BlocProvider.of<AllDrugsBloc>(context).add(GetAllDrugsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: allDrugs.length == 0
            ? Text('Loading items(s)',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
            : Text('${allDrugs.length} items(s)',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconContainer(
                    icon: MaterialCommunityIcons.download, onPressed: () {}),
                SizedBox(width: 30),
                iconContainer(
                    icon: MaterialCommunityIcons.test_tube_empty,
                    onPressed: () {}),
                SizedBox(width: 30),
                iconContainer(icon: Icons.search, onPressed: () {})
              ],
            ),
            SizedBox(height: 30),
            searchBar(),
            SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<AllDrugsBloc, AllDrugsState>(
                  builder: (context, state) {
                if (state is Loading) {
                  return Center(child: Text("Loading ..."));
                } else if (state is Loaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      allDrugs = state.allDrugs;
                    });
                  });
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      searchDrugList.length != 0 || _searchQuery.text.isNotEmpty
                          ? Expanded(
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 40,
                                  shrinkWrap: true,
                                  childAspectRatio: 0.7,
                                  children: List.generate(searchDrugList.length,
                                      (index) {
                                    return drugContainer(searchDrugList[index]);
                                  })),
                            )
                          : Expanded(
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 40,
                                  shrinkWrap: true,
                                  childAspectRatio: 0.7,
                                  children:
                                      List.generate(allDrugs.length, (index) {
                                    return drugContainer(state.allDrugs[index]);
                                  })),
                            )
                    ],
                  );
                } else if (state is Empty) {
                  return Center(child: Text("Still Loading ..."));
                } else if (state is Error) {
                  return Center(child: Text("An error occurred"));
                } else {
                  return Container();
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
        height: MediaQuery.of(context).size.height / 15,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30.0)),
        child: Center(
          child: TextField(
            controller: _searchQuery,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 50,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.black),
              prefixIconConstraints: BoxConstraints(
                minWidth: 50,
                minHeight: 25,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel_outlined, color: Colors.black),
                onPressed: () {
                  _searchQuery.clear();
                },
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 50,
                minHeight: 25,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.only(top: 15, left: 30),
            ),
          ),
        ));
  }

  Widget iconContainer({IconData icon, Function onPressed}) {
    return Container(
      height: getScreenHeight(context) * 0.1,
      width: getScreenWidth(context) * 0.1,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(icon: Icon(icon), onPressed: onPressed),
    );
  }

  Widget drugContainer(Drug singleDrug) {
    return InkWell(
      onTap: () {
        Get.to(SingleDrug(singleDrug: singleDrug));
      },
      child: Container(
        height: getScreenHeight(context) * 0.4,
        width: getScreenWidth(context) * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(singleDrug.imageUrl,
                    height: getScreenHeight(context) / 8),
              ),
              SizedBox(
                height: 20,
              ),
              Text('${singleDrug.name}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '${singleDrug.category}\n${singleDrug.type} - ${singleDrug.amount}'),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Container()),
                  Chip(
                    label: Text('${singleDrug.price}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: greyColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
