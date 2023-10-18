import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screw/widgets/spacer.dart';
import 'package:url_launcher/url_launcher.dart';

//gobal String variables
String whatsappnumberfromfirebase = "";
String instagrammessageidfromfirebase = "";
String Cartedproductdeatilstext = "";
String aboutapp = "";
String Supportapp = "";
// popup message shower
void ShowMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 37, 37, 37),
      textColor: Colors.white,
      fontSize: 16.0);
}

//login and singntime loading indicator
showloaderDailog(BuildContext context) {
  var hsize = MediaQuery.of(context).size.height;
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(
            color: Color.fromARGB(255, 93, 91, 91),
          ),
          CustomSpacers(
            height: hsize / 55,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...!"),
          )
        ]),
      );
    }),
  );
  showDialog(
      context: context,
      builder: (context) {
        return alert;
      });
}

// login vadidation checker
bool loginvalidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    ShowMessage("Email is empty");
    return false;
  } else if (email.isEmpty) {
    ShowMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    ShowMessage("Email is empty");
    return false;
  } else {
    return true;
  }
}
//Sign Up validation checker

bool signUpvalidation(
  String email,
  String password,
  String name,
) {
  if (email.isEmpty && password.isEmpty && name.isEmpty) {
    ShowMessage("Email,Password,Name and phone number is not found");
    return false;
  } else if (email.isEmpty) {
    ShowMessage("Email is  not found");
    return false;
  } else if (password.isEmpty) {
    ShowMessage("password is  not found");
    return false;
  } else if (name.isEmpty) {
    ShowMessage("Name is not found");
    return false;
  } else {
    return true;
  }
}

// launch Whatsapp using launche url //
void launchWhatsapp({required String number, required String message}) async {
  final Uri _url = Uri.parse('https://wa.me/91$number?text=$message');

  try {
    await launch(_url.toString());
  } on PlatformException catch (e) {
    ShowMessage(e.code.toString());
  }
}

// launch instagram web using launche url //
void launchInstagram({required String instagramid}) async {
  final Uri _url =
      Uri.parse('https://www.instagram.com/direct/t/${instagramid}');

  try {
    await launch(_url.toString());
  } on PlatformException catch (e) {
    ShowMessage(e.code.toString());
  }
}

//textfield//
Widget textfieldeditor(
    {required TextEditingController controller,
    required InputDecoration decoration,
    TextInputType? keyboardType}) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: decoration,
    ),
  );
}
// App SKU = sj.pasdedeux.com
