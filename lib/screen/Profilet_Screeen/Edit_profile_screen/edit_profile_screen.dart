import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/constant/routes.dart';
import 'package:screw/models/User_Model/user_model.dart';
import 'package:screw/provider/app_provider.dart';
import 'package:screw/widgets/primarybutton.dart';
import 'package:screw/widgets/spacer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController newphonecontroller = TextEditingController();
  TextEditingController newnamecontroller = TextEditingController();
  File? image;
  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Routes.instance.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: const Color.fromARGB(210, 255, 255, 255),
            )),
        backgroundColor: HexColor("#242628"),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () => pickImageFromGallery(),
            child: CircleAvatar(
              backgroundImage: appProvider.getuserInfromation.image != null
                  ? NetworkImage(appProvider.getuserInfromation.image!)
                  : null,
              backgroundColor: Colors.black,
              minRadius: 30,
              maxRadius: 60,
              child: const Icon(
                Icons.mode_edit_outlined,
                size: 40,
                color: Colors.white60,
              ),
            ),
          ),
          const CustomSpacers(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: textfieldeditor(
              //keyboardType: TextInputType.text,
              controller: newnamecontroller,
              decoration: InputDecoration(
                hintText: "Name :${appProvider.getuserInfromation.name}",
              ),
            ),
          ),
          CustomSpacers(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Primarybutton(
              widget: const Text("Save"),
              onpressed: () async {
                UserModel userModel = appProvider.getuserInfromation;
                appProvider.updateUserInfoFirebase(userModel, image, context);

                if (newnamecontroller.text == "") {
                } else {
                  UserModel userModel = appProvider.getuserInfromation.copyWith(
                      name: newnamecontroller.text,
                      phone: newphonecontroller.text);
                  appProvider.updateUserInfoFirebase(userModel, image, context);
                  ShowMessage("sucessfully Update the profile");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
