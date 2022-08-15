import 'package:driver_app/cubit/app_cubit.dart';
import 'package:driver_app/utils/base_constant.dart';
import 'package:driver_app/utils/stars_method.dart';
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
                  color: Color.fromARGB(255, 194, 194, 196),
                ),
                currentAccountPicture: CircleAvatar(
                    child: Image.asset('assets/images/dominic_toretto.png',
                        fit: BoxFit.cover)),
                accountName: Text(
                  "Dom Toretto",
                  style: BaseTextStyle.fontFamilyBold(Colors.black, 18),
                ),
                accountEmail: Text(
                  "domtoretto@gmail.com",
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
          Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 17)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            child: Image.asset(
                                'assets/images/dominic_toretto.png',
                                fit: BoxFit.cover)),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dom Toretto',
                                style: BaseTextStyle.fontFamilyBold(
                                    Colors.black, 16),
                              ),
                              stars(rating: 3, votes: 1)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}
