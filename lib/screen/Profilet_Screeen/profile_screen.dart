

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';


import 'package:screw/screen/Profilet_Screeen/Edit_profile_screen/edit_profile_screen.dart';
import 'package:screw/screen/Profilet_Screeen/about_And_Support_Screen/aboutAndSupport_Screen.dart';
import 'package:screw/screen/Profilet_Screeen/about_And_Support_Screen/enumfunction.dart';
import 'package:screw/screen/Profilet_Screeen/widget.dart';

import 'package:screw/service/firebasse_auth_helper/firebase_auth_helper.dart';
import 'package:screw/widgets/spacer.dart';
import '../../constant/routes.dart';

import '../../provider/app_provider.dart';

import '../Cart_Screen/cart_screen.dart';

// user profile screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      // body start
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  // user info displaying widget (name , email,phone number)
                  margin: const EdgeInsets.all(
                    10,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: HexColor("#242628"),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#343537"),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(
                          -5,
                          -5,
                        ),
                      ),
                      BoxShadow(
                        color: HexColor("#161616"),
                        blurRadius: 12,
                        offset: const Offset(
                          13,
                          6.6,
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                        ),
                        //   profile image
                        child: InkWell(
                            onTap: () {
                              Routes.instance.push(
                                widget: const EditProfileScreen(),
                                context: context,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  appProvider.getuserInfromation.image != null
                                      ? NetworkImage(
                                          appProvider.getuserInfromation.image!)
                                      : null,
                              minRadius: 30,
                              maxRadius: 60,
                              child:
                                  appProvider.getuserInfromation.image == null
                                      ? Icon(
                                          Icons.person,
                                          size: 60,
                                        )
                                      : null,
                            )),
                      ),
                      // dispaly user name
                      userinfoDisplaytile(
                        title: appProvider.getuserInfromation.name,
                        colors: Color.fromARGB(214, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                      //display user email
                      userinfoDisplaytile(
                        title: appProvider.getuserInfromation.email,
                        colors: Color.fromARGB(214, 241, 241, 241),
                        fontWeight: FontWeight.w400,
                      ),
                      // disp;ay user phone number
                      
                    ],
                  ),
                ),
              ),
              // button list ( about , support, cart,etc)
              SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomSpacers(
                        height: 10,
                      ),
                      
                     
                      // buton to navigate to cart screen()
                      customlisttile(
                        ontap: () {
                          Routes.instance.push(
                            widget: const CartScreeen(),
                            context: context,
                          );
                        },
                        title: "Cart",
                        leading: const Icon(
                          Icons.category_outlined,
                          color: Colors.white60,
                        ),
                      ),
                      // button to navigate to profile edit  screen()
                      customlisttile(
                        ontap: () {
                          Routes.instance.push(
                            widget: const EditProfileScreen(),
                            context: context,
                          );
                        },
                        title: "Edit Profile",
                        leading: const Icon(
                          Icons.person_outline,
                          color: Colors.white60,
                        ),
                      ),
                      // button to navigate to about screen()
                      customlisttile(
                        ontap: () {
                          Routes.instance
                              .push(widget: AboutadsupportScreen(type: aboutScreenOrsupportScreen.aboutscreen), context: context);
                        },
                        title: 'About',
                        leading: const Icon(
                          Icons.info,
                          color: Colors.white60,
                        ),
                      ),
                      // buton to navigate to support screen()
                      customlisttile(
                        ontap: () {
                          Routes.instance
                              .push(widget: AboutadsupportScreen(type: aboutScreenOrsupportScreen.supportscreen), context: context);
                        },
                        title: 'Support',
                        leading: const Icon(
                          Icons.support,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  )
                  // ],
                  ),
              const CustomSpacers(
                height: 60,
              ),
              SizedBox(
                // logOut button
                width: 150,
                child: custombutton(
                  widget: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(
                      211,
                      255,
                      255,
                      255,
                    ),
                  ),
                  text: "LogOut",
                  colors: HexColor("#343537"),
                  ontap: () async {
                    // logout call
                    bool? success = await FirebaseAuthHelper.instance.logout();
                    if (success!) {
                      // if sucess the logout refrest teh screen using setState
                      setState(() {});
                    }
                  },
                  textcolor: Colors.white,
                ),
              ),
              const CustomSpacers(
                height: 35 ,
              ),
              const Text(
                "Version 1.0",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color.fromARGB(218, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const CustomSpacers( 
                height: 35 ,
              ),
            ],
          ),
        ),
      ),
    );
  } 

  Widget custombutton({
    required String text,
    widget = const SizedBox(),
    ontap,
    colors,
    textcolor,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
          border: Border.all(
            strokeAlign: 1,
            width: 1,
            color: Colors.black38,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            Text(
              text,
              style: TextStyle(
                color: textcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
