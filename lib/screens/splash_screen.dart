import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../funtions/check_session.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import 'option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      _showNoConnectionDialog();
    } else {
      // Proceed with the app initialization
      await _initApp();
    }
  }

  Future<void> _initApp() async {
    await checkEmployeeSession(context);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Ensure the widget is still in the widget tree
        Navigator.pushNamed(context, OptionScreen.ID);
      }
    });
  }

  void _showNoConnectionDialog() {
    if (!mounted)
      return; // Ensure the widget is still mounted before showing a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text(
            'Internet connection is not working properly. Please try again later.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkConnectivity(); // Retry the connectivity check
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRefer.kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Image.asset('assets/images/logo.png', height: 110, width: 110),
            SizedBox(height: 30),
            const Text('Office Orbit', style: TextStyle(fontSize: 28, fontFamily: FontRefer.DMSans, fontWeight: FontWeight.bold, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
