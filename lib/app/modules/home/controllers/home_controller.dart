import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devx_ecommerce/app/data/local/my_shared_pref.dart';
import 'package:get/get.dart';

import '../../../components/custom_snackbar.dart';
import '../../../service/base_controller.dart';

class HomeController extends GetxController with BaseController {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  int current = 0;

  ///API
  final _firestoreInstance = FirebaseFirestore.instance;
  final products = RxList<dynamic>();

  fetchProducts() async {
    showLoading();
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();

    for (int i = 0; i < qn.docs.length; i++) {
      products.add({
        "title": qn.docs[i]["title"],
        "description": qn.docs[i]["description"],
        "price": qn.docs[i]["price"],
        "image": qn.docs[i]["image"],
      });
    }
    hideLoading();
    return qn.docs;
  }

  Future addToCart(String title, int price, String image) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return collectionRef
        .doc(MySharedPref.getEmail())
        .collection("items")
        .doc()
        .set({
      "title": title,
      "price": price,
      "image": image,
    }).then((value) => CustomSnackBar.showCustomSnackBar(
            title: "Success", message: "Product Added to Cart"));
  }

  Future addToFavourite(String title, int price, String image) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return collectionRef
        .doc(MySharedPref.getEmail())
        .collection("items")
        .doc()
        .set({
      "title": title,
      "price": price,
      "image": image,
    }).then((value) => CustomSnackBar.showCustomSnackBar(
            title: "Success", message: "Product Added to Favourite"));
  }

  @override
  void onReady() async {
    await fetchProducts();
    super.onReady();
  }
}
