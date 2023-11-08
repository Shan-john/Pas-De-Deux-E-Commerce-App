import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:screw/constant/constants.dart';

import 'package:screw/constant/routes.dart';

import 'package:screw/models/Product_model/product_model.dart';
import 'package:screw/provider/app_provider.dart';
import 'package:screw/screen/Cart_Screen/cart_screen.dart';

import 'package:screw/screen/producr_details/product_detail_bottomcard.dart';

import 'package:screw/widgets/spacer.dart';

// PRoduct deatil screen
class Productdetails extends StatefulWidget {
  final ProductModel product;

  const Productdetails({
    super.key,
    required this.product,
  });

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  List<ProductModel> productimages = [];
  bool value = false;
  @override
  Widget build(BuildContext context) {
    double hsize = MediaQuery.of(context).size.height;
    double wsize = MediaQuery.of(context).size.width;
    ProductModel productModel;
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
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
            "Details",
            style: TextStyle(
              color: Color.fromARGB(221, 255, 255, 255),
            ),
          ),
        ),
        //whole body
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // to show the product image
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Container(
                    height: hsize / 2.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.product.image!)),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // if product name is not null then show
                      widget.product.name != null
                          ? SizedBox(
                              width: wsize / 1.37,
                              child: Text(
                                maxLines: 1,
                                widget.product.name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          // if null
                          : const Text("loading"),
                      //favorite button
                    ],
                  ),
                ),
                CustomSpacers(
                  height: hsize / 20,
                ),
                //calling  ProductDetailBottomCard
                ProductDetailBottomCard(
                  hsize: hsize,
                  wsize: wsize,
                  product: widget.product,
                ),
                //
                // widget for increment or decrement number of product

                //
                CustomSpacers(
                  height: hsize / 10,
                ),
                // but anf add to cart button
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //add to cart button
                      custombutton(
                          colors: HexColor("#343537"),
                          textcolor: Colors.white,
                          ontap: () async {
                            //copy the product with its count

                            productModel = widget.product.copyWith(qty: 1);
                            // adding to the list of app provider of cart

                            appProvider.addCartProvider(productModel);

                            ShowMessage("Added to cart");
                          },
                          wdivby: 2.4,
                          text: "Add To Cart",
                          wsize: wsize,
                          hsize: hsize,
                          hdivby: 15),
                      // button for buy product
                      custombutton(
                        ontap: () async {
                          //copy the product with its count

                          ShowMessage("Added to cart");

                          // adding to the list of app provider of cart
                          productModel = widget.product.copyWith(qty: 1);
                          if (appProvider.getCartproductList.contains(productModel)) {
                            Routes.instance
                                .push(widget: const CartScreeen(), context: context);
                          } else {

                            appProvider.addCartProvider(productModel);
                              Routes.instance
                                .push(widget: const CartScreeen(), context: context);
                          }

                          
                        },

                        wdivby: 2.4,
                        text: "Buy",
                        wsize: wsize,
                        // colors:  Color.fromARGB(255, 170, 22, 12) ,

                        colors: Colors.red,
                        hdivby: 15,
                        hsize: hsize,
                        textcolor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // custombutton builder widget
}

Widget custombutton({
  required double wsize,
  required double hsize,
  required String text,
  required double wdivby,
  required double hdivby,
  ontap,
  colors,
  textcolor,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
          color: colors,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(strokeAlign: 1, width: 1, color: Colors.black38)),
      alignment: Alignment.center,
      width: wsize / wdivby,
      height: hsize / hdivby,
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
    ),
  );
}
