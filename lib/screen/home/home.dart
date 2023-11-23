import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:screw/provider/app_provider.dart';
import 'package:screw/screen/home/Widgets/products_builder.dart';
import 'package:screw/service/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../constant/routes.dart';
import '../../models/Categories_model/categories_Model.dart';
import '../../models/Product_model/product_model.dart';

import 'Widgets/categories_builder.dart';
import 'Widgets/search_screen.dart';
import '../main_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //some used variables
  List<CategoriesModel> categorieslist = [];
  List<ProductModel> productlist = [];

  bool isloading = false;
  String appbartext = "welcome";

  @override
  void initState() {
    //calling and getting information aboaut the curent user
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInformationFirebase();

    //get producct nad category
    getproducts();
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        setState(()  {
          appbartext = "Pas des Deux";
        });
      },
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   getproducts();
  //   super.dispose();
  // }

// // product and category getting function
  Future<void> getproducts() async {
    setState(() {
      isloading = true;
    });

    categorieslist = await FirebaseFireStoreHelper.instance.getCategories();
    productlist = await FirebaseFireStoreHelper.instance.getproduct();
    await FirebaseFireStoreHelper.instance.getOwnerInformation();

    productlist.shuffle();
    categorieslist.shuffle();

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var hsize = MediaQuery.of(context).size.height;

    return NestedScrollView(
      headerSliverBuilder: (
        BuildContext context,
        bool innerBoxIsScrolled,
      ) {
        return [
          SliverAppBar(
            backgroundColor: HexColor("#242628"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: InkWell(
                  onTap: () {
                    Routes.instance.push(
                      widget: Searchscreen(
                        productlist: productlist,
                      ),
                      context: context,
                    );
                  },
                  child: const Icon(
                    Icons.search,
                    color: Color.fromARGB(224, 255, 255, 255),
                  ),
                ),
              )
            ],
            title: Text(
              appbartext,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            elevation: 10.0,
            automaticallyImplyLeading: false,
            expandedHeight: 10,
            floating: true,
            snap: true,
          )
        ];
      },
      // refresh widget to refrest the product and the category
      body: RefreshIndicator(
        color: const Color.fromARGB(
          255,
          233,
          205,
          79,
        ),
        displacement: 40,
        onRefresh: getproducts,
        child: isloading
            // if loading
            ? Center(
                child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: const CircularProgressIndicator(
                      color: Color.fromARGB(
                        255,
                        233,
                        205,
                        79,
                      ),
                    )),
              )
            //after loading

            : ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  overscroll: false,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 250,
                      ),
                      child: Padtext(
                        colors: Colors.white,
                        title: "Categories",
                      ),
                    ),
                    //category diplay widget
                    categorieslistbuilder(
                      categorieslist,
                      context,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 250,
                      ),
                      child: Padtext(
                        colors: Colors.white,
                        title: "Products",
                      ),
                    ),
                    //product show widget

                    gridpro(
                      productlist,
                      hsize,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
