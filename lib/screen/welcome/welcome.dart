import 'package:flutter/material.dart';
import 'package:screw/constant/assets_images.dart';
import 'package:screw/constant/routes.dart';
import 'package:screw/screen/auth_ui/Sign_Up/signup.dart';
import 'package:screw/screen/auth_ui/login/login.dart';
import 'package:screw/widgets/Toptilebar.dart.dart';
import 'package:screw/widgets/primarybutton.dart';
import 'package:screw/widgets/spacer.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
  
    var hsize = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopsTitle(
                title: 'Welcome',
                subtitle: 'Search here what you wanted',
              ),
              CustomSpacers(
                height: hsize / 50,
              ),
              Center(
                child: Image.asset(
                  Assetsimages.instance.welcomeImages,
                ),
              ),
              const CustomSpacers(
                height: 10,
              ),
             
              CustomSpacers(
                height: hsize / 90,
              ),
              Primarybutton(
                widget: const Text(
                  "login",
                ),
                onpressed: () {
                  Routes.instance.push(context: context, widget: const Login());
                },
              ),
              CustomSpacers(
                height: hsize / 500,
              ),
              Primarybutton(
                widget: const Text(
                  "Sign Up",
                ),
                onpressed: () {
                  Routes.instance.push(
                    widget: const SignUp(),
                    context: context,
                  );
                },
              ),
              CustomSpacers(
                height: hsize / 55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
