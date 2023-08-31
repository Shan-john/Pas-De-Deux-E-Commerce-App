import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// cuttom ltile button
Widget customlisttile(
    {required Function() ontap,
    required String title,
    required Widget leading}) {
  return Container(
   
    margin:const EdgeInsets.all(10),
    decoration: BoxDecoration(
       color: HexColor("#242628"),  
      borderRadius:const BorderRadius.all(Radius.circular(20)),
     
        boxShadow: [
          BoxShadow(
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
    child: ListTile(
        onTap: ontap,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(218, 255, 255, 255),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: leading),
  );
}
 // userinfo template widget
Widget userinfoDisplaytile({
  required String title,
  required Color colors,
  required FontWeight fontWeight,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: colors,
        fontSize: 21,
        fontWeight: fontWeight,
      ),
    ),
  );
}
