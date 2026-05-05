import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocProviders.dart';
import 'package:localdriver/injection.dart';
import 'package:localdriver/src/domain/utils/FirebasePushNotifications.dart';
import 'package:localdriver/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:localdriver/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localdriver/src/presentation/pages/client/driverOffers/ClientDriverOffersPage.dart';
import 'package:localdriver/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:localdriver/src/presentation/pages/client/mapBookingInfo/ClientMapBookingInfoPage.dart';
import 'package:localdriver/src/presentation/pages/client/mapTrip/ClientMapTripPage.dart';
import 'package:localdriver/src/presentation/pages/client/mp/aprobado.dart';
import 'package:localdriver/src/presentation/pages/client/mp/itempage.dart';
import 'package:localdriver/src/presentation/pages/client/mp/pago_page.dart';
import 'package:localdriver/src/presentation/pages/client/mp/pendiente.dart';
import 'package:localdriver/src/presentation/pages/client/mp/rechazado.dart';
import 'package:localdriver/src/presentation/pages/client/ratingTrip/ClientRatingTripPage.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:localdriver/src/presentation/pages/driver/home/DriverHomePage.dart';
import 'package:localdriver/src/presentation/pages/driver/mapTrip/DriverMapTripPage.dart';
import 'package:localdriver/src/presentation/pages/driver/ratingTrip/DriverRatingTripPage.dart';
import 'package:localdriver/src/presentation/pages/home-tutorial/ClientHomeTutPage.dart';
import 'package:localdriver/src/presentation/pages/profile/update/ProfileUpdatePage.dart';
import 'package:localdriver/src/presentation/pages/roles/RolesPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isIOS
  ? await Firebase.initializeApp() 
  : await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        title: 'Tropero Viajes',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'client/home/tut',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'roles': (BuildContext context) => RolesPage(),
          'client/home': (BuildContext context) => ClientHomePage(),
          'client/home/tut': (BuildContext context) => ClientHomeTutPage(),
          'driver/home': (BuildContext context) => DriverHomePage(),
          'client/map/booking': (BuildContext context) => ClientMapBookingInfoPage(),
          'profile/update': (BuildContext context) => ProfileUpdatePage(),
          'client/map/trip': (BuildContext context) => ClientMapTripPage(),
          'driver/map/trip': (BuildContext context) => DriverMapTripPage(),
          'driver/rating/trip': (BuildContext context) => DriverRatingTripPage(),
          'driver/client/request': (BuildContext context) => DriverClientRequestsPage(),
          'client/rating/trip': (BuildContext context) => ClientRatingTripPage(),
          'client/mp/aprobado': (BuildContext context) => AprobadoPage(),
          'client/mp/rechazado': (BuildContext context) => RechazadoPage(),
          'client/mp/pendiente': (BuildContext context) => PendientePage(),
          'client/mp/item': (BuildContext context) => ItemPage(),
          'client/mp/pago': (BuildContext context) => PagoPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == 'client/driver/offers') {
            final idClientRequest = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => ClientDriverOffersPage(
                idClientRequest: idClientRequest,
              ),
            );
          }
          return null;
        },
      ),    
    );
  }
}