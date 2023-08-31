import 'package:flutter/material.dart';

class CustomSpacers extends StatelessWidget {
  final double height;
 final  double width ;
   const CustomSpacers( {super.key, this.height=1,this.width=1,});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      width: width,
    );
  }
}
