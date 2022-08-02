import 'package:driver_app/cubit/app_cubit.dart';
import 'package:driver_app/cubit/app_cubit_logic.dart';
import 'package:driver_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setOrientations();
  runApp(const MyApp());
}

void setOrientations() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, CubitState>(
        listener: (context, state) {
          if (state is TimedOutState) {
            BlocProvider.of<AppCubit>(context).kick();
          }
        },
        builder: (context, state) {
          return MaterialApp(
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            theme: baseTheme(),
            home: const AppCubitLogic(),
          );
        },
      ),
    );
  }
}
