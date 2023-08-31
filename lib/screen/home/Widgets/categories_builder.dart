import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:screw/constant/routes.dart';

import '../../../models/Categories_model/categories_Model.dart';

import '../../CategoriesVeiwPage/categories_veiw_screen.dart';
// list of Category builder Widget from categorylist 
Widget categorieslistbuilder(
    List<CategoriesModel> categorieslist, BuildContext context) {
  return ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(overscroll: false),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categorieslist
            .map(
              (singelcategory) => InkWell(
                onTap: () {
                  Routes.instance.push(
                      widget: CategoriseVeiwScreen(
                      
                          itemcategory: singelcategory,
                      ),
                      context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                  //card template
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                       color: HexColor("#242628"), 
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
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            // its image
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            scale: 1.2,
                            image: NetworkImage(singelcategory.image!))),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
