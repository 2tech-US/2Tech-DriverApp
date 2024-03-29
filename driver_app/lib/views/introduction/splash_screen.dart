import 'dart:async';
import 'package:driver_app/cubit/app_cubit.dart';
import 'package:driver_app/views/authenticate/login_page.dart';
import 'package:driver_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 1),
        () => BlocProvider.of<AppCubit>(context).unAuthenticate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/app_logo.png",
              width: 200,
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              child: const SpinKitPianoWave(
                color: Colors.black,
                size: 30,
              ),
            )
          ]),
    );
  }
}
