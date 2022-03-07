import 'package:flutter/material.dart';
import 'package:flutter_festival_romania_meetup_2022/screens/homeScreen.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initApp();
    print("3");
  }

  Future<void> initApp() async {
    await loadData();
    print("1");

    Navigator.of(context).pushReplacementNamed('/home');
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(seconds: 5));
    print("2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/gdg_cluj.png'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Welcome to\nGDG Cluj!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.red,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Made with ❤ in',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/flutter.svg',
                      width: 150,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
