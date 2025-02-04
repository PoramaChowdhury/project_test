import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isError = false]) {
  Get.snackbar(
    isError ? 'Error' : 'Success',
    message,
    duration: const Duration(seconds: 10),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : Colors.blueGrey,
    colorText: Colors.white,
  );
}