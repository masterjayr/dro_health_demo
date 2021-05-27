import 'package:dro_health/features/allDrugs/presentation/bloc/all_drugs_bloc.dart';
import 'package:dro_health/features/allDrugs/presentation/pages/all_drugs.dart';
import 'package:dro_health/features/bag/presentation/bloc/add_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/bloc/delete_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/bloc/get_bag_bloc.dart';
import 'package:dro_health/features/bag/presentation/pages/bag.dart';
import 'package:dro_health/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AllDrugsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AddBagBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetBagBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DeleteBagBloc>(),
        )
      ],
      child: GetMaterialApp(
          title: 'DRO HEALTH APP',
          debugShowCheckedModeBanner: false,
          home: AllDrugs()),
    );
  }
}
