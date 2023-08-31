

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import 'package:screw/constant/constants.dart';


import 'package:screw/provider/app_provider.dart';

import 'package:screw/screen/Cart_Screen/singel_cart_widget.dart';
import 'package:screw/screen/main_screen.dart';
import 'package:screw/screen/producr_details/product_details.dart';

import 'package:screw/widgets/spacer.dart';

import '../../constant/routes.dart';

class CartScreeen extends StatefulWidget {
  const CartScreeen({
    super.key,
  });

  @override
  State<CartScreeen> createState() => _CartScreeenState();
}

class _CartScreeenState extends State<CartScreeen> {
  bool isloading = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.category_outlined,
            color: Colors.white,
          ),
          backgroundColor: HexColor("#242628"),
          title: Text(
            "Cart Screen ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 37.0),
          child: custombutton(
              ontap: () {
                // carted item to text to  sent instagram and whats app
                Cartedproductdeatilstext = appProvider.getCartproductList
                    .map((map) =>
                        "Name : ${map.name} \n Product-id :  ${map.id} \nImage : ${map.image} \n Description : ${map.description} \n Price : ₹ ${map.price} ")
                    .join("\n\n");
                // };

                appProvider.getCartproductList.isNotEmpty
                    ? displaybottomsheet(
                        context,
                      )
                    : ShowMessage("Cart is empty");
              },
              wsize: 240,
              hsize: 70,
              text: "BUY",
              wdivby: 1,
              hdivby: 1,
              colors:
                  appProvider.getCartproductList.isNotEmpty ? Colors.red : null,
              textcolor: Colors.white),
        ),
        // appProvider.getCartproductList.isNotEmpty from the list is  not empty then show the card
        //other wise show text that say card is empty
        body: appProvider.getCartproductList.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => CustomSpacers(
                  height: 15,
                ),
                itemCount: appProvider.getCartproductList.length,
                //  cartproduct.length,

                //item count of the List
                itemBuilder: (context, index) {
                  final item = appProvider.getCartproductList[
                      index]; //chossing single item from the list and assigning to item
                  //  final item = cartproduct[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10),
                      color: Color.fromARGB(251, 223, 81, 71),
                      child: Text(
                        maxLines: 1,
                        "Remove",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      color: Color.fromARGB(255, 116, 116, 116),
                      child: Text(
                        maxLines: 1,
                        "View Product",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      //if the swiping direction is from left to right
                      if (direction == DismissDirection.startToEnd) {
                        ShowMessage("Removed");
                        appProvider.removeCartProvider(item);

                        setState(() {});
                        // item is removed from the list
                      } else {
                        //if the swiping direction is from right to left
                        // Navigate to that product deatiall Screen
                        Routes.instance.push(
                            widget: Productdetails(
                                product: appProvider.getCartproductList[index]),
                            context: context);
                        setState(() {});
                      }
                    },
                    child: SingelCart(
                      //singel cart builder to display by single product
                      singleProduct: appProvider.getCartproductList[
                          index], //it take teh index value of the individual item
                    ),
                  );
                },
              )

            // if Cart is empty show  "Add Product to Cart"on screen

            : Center(
                child: Text(
                  "Add Product to Cart",
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ));
  }
}

//buy bottomscreen pop up///////
Future displaybottomsheet(
  BuildContext context,
) async {
  return showModalBottomSheet(
      backgroundColor: HexColor("#242628"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
      context: context,
      builder: (context) {
        return Container(
           height: 350 ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                  child: Padtext(
                      title: "Make Request",
                      colors: Color.fromARGB(248, 167, 32, 22))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Padtext(
                        title: "Via", colors: Color.fromARGB(255, 95, 95, 95)),
                  ),
                  
                   Text(
                      "Copy items here, if using \ninstagram to sent request ",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 95, 95, 95)),
                    ),
             
                  InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: Cartedproductdeatilstext));
                 
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Icon(
                          Icons.copy,
                          size: 30,
                          color: const Color.fromARGB(255, 219, 219, 219),
                        ),
                      ))
                ],
              ),
             //what app lunche buttom
              requestSentMethodIconButton(
                  onTap: () {
                    ShowMessage("Starting Whatsapp");
                    launchWhatsapp(
                        number: whatsappnumberfromfirebase,
                        message: Cartedproductdeatilstext);
                  },
                  title: "Whatsapp",
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 35,
                    color: const Color.fromARGB(255, 20, 150, 24),
                  ),
                  ),
              //instagram launch button
              requestSentMethodIconButton(
                  onTap: () {
                    launchInstagram(
                        instagramid: instagrammessageidfromfirebase);
                    ShowMessage("Starting instagram");
                  },
                  title: "Web Instagram ",
                  subtitle: "open with browser",
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    color: Color.fromARGB(206, 153, 0, 255),
                    size: 35,
                  )),
              
            ],
          ),
        );
      });
}

// request method function
Widget requestSentMethodIconButton(
    {required VoidCallback onTap,
    required Widget icon,
    String subtitle = "",
    required String title}) {
  return InkWell(
    onTap: onTap,
    child: Row(
     
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40.0, top: 5), // Removed the 'const'
          child: icon,
        ),
        Padtext(
          subtitle: subtitle,
          title: title, colors: Color.fromARGB(248, 170, 170, 170))
      ],
    ),
  );
}
