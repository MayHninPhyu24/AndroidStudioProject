import 'package:ecommerence/screens/upload_brand_form.dart';
import 'package:ecommerence/screens/upload_category_form.dart';
import 'package:ecommerence/screens/upload_product_form.dart';
import 'package:ecommerence/screens/landing.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm(),
        UploadCategoryForm(), UploadBrandForm()],
    );
  }
}
