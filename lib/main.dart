import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:revenge_platform/blocs/bloc_observer.dart';
import 'package:revenge_platform/blocs/chat_bloc/chat_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/blocs/profile_bloc/profile_bloc.dart';
import 'package:revenge_platform/blocs/task_bloc/task_bloc.dart';
import 'package:revenge_platform/blocs/video_bloc/video_bloc.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/styles/themes.dart';
import 'package:revenge_platform/controller/internet_connectivity.dart';
import 'package:revenge_platform/exceptions/api_exception.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';
import 'package:revenge_platform/routes/routes.dart';
import 'package:revenge_platform/screens/auth/login/login_screen.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';
import 'package:revenge_platform/screens/onboard_screen/onboard_screen.dart';
import 'package:revenge_platform/screens/random_screens/select_intersts_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  // NotificationAPI.init();
  tz.initializeTimeZones();
  // listenNotification();
  await InternetConnectivity.networkStatusService();
  
  bool? isDark = CacheHelper.getData(key: CacheHelperKeys.themeOfAppModeKey);
  var onBoarding = CacheHelper.getData(key: CacheHelperKeys.onBoardingKey)??'';
  userId = CacheHelper.getData(key: CacheHelperKeys.userIdKey)??'';

  Widget widget = AppLayout();

  if(userId != '') {
    widget = AppLayout();
    print("object");
  } else {
    widget = LoginScreen();
  }
  // widget = onBoarding != null ? AppLayout() : OnBoardingScreen();
  
  runApp(ProviderScope(child: MyApp(
      startWidget: widget,
      isDark: isDark
  )));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const myTask = "TestTask";

class MyApp extends StatelessWidget {
  
  late final PageRouter _router;

  MyApp({Key? key, this.isDark, this.startWidget}) : _router = PageRouter(), super(key: key) {
    initLogger();
  }
  final Widget? startWidget;
  final bool? isDark;

  // MyApp({
  //   this.startWidget,
  //   this.isDark
  // });
            
            
  @override
  Widget build(BuildContext context) {

        return MultiBlocProvider(
            providers: [
              BlocProvider<AppBloc>(
                create: (BuildContext context) => AppBloc()..changeAppMode(
                  fromShared: isDark,
                )..getUserData(),
              ),
              BlocProvider<ProfileBloc>(
                create: (BuildContext context) => ProfileBloc(),
              ),
              BlocProvider<TaskBloc>(
                create: (BuildContext context) => TaskBloc(),
              ),
              BlocProvider<VideoBloc>(
                create: (BuildContext context) => VideoBloc(),
              ),
              BlocProvider<ChatBloc>(
                create: (BuildContext context) => ChatBloc()..getUsers(),
              ),
          
            ],
            child: BlocConsumer<AppBloc, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: MaterialApp(
                    // title: "Tasks",
                    debugShowCheckedModeBanner: false,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    // themeMode: AppBloc
                    //     .get(context)
                    //     .isDark ? ThemeMode.dark : ThemeMode.light,
                    themeMode: ThemeMode.light,
                    onGenerateRoute: _router.getRoute,
                    navigatorObservers: [_router.routeObserver],
                    navigatorKey: navigatorKey,
                  ),
                );
              },
            ),
          
          );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
