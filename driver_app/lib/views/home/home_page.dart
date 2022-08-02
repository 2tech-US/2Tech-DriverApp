import 'package:driver_app/cubit/app_cubit.dart';
import 'package:driver_app/utils/base_constant.dart';
import 'package:driver_app/widgets/map/gmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldState,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 175, 92),
                ),
                currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png')),
                accountName: Text(
                  "Driver",
                  style: BaseTextStyle.fontFamilyBold(Colors.black, 18),
                ),
                accountEmail: Text(
                  "passenger@gmail.com",
                  style: BaseTextStyle.fontFamilyRegular(Colors.black, 17),
                )),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Đăng xuất"),
              onTap: () {
                BlocProvider.of<AppCubit>(context).logout();
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Gmap(scaffoldState: scaffoldState),
        ],
      ),
    ));
  }
}
