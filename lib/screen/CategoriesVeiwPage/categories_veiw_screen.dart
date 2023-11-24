import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:screw/models/Categories_model/categories_Model.dart';

import 'package:screw/models/Product_model/product_model.dart';

import 'package:screw/service/firebase_firestore_helper/firebase_firestore_helper.dart';

import '../../constant/assets_images.dart';

import '../../constant/routes.dart';

import '../../widgets/spacer.dart';

import '../producr_details/product_details.dart';

//Category Product veiw screen
class CategoriseVeiwScreen extends StatefulWidget {
  final CategoriesModel itemcategory;

  const CategoriseVeiwScreen({
    super.key,
    required this.itemcategory,
  });

  @override
  State<CategoriseVeiwScreen> createState() => _CategoriseVeiwScreenState();
}

class _CategoriseVeiwScreenState extends State<CategoriseVeiwScreen> {
  bool isloading = false;

  List<ProductModel> categoryproducts = [];

  @override
  void initState() {
    super.initState();
    getcategoriesproduct();
  }

  void getcategoriesproduct() async {
    setState(() {
      isloading = true;
    });
    // getting the product for the assigned category
    categoryproducts = await FirebaseFireStoreHelper.instance
        .getCategoryVeiw(widget.itemcategory.id);

    categoryproducts.shuffle();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double hsize = MediaQuery.of(context).size.height;
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                // app bar
                SliverAppBar(
                  backgroundColor: HexColor("#242628"),
                  leading: InkWell(
                      onTap: () => Routes.instance.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      )),
                  title: Text(
                    widget.itemcategory.name != null
                        ? widget.itemcategory.name!
                        : "null",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 253, 253, 253)),
                  ),
                  elevation: 10.0,
                  automaticallyImplyLeading: false,
                  //  pinned: false,
                  expandedHeight: 10,
                  floating: true,
                  snap: true,
                )
              ];
            },
            // if category is get sucessufully then show the product is grid veiw
            body: isloading == true
                // if is loding
                ? Center(
                    child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        child: const CircularProgressIndicator(
                          color: Color.fromARGB(255, 233, 205, 79),
                        )),
                  )
                //after loading
                //refresh widget to f=refresh the products
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        isloading = true;
                      });
                      categoryproducts = await FirebaseFireStoreHelper.instance
                          .getCategoryVeiw(widget.itemcategory.id);
                      categoryproducts.shuffle();
                      setState(() {
                        isloading = false;
                      });
                    },
                    child: Column(children: [
                      // here teh grid of product shows
                      /// Expaned is used sole the size error
                      Expanded(
                          child: gridcate(
                        itemname: widget.itemcategory.name!,
                        categoryproductlist: categoryproducts,
                        hsize: hsize,
                      ))
                    ]))));
  }
}

// gride cate product buider
Widget gridcate({
  required String itemname,
  required List<ProductModel> categoryproductlist,
  hsize,
}) {
  int categoryproductlistlength = categoryproductlist.length; // product coount

  return ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(overscroll: false),
    child: GridView.builder(
      scrollDirection: Axis.vertical,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.77,
      ),
      itemCount: categoryproductlistlength, // product coount
      itemBuilder: (context, index) {
        var hsize = MediaQuery.of(context).size.height;
        var wsize = MediaQuery.of(context).size.width;
        // template of card
        return categoriseVeiwcard(
          itemname: itemname,
          context: context,
          fheight: hsize,
          fwidth: wsize,
          index: index,
          productlist: categoryproductlist,
        );
      },
    ),
  );
}

//tempate builder
Widget categoriseVeiwcard(
    {required List<ProductModel> productlist,
    required index,
    required String itemname,
    required BuildContext context,
    required double fheight,
    required double fwidth}) {
  final singleproduct = productlist[index];
  return InkWell(
    onTap: () {
      // Naviagete to product deatialscreen to teh product
      Routes.instance.push(
          widget: Productdetails(
            product: singleproduct,
          ),
          context: context);
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor("#242628"),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: HexColor("#343537"),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(
                -3,
                -3,
              ),
            ),
            BoxShadow(
              color: HexColor("#161616"),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(
                3,
                3,
              ),
            ),
          ],
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: singleproduct.image != null
                  ? NetworkImage(singleproduct.image.toString())
                  : NetworkImage(Assetsimages.instance.networkfailed)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSpacers(),
            Container(
              width: double.infinity,
              height: fheight / 13,
              decoration: BoxDecoration(
                color: HexColor("#242628"),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // product deatial isnt null then show its name and othe details
                  singleproduct.name != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            singleproduct.name!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      //if null from fire base
                      : const Text("Loading.."),
                  singleproduct.price != null
                      // if price is not null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "₹${singleproduct.price!}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                          ),
                        )
                      //if null from fire base
                      : const Text("Loading.."),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
