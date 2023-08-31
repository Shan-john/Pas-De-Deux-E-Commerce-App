import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/constant/routes.dart';
import 'package:screw/screen/main_screen.dart';
import 'package:screw/screen/Profilet_Screeen/about_And_Support_Screen/enumfunction.dart';

class AboutadsupportScreen extends StatelessWidget {
  final Enum type;
  const AboutadsupportScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#242628"),
        leading: InkWell(
            onTap: () => Routes.instance.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(221, 255, 255, 255),
            )),
        title: aboutScreenOrsupportScreen.aboutscreen == type
            ? const Text(
                "About Screen",
                style: TextStyle(
                  color: Color.fromARGB(221, 255, 255, 255),
                ),
              )
            : const Text(
                "Support Screen",
                style: TextStyle(
                  color: Color.fromARGB(221, 255, 255, 255),
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: aboutScreenOrsupportScreen.aboutscreen == type
              ? customtext(title: aboutapp)
              : customtext(title: Supportapp),
        ),
      ),
    );
  }
}
