import 'package:flutter/material.dart';
import 'package:screw/widgets/spacer.dart';

class TopsTitle extends StatelessWidget {
  final String title, subtitle;
  final void Function()? onTap;

  const TopsTitle(
      {super.key, required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == "Login" || title == "Create an Account"
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                child: InkWell(
                    onTap: onTap, child: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(251, 255, 255, 255),)),
              )
            : const CustomSpacers(height: 1),
        CustomSpacers(height: hsize / 90),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.6,color:Colors.white ),
        ),
        CustomSpacers(
          height: hsize / 55,
        ),
        Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18.6,color:Colors.white ),
        ),
      ],
    );
  }
}
