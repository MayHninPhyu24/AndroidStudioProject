import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool isEn = true;
  Map<String, Object> textsJp = {
  };
  Map<String, Object> textsEn = {
    "welcome" : "Welcome",
    "welcome_sub_title": "Welcome to the biggest online store",
    "login": "Login",
    "Sign Up": "Sign Up",
    "continue_with": "Or Continue With",
    "google_plus": "Google +",
    "sign_in_as_guest": "Sign in as guest",
    "full_name": "Full Name",
    "email_address": "Email Address",
    "phone_number": "Phone Number",
    "password": "Password",
    "forget_password": "Forget Password",
    "home":"Home",
    "upload_a_new_product": "Upload a new product",
    "product_title": "Product Title",
    "camera": "Camera",
    "gallery": "Gallery",
    "remove": "Remove",
    "category": "Category",
    "select_a_category": "Select a Category",
    "select_a_brand": "Select a Brand",
    "description": "Description",
    "upload": "Upload",
    "categories": "Categories",
    "popular_brand": "Popular Brands",
    "view_all": "View All",
    "popular_products": "Popular_products",
    "feeds": "Feeds",
    "quantity": "Quantity",
    "add_to_wishlist": "Add To Wishlist",
    "view_product": "View Product",
    "add_to_cart": "Add To Cart",
    "detail": "Detail",
    "left": "Left",
    "brand": "Brand",
    "category": "Category",
    "popularity": "Popularity",
    "no_review_yet": "No reviews yet",
    "be_the_first_review": "Be the first review!",
    "suggested_product": "Suggested Products",
    "wishlist_empty": "Your Wishlist Is Empty",
    "wishlist_empty_sub": "Explore more and shortlist some items",
    "add_a_wish": "Add A Wish",
    "cart_empty": "Your Cart is Empty",
    "cart_empty_sub": "Look Like You didn't add anything to your cart yet",
    "buy_now": "Buy Now",
    "cart": "Cart",
    "in_cart": "In Cart",
    "price": "Price",
    "sub_total": "Sub Total",
    "ships_free": "Ships Free",
    "checkout": "Checkout",
    "total": "Total",
    "remove_item": "Remove Item",
    "remove_item_sub": "Product will be removed from the cart.",
    "ok": "OK",
    "cancel": "Cancel",
    "clear_cart": "Clear Cart",
    "clear_cart_sub": "Your cart will be cleared",
    "user_bag": "User Bag",
    "wishlist": "Wishlist",
    "my_order": "My Order",
    "user_information": "User Information",
    "email": "Email",
    "shipping_address": "Shipping Address",
    "joined_date": "Joined Date",
    "user_settings": "User Settings",
    "dark_theme": "Dark Theme",
    "logout": "Logout",
    "sign_out": "Sign Out",
    "sign_out_sub": "Do you wanna Sign Out?",




    "user": "User",


  };

  changeLan(bool lan) async{
    isEn = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn", isEn);
  }

  getLan() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool("isEn")?? true;
    notifyListeners();
  }

  Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt]!;
    return textsJp[txt]!;
  }
}
