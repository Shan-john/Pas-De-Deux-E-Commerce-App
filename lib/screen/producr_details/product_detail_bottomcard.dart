import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:screw/models/Product_model/product_model.dart';
import 'package:screw/widgets/spacer.dart';
// Product detial ProductDetailBottomCard ( product info Widget) 
class ProductDetailBottomCard extends StatefulWidget {
  final ProductModel product;
  final double hsize;
  final double wsize;

 const  ProductDetailBottomCard(
      {super.key, required this.product, required this.hsize, required this.wsize});

  @override
  State<ProductDetailBottomCard> createState() =>
      _ProductDetailBottomCardState();
}


class _ProductDetailBottomCardState extends State<ProductDetailBottomCard> {
  @override
  Widget build(BuildContext context) {
    return
    //card template
     Container(
      decoration: BoxDecoration(
        borderRadius:const BorderRadius.all(Radius.circular(30)),
        color:HexColor("#242628"),
      boxShadow:[ BoxShadow(
              color:HexColor("#343537"), 
              spreadRadius: 1,
                      blurRadius: 1,
                      offset:const Offset(
                        -3,
                        -3,
                      ),
              ),
          BoxShadow(
              color: HexColor("#161616"),  spreadRadius: 1,
                      blurRadius: 1,
                      offset:const Offset(
                        3,
                        3,
                      ),),
        ],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 7, left: 7),
      height: widget.hsize / 5,
      //scrollabel text
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  //product.name is not null the name
                  widget.product.name != null
                      ? Container(
                          padding: const EdgeInsets.only(left: 18, bottom: 20),
                          width: widget.wsize / 1.2,
                          child: Text(
                            maxLines: 3,
                            widget.product.name!,
                            overflow: TextOverflow.ellipsis,
                            style:const  TextStyle(
                              color: Color.fromARGB(255, 255, 253, 253),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        //other wise
                      :const Text("loading"),
                
                ],
              ),
              const CustomSpacers(
                height: 6,
              ),
                   //product.price is not null the price
              widget.product.price != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        " ₹${widget.product.price}",
                        style:const TextStyle(
                          color:  Color.fromARGB(224, 255, 255, 255),
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                    //if null
                  :const SizedBox(),

       //product.description is not null the discription
              widget.product.description != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 17.0),
                        //  read more package to get that functionality of show more and show less
                      child: ReadMoreText(
                        colorClickableText: HexColor("A495C6"),
                        
                        trimLines: 3,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,

                        trimCollapsedText: " Show More",
                        trimExpandedText: " Show Less",
                        //showing discripton
                        "DESCRIPTION :- \n${widget.product.description!}",
                        style: const TextStyle(
                            color: Color.fromARGB(224, 255, 255, 255),
                            letterSpacing: 0,
                            wordSpacing: 1,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                    //if null
                  : const Text("Loading.."),
            ],
          ),
        ),
      ),
    );
  }
}
