import 'package:flutter/material.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/constant/routes.dart';
import 'package:screw/constant/theme.dart';
import 'package:screw/screen/auth_ui/Sign_Up/signup.dart';
import 'package:screw/screen/main_screen.dart';
import 'package:screw/service/firebasse_auth_helper/firebase_auth_helper.dart';
import 'package:screw/widgets/Toptilebar.dart.dart';
import 'package:screw/widgets/primarybutton.dart';
import 'package:screw/widgets/spacer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool obscuretext = true;

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSpacers(height: hsize / 90),
                //top bar 
                TopsTitle(
                  subtitle: "Welcome Back ",
                  title: "Login",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomSpacers(height: hsize / 76),
                // Email Text field
                textfieldeditor(
                  
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      hintText: "Email",
                    
                      prefixIcon: Icon(
                        Icons.email,
                      )),
                ),
                CustomSpacers(height: hsize / 76),
                //Password Text field
                TextFormField(
                    style:  TextStyle( color: Colors.white ),
                  obscureText: obscuretext,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    // ink well to switch the visiblity to true and false
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscuretext = !obscuretext;
                            });
                          },
                          child: const Icon(Icons.remove_red_eye)),
                      hintText: "Password", 
                     
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                      )),
                ),
                CustomSpacers(height: hsize / 70),
                // buttom for login
                Primarybutton(
                  onpressed: () async {
                    // checking the password and email are not null if it true return true
                    bool isvalidated = loginvalidation(
                        emailcontroller.text, passwordcontroller.text);
                        //then 
                    if (isvalidated == true) {
                      bool? islogined = await FirebaseAuthHelper.instance.login(
                          emailcontroller.text, passwordcontroller.text, context);
                          //if login in sucess full completed
                      if (islogined! == true) {
                        // route to main screen 
                        Routes.instance
                            .pushandRemoveUntil(widget: const Mainscreen(), context: context);
                      }
                    }
                  },
                  widget: const Text("Login"),
                ),
                CustomSpacers(height: hsize / 35),
                const Center(child: Text("Don't Have A Account ",style: TextStyle(color: Color.fromARGB(251, 255, 255, 255)),)),
                CustomSpacers(height: hsize / 70),
                Center(
                    child: InkWell(
                      // if dont have an account then navigate to sign Up screen on press
                        onTap: () {
                          Routes.instance
                              .pushreplace(widget: const SignUp(), context: context);
                        },
                        child: Text(
                          "Create an Account ?",
                          style: TextStyle(color: themeData.primaryColor),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
