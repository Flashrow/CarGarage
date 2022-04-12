import 'dart:async';

import 'package:car_garage/bloc_cg/car_list/car_list_bloc.dart';
import 'package:car_garage/bloc_cg/persons_list/persons_list_bloc.dart';
import 'package:car_garage/network/secure_storage.dart';
import 'package:car_garage/repository/car_list_repository.dart';
import 'package:car_garage/repository/person_list_repository.dart';
import 'package:car_garage/route/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:logger/logger.dart';

import 'common/colors.dart';

void main() async {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await FlutterConfig.loadEnvVariables();
      SecureStorage.writeApiKey(FlutterConfig.get('API_KEY') ?? "");
    } catch (e) {
      Logger().i("Dotenv not loaded");
      Logger().i(e);
    }
    await EasyLocalization.ensureInitialized();
    runApp(EasyLocalization(
        supportedLocales: const [
          Locale("pl"),
          Locale("en"),
        ],
        path: "assets/translations",
        fallbackLocale: const Locale('pl'),
        child: MyApp(_navigatorKey)));
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
  final CarListBloc _carListBloc = CarListBloc(CarListRepository());

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(widget._navigatorKey);
    _carListBloc.add(FetchCarList());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CarListBloc>(
            create: (context) => _carListBloc,
          ),
          BlocProvider<PersonsListBloc>(
            create: (context) => PersonsListBloc(
              PersonListRepository(),
            ),
          ),
        ],
        child: MaterialApp.router(
          key: UniqueKey(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
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
