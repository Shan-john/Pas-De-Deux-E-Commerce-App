import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:screw/constant/theme.dart';
import 'package:screw/provider/app_provider.dart';
import 'package:screw/screen/Responxive_layout_Error.dart';
import 'package:screw/screen/responsive_Layout.dart';

import 'package:screw/screen/welcome/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB_05BIX2I-tEEMQoKAbMJN64D84RFPMf4",
          appId: "1:489111586757:android:452de786080201efb52dac",
          messagingSenderId: "",
          projectId: "screw-78f73"));

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            title: "Pas de dex",
            home: Responsive_Layout(MobielBody: SplashScreen(), DesktopBody: Responsive_Layout_Error_Screen())));
  }
}
