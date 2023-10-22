import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Responsive_Layout_Error_Screen extends StatelessWidget {
  const Responsive_Layout_Error_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
       
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width
        ,
        child: Center(child: Text(
              "Turn off \"Desktop veiw\"and switch to \"normal view\"",
              style:    GoogleFonts.openSans(color: Colors.white, fontSize: 25),
            ),),
      ),
    );
  }
}