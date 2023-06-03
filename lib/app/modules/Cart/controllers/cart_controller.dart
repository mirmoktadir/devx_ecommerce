import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devx_ecommerce/app/data/local/my_shared_pref.dart';
import 'package:devx_ecommerce/app/service/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartController extends GetxController with BaseController {
  fetchData(String collectionName) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(collectionName)
          .doc(MySharedPref.getEmail())
          .collection("items")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something is wrong"),
          );
        }

        return ListView.separated(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (_, index) {
            DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];

            return SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    height: 100.h,
                    width: 100.w,
                    imageUrl: documentSnapshot['image'],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          documentSnapshot['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "\$ ${documentSnapshot['price']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(.4),
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(MySharedPref.getEmail())
                          .collection("items")
                          .doc(documentSnapshot.id)
                          .delete();
                    },
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        );
      },
    );
  }
}
