import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:screw/constant/routes.dart';

import 'package:screw/models/Product_model/product_model.dart';

import 'package:screw/screen/home/Widgets/products_builder.dart';
import 'package:screw/screen/main_screen.dart';

import 'package:screw/widgets/spacer.dart';

class Searchscreen extends StatefulWidget {
  final List<ProductModel> productlist;
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
            element.categorie!.toLowerCase().contains(value.toLowerCase()) ||
            element.name!.toLowerCase().contains(value.toLowerCase()) ||
            element.price!.toString().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  void searchItemsInRange(
      {required List<ProductModel> productlist,
      required int lowerLimit,
      required int upperLimit}) {
    searchList = productlist
        .where((item) => item.price! >= lowerLimit && item.price! <= upperLimit)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
        actions: [
        widget.productlist.isNotEmpty ?  InkWell(
            onTap: () {
             
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyDrawer();
                  });
              setState(() {});
            },
            child: Icon(
              Icons.menu,
              color: Color.fromARGB(221, 255, 255, 255),
              size: 30,
            ),
          ):SizedBox(),
          CustomSpacers(
            width: 30,
          )
        ],
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
            const CustomSpacers(
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

  Widget textpriceselector({ required String data,required int lower,required int upper}) {
    return InkWell(
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Text(data,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:  Color.fromARGB(153, 255, 255, 255)),),
      ),
      onTap: () {
        searchItemsInRange(
            productlist: widget.productlist,
            lowerLimit: lower,
            upperLimit: upper);
        Routes.instance.pop(context);
        setState(() {});
      },
    );
  }

  Widget MyDrawer() {
    return  AlertDialog(
      backgroundColor:  HexColor("#242628"),
      title: Center(child: Text(
        
        "Select Range",style: TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold,color: Color.fromARGB(153, 255, 255, 255)),),),
      content: Container(
      height: 180,
      width: 30 ,
     // color:  HexColor("#242628"),
      child: Column(
        children: [
          textpriceselector(
      data:   "below 100",
      lower: 0,
      upper: 100
      ),
          textpriceselector(
      data:   "100<=500",
      lower: 100,
      upper: 500
      ),
       textpriceselector(
      data:   "500<=100",
      lower: 500,
      upper: 1000
      ), 
      textpriceselector(
      data:   "Above 1000",
      lower: 1000,
      upper: 100000000,
      ),
        ],
      ),
    )
      
    
  );
  }
}
