import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/common_widget.dart';
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

  static OverlayEntry? activeToast;

  static void _toast(String msg, Color bg, {bool exit = true}) {
    BuildContext? context = Get.overlayContext;
    context ??= Get.context;
    if (context == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _toast(msg, bg, exit: exit);
      });
      return;
    }
    OverlayState? overlay;
    try {
      overlay = Overlay.of(context, rootOverlay: true);
    } catch (e) {
      try {
        final navigator = Navigator.of(context, rootNavigator: true);
        overlay = navigator.overlay;
      } catch (e2) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _toast(msg, bg, exit: exit);
        });
        debugPrint('Toast: Could not find Overlay, retrying - $e2');
        return;
      }
    }
    if (overlay == null) {
      debugPrint('Toast: Overlay is null');
      return;
    }
    activeToast?.remove();
    activeToast = null;
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (_) => ToastWidget(
        message: msg,
        backgroundColor: bg,
        onDismiss: () {
          if (overlayEntry.mounted) overlayEntry.remove();
          if (activeToast == overlayEntry) {
            activeToast = null;
          }
        },
      ),
    );
    activeToast = overlayEntry;
    overlay.insert(overlayEntry);
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




