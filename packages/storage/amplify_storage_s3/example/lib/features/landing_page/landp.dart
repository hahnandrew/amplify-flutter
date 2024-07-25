
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_storage_s3_example/common/utils/colors.dart' as constants;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToTrips();
  }

  _navigateToTrips() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 2 seconds
    if (mounted) {
      context.go('/trips');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(constants.primaryColorDark),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.travel_explore,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the Amplify Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Watch your favorite movies here',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
