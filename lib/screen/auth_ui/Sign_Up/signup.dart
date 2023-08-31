import 'package:flutter/material.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/constant/theme.dart';
import 'package:screw/screen/auth_ui/login/login.dart';
import 'package:screw/screen/main_screen.dart';
import 'package:screw/service/firebasse_auth_helper/firebase_auth_helper.dart';
import 'package:screw/widgets/Toptilebar.dart.dart';
import 'package:screw/widgets/primarybutton.dart';
import 'package:screw/widgets/spacer.dart';

import '../../../constant/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool obscuretext = true;

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            primary: false,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSpacers(height: hsize / 90),
                  //top bar
                  TopsTitle(
                    subtitle: "Welcome",
                    title: "Create an Account",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CustomSpacers(height: hsize / 55),
                  // Name text field 
                  textfieldeditor(
                   
                      
                    controller: namecontroller,
                    decoration: const InputDecoration(
                        hintText: "Name",
                        //  hintStyle: TextStyle(color: Colors.white60),
                        prefixIcon: Icon(
                          Icons.person,
                        )),
                  ),
                  CustomSpacers(height: hsize / 55),
                  // Email text field 
                  textfieldeditor(
                      
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        hintText: "E-mail",

                        prefixIcon: Icon(
                          Icons.email_outlined,
                        )),
                  ),
                  
                
                 
                  CustomSpacers(height: hsize / 55),
                  // password entering field 
                  TextFormField(
                      style:  TextStyle( color: Colors.white ),
                    obscureText: obscuretext,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscuretext = !obscuretext;
                              });
                            },
                            child: const Icon(Icons.remove_red_eye)),
                        hintText: "Password",
                       //  hintStyle: TextStyle(color: Colors.white60),
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                        )),
                  ),
                  CustomSpacers(height: hsize / 55),
                   // buttom for Sign Up
                  Primarybutton(
                    widget: const Text("Create"),
                    onpressed: () async {
                         // checking the password and email are not null if it true return true
                      bool isvalidated = signUpvalidation(
                          emailcontroller.text,
                          passwordcontroller.text,
                          namecontroller.text);
                            //then 
                      if (isvalidated) {
                        bool? isSignuped = await FirebaseAuthHelper.instance
                            .signUp(emailcontroller.text, 
                                passwordcontroller.text, context, namecontroller.text );
                                   //if login in sucess full completed
                        if (isSignuped!) {
                             // route to main screen 
                          Routes.instance.pushandRemoveUntil(
                              widget: const Mainscreen(), context: context);
                        }
                      }
                    },
                  ),
                  CustomSpacers(height: hsize / 35),
                  const Center(child: Text(" I Already Have A Account",style: TextStyle(color: Color.fromARGB(251, 255, 255, 255))),),
                  CustomSpacers(height: hsize / 55),
                  Center(
                      child: InkWell(
                         // if  have an account then navigate to Login screen on press
                          onTap: () {
                            Routes.instance.pushreplace(
                                widget: const Login(), context: context);
                          },
                          child: Text(
                            "Go to Sign-In",
                            style: TextStyle(color: themeData.primaryColor),
                          )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
