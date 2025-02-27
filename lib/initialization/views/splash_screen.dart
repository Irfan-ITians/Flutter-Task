import 'package:check/utilities/color.dart' show AppColor;
import 'package:check/utilities/size_utilities.dart';
import 'package:flutter/material.dart';
import '../../utilities/images.dart';
import '../../utilities/string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Images.splash,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              60.height,
               Text(
             strings.title,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: AppColor.bottomBackColor, 
                  
                ),
              ),
              SizedBox(height: 350), 
               Text(
                strings.splash_body,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.whiteColor, 
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(strings.splash_desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
