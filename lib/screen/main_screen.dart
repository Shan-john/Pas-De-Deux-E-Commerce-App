import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:screw/screen/Cart_Screen/cart_screen.dart';
import 'package:screw/screen/Profilet_Screeen/profile_screen.dart';

import 'package:screw/screen/home/home.dart';

import '../provider/app_provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    super.key,
  });

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool isloading = false;

  int currentindex = 0;
  List<Widget> screen = [
    const Home(),
    const CartScreeen(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      isloading = true;
      // setState(() {});
    });
    super.initState();
  }

// @override
// void dispose() {
//     // TODO: implement dispose
    
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
        bottomNavigationBar: isloading == true
            ? CurvedNavigationBar(
                animationCurve: Curves.easeInOutSine,
                height: 50,
                color: HexColor("#222224"),
                backgroundColor: HexColor("#242628"),

                // buttonBackgroundColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    currentindex = index;
                  });
                },
                items: const [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.category_outlined,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.person_outline_sharp,
                    color: Colors.white,
                  ),
                ],
              )
            : null,
        body: screen[currentindex]);
  }
}

Widget Padtext({required String title, required Color colors, String subtitle = ""}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          
          title,
          style:  TextStyle(
          
            color: colors,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(subtitle,style: TextStyle(color: Color.fromARGB(171, 121, 120, 120),fontSize: 18 ),),
    ],
  );
}

Widget customtext({required String title}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
