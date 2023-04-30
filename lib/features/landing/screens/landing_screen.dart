import 'package:flutter/material.dart';
import 'package:chatbro/common/utils/coloors.dart';
import 'package:chatbro/common/widgets/custom_button.dart';
import 'package:chatbro/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Coloors.greenLight),
            ),
            SizedBox(height: size.height / 15),
            Image.asset(
              'assets/bg.png',
              height: 250,
              width: 250,
              color: Coloors.greenLight,
            ),
            SizedBox(height: size.height / 15),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: greyColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
