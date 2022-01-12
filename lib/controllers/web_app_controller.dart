import 'package:get/get.dart';

class WebAppController extends GetxController {
  final isSelected = false.obs;

  toggoleSelection() {
    isSelected.toggle();
  }
}
