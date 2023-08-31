import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:screw/constant/routes.dart';

import 'package:screw/screen/producr_details/product_details.dart';

import 'package:screw/widgets/spacer.dart';

import '../../../constant/assets_images.dart';

import '../../../models/Product_model/product_model.dart';
// product show widget build for the home screen
Widget gridpro(

  List<ProductModel> productlist,double  hsize,) {
  int productlistlength = productlist.length;//product list count 
 
  return
 
    GridView.builder(
       scrollDirection: Axis.vertical,
     primary: false,
     shrinkWrap: true,
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.77,
      ),
      itemCount: productlistlength, //count
      itemBuilder: (context, index) {
        var hsize = MediaQuery.of(context).size.height;
        var wsize = MediaQuery.of(context).size.width;
        // calling card template
        return bestproductcard(
        
          context: context,
          fheight: hsize,
          fwidth: wsize,
          index: index,
          productlist: productlist,
        );
      },
  
  );
}
//template for singel producgt card
Widget bestproductcard(
    {required List<ProductModel> productlist,
    required index,
  
    required BuildContext context,
    required double fheight,
    required double fwidth
    }) {
  final singleproduct = productlist[index];

  return InkWell(
    onTap: () =>
    // on press navigate to its product detial screen
     Routes.instance.push(
     
        widget: Productdetails( 
       
      
          product: singleproduct,
         ),
       context: context),
    child: Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10.0),
      child: Container(
      
        decoration: BoxDecoration(
         color: HexColor("#242628"),
          borderRadius: BorderRadius.circular(15),
          boxShadow:[ BoxShadow(
              color:HexColor("#343537"), 
              spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(
                        -3,
                        -3,
                      ),
              ),
          BoxShadow(
              color: HexColor("#161616"),  spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(
                        3,
                        3,
                      ),),
        ],
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: singleproduct.image != null
                  ? NetworkImage(singleproduct.image!.toString())
                  // if image in null fom firebase
                  : NetworkImage(Assetsimages.instance.networkfailed)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSpacers(),
            Container(
             width: double.infinity,
              height: fheight/16  ,
           
              decoration: BoxDecoration(
                color: HexColor("#242628"),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                //if product name is not  null
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
                        //if null
                      : const Text("Loading.."),
                      // ifproduct price isnot null
                  singleproduct.price != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "₹${singleproduct.price!}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(224, 255, 255, 255),),
                          ),
                        )
                        //if null
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
