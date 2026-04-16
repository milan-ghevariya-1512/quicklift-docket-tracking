import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_colors.dart';
import 'package:intl/intl.dart';

class Utils {
  var box = GetStorage();

  void setBox(String key, dynamic val) {
    box.write(key, val);
  }

  void removeBox(String key) {
    box.remove(key);
  }

  void setLogin(bool val) {
    box.write('isLoggedIn', val);
  }

  bool isLogin() {
    try {
      return box.read('isLoggedIn');
    } catch (e) {
      return false;
    }
  }

  String? getToken() {
    try {
      return "${box.read("token")}";
    } catch (e) {
      return null;
    }
  }

  static void toastOk(String msg) {
    _toast(msg, Colors.green);
  }

  static void toastError(String msg, {bool exit = true}) {
    _toast(msg, Colors.red, exit: exit);
  }

  static void toastWarning(String msg) {
    _toast(msg, const Color(0xFF303030));
  }

  static void _toast(String msg, Color bg,
      {bool exit = true}) {
    Get.showSnackbar(GetSnackBar(
      message: msg,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: Get.width * 0.03),
      backgroundColor: bg,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
    ));
  }

  static showLoadingDialog() {
    return Get.dialog(
      const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
      barrierDismissible: true,
    );
  }

  static Widget loader({Color? loaderColor}) {
    return Center(child: CircularProgressIndicator(
        color: loaderColor ?? AppColors.primaryColor));
  }

  static String dateFormat = "d MMM y hh:mm a";

  static String setDate(String date) {
    var formattedDate = DateFormat(dateFormat).format(DateTime.parse(date));
    return formattedDate;
  }

  static Uint8List convertBase64Image(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

}




