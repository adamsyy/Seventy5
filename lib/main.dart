import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'Splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String username;
  late String password;
  late String token;
  int check = 0;

  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
  }


  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Seventy5',
        theme: const NeumorphicThemeData(
          variantColor: Color(0xFF303030),
          accentColor: Color(0xFF303030),
          baseColor: Color(0xFFE0E0E0),
          lightSource: LightSource.topLeft,
          depth: 8,
        ),
        darkTheme: const NeumorphicThemeData(
          variantColor: Color(0xFFE0E0E0),
          accentColor: Color(0xFFE0E0E0),
          baseColor: Color(0xFF303030),
          lightSource: LightSource.topLeft,
          depth: 8,
        ),
        home: SplashScreen()
    );
  }
}
