import 'package:driver_app/cubit/app_cubit.dart';
import 'package:driver_app/models/notification/notification_model.dart';
import 'package:driver_app/models/shared_preferences/shared_preferences_model.dart';
import 'package:driver_app/service/base_service.dart';
import 'package:driver_app/service/service_path.dart';
import 'package:driver_app/utils/base_constant.dart';
import 'package:driver_app/utils/stars_method.dart';
import 'package:driver_app/widgets/map/gmap.dart';
import 'package:driver_app/widgets/notification/notification_badge.dart';
import 'package:driver_app/widgets/template_page/app_loading_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldState = GlobalKey<ScaffoldState>();
  LatLng? currentLocation;
  late int _totalNotifications;
  NotificationModel? _notificationInfor;

  void requestAndRegisterNotification() async {
    // For handling the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Parse the message received
      NotificationModel notification = NotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
        data: message.data,
      );
      print('Notification data: ${notification.data!['phone']}');

      setState(() {
        _notificationInfor = notification;
        _totalNotifications++;
      });
      if (_notificationInfor != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
          Text(_notificationInfor!.title!,
              style: BaseTextStyle.fontFamilyMedium(Colors.black, 20)),
          leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Text(
            _notificationInfor!.body!,
            style: BaseTextStyle.fontFamilyRegular(Colors.black, 18),
          ),
          background: BaseColor.hint,
          contentPadding: const EdgeInsets.all(6),
          duration: const Duration(seconds: 5),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    requestAndRegisterNotification();
    _totalNotifications = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, CubitState>(
      builder: (context, appState) {
        if (appState is AuthenticatedState) {
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
                          child: Image.asset(
                              'assets/images/dominic_toretto.png',
                              fit: BoxFit.cover)),
                      accountName: Text(
                        appState.user.name,
                        style: BaseTextStyle.fontFamilyBold(Colors.black, 18),
                      ),
                      accountEmail: Text(
                        "SĐT: ${appState.user.phone}",
                        style:
                            BaseTextStyle.fontFamilyRegular(Colors.black, 17),
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
                Gmap(
                    scaffoldState: scaffoldState,
                    callBack: (driverLocation) async {
                      Map<String, dynamic> params = {
                        "phone": appState.user.phone.toString(),
                        "latitude": driverLocation.latitude,
                        "longitude": driverLocation.longitude,
                      };
                      print('params: $params');
                      String? currentToken =
                          await SharedPref.read(SharedPrefPath.token);
                      var response = await BaseService.putData(
                          ServicePath.updateDriverLocation, params,
                          token: currentToken);
                      print("Response update location: $response");
                      if (response != null && response['status'] == 200) {
                        print("Update location success");
                      }
                      setState(() {
                        currentLocation = driverLocation;
                      });
                    }),
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
                                      appState.user.name,
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
        return const AppLoadingPage();
      },
    );
  }
}
