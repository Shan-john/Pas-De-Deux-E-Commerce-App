import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/models/Product_model/product_model.dart';


// single Cart card builder
class SingelCart extends StatefulWidget {
  final ProductModel singleProduct;

  const SingelCart({super.key, required this.singleProduct, });

  @override
  State<SingelCart> createState() => _SingelCartState();
}

class _SingelCartState extends State<SingelCart> {
  @override
  @override
  Widget build(BuildContext context) {
    return
        // that single card
        InkWell(
      onTap: () => ShowMessage("Swipe It"),
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: HexColor("#242628"),
          boxShadow: [
            BoxShadow(
              color: HexColor("#343537"),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(
                -3,
                -3,
              ),
            ),
            BoxShadow(
              color: HexColor("#161616"),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(
                3,
                3,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              // to show the item image
              width: 100,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.singleProduct.image!,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
            //to Show the product name and oteh detials and function
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      maxLines: 1,
                      widget.singleProduct.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // show increment or decrement the
                ],
              ),
            ),
            // toshow the price detail
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                // appProvider.totalprice().toString(),
                " ₹${widget.singleProduct.price}",
                style: const TextStyle(
                  color: Color.fromARGB(224, 255, 255, 255),
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
