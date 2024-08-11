import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:veri_food/screen/main_screen.dart';
import 'package:veri_food/screen/map_screen.dart';
import 'package:veri_food/screen/review_screen.dart';
import 'package:veri_food/screen/splash_screen.dart';
import 'package:veri_food/screen/store_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  String? naverMapClientId = dotenv.env['NAVER_MAP_CLIENT_ID'];
  await NaverMapSdk.instance.initialize(
    clientId: naverMapClientId,
    onAuthFailed: (ex) {
      print("NaverMapSdk auth failed: $ex");
    },
  );

  String? supabaseKey = dotenv.env['SUPABASE_KEY'] ?? "";
  String? anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? "";
  await Supabase.initialize(
    url: "https://$supabaseKey.supabase.co",
    anonKey: anonKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VERIFood',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const SplashScreen(),
        "/main": (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/map") {
          return MaterialPageRoute(
            builder: (context) {
              return MapScreen(
                store: settings.arguments as dynamic,
              );
            },
          );
        }

        if (settings.name == "/store") {
          return MaterialPageRoute(
            builder: (context) {
              return StoreScreen(
                store: settings.arguments as dynamic,
              );
            },
          );
        }

        if (settings.name == "/review") {
          return MaterialPageRoute(
            builder: (context) {
              return ReviewScreen(
                store: settings.arguments as dynamic,
              );
            },
          );
        }
      },
    );
  }
}
