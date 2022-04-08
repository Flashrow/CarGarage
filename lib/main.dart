import 'dart:async';

import 'package:car_garage/bloc_cg/car_list/car_list_bloc.dart';
import 'package:car_garage/network/secure_storage.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:car_garage/route/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import 'common/colors.dart';

void main() async {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await dotenv.load(fileName: "assets/environmental/.env");
      SecureStorage.writeApiKey(dotenv.env['API_KEY'] ?? "");
    } catch (e) {
      Logger().i("Dotenv not loaded");
      Logger().i(e);
    }
    runApp(MyApp(_navigatorKey));
  }, (error, stackTrace) {
    if (_navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text("Error occurred"),
      ));
    }
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? _navigatorKey;

  const MyApp(this._navigatorKey, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(widget._navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CarListBloc>(
            create: (context) => CarListBloc(CarListRepository()),
          ),
        ],
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          supportedLocales: const [
            Locale("pl"),
            Locale("en"),
          ],
          theme: ThemeData(
            primaryColor: cPrimaryColor,
            accentColor: cAccentColor,
          ),
          builder: (context, router) => router!,
        ),
      ),
    );
  }
}
