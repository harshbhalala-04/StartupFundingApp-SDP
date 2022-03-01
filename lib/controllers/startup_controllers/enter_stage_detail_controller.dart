import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterStageDetailController extends GetxController {
  final startDay = 'DD'.obs;
  final startMonth = 'MM'.obs;
  final startYear = 'YYYY'.obs;

  final endDay = 'DD'.obs;
  final endMonth = 'MM'.obs;
  final endYear = 'YYYY'.obs;

  void showDatePickerDailog(BuildContext context, String type) {
    showDatePicker(
            context: context,
            initialDate: DateTime(DateTime.now().year),
            firstDate: DateTime(2022),
            lastDate: DateTime(DateTime.now().year + 21))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        if (type == "Start") {
          startDay.value = pickedDate.day.toString();
          startMonth.value = pickedDate.month.toString();
          startYear.value = pickedDate.year.toString();
        } else {
          endDay.value = pickedDate.day.toString();
          endMonth.value = pickedDate.month.toString();
          endYear.value = pickedDate.year.toString();
        }
      }
    });
  }
}
