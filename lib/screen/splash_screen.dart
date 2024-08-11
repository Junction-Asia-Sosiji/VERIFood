import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BDBCE),
      body: Flex(
        direction: Axis.vertical,
        children: [
          const Spacer(flex: 3),
          Expanded(
            flex: 3,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/app_logo.png'),
                      ),
                    ),
                  ),
                  flex: 16,
                ),
                const Spacer(flex: 1),
                const Expanded(
                  child: Text(
                    'VERIFOOD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 10.20,
                    ),
                  ),
                  flex: 3,
                )
              ],
            ),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}


