import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:screw/constant/routes.dart';

import 'package:screw/models/Product_model/product_model.dart';

import 'package:screw/screen/home/Widgets/products_builder.dart';
import 'package:screw/screen/main_screen.dart';

import 'package:screw/widgets/spacer.dart';

class Searchscreen extends StatefulWidget {
 final  List<ProductModel> productlist;
 const Searchscreen({
    super.key,
    required this.productlist,
  });

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController search = TextEditingController();

  List<ProductModel> searchList = [];

  void searchProducs(String value) {
    searchList = widget.productlist
        .where((element) =>
            element.categorie!.toLowerCase().contains(value.toLowerCase())
            ||
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

 

  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
          backgroundColor: HexColor("#242628"),
          leading: InkWell(
              onTap: () => Routes.instance.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(221, 255, 255, 255),
              )),
          title: const Text(
            "Search",
            style: TextStyle(
              color: Color.fromARGB(221, 255, 255, 255),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            TextFormField(
              controller: search,
              onChanged: (String value) {
                searchProducs(value);
              
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          const  CustomSpacers(
              height: 10,
            ),
            search.text.isNotEmpty && searchList.isEmpty
                ? Center(child: customtext(title: "product not found"))
                : searchList.isNotEmpty
                    ? gridpro(searchList, hsize)
                    : Center(
                        child: customtext(title: "Search"),
                      )
          ],
        ),
      ),
    );
  }
}
