import 'package:get/get.dart';

class CounterControllerGetx extends GetxController {
  // Observables pada GetX diakhiri dengan .obs
  var counter = 0.obs;

  void increment() {
    counter++;
    // Pada GetX dengan pendekatan reactive (Obx), kita tidak perlu
    // memanggil fungsi semacam 'notifyListeners()'.
  }
}
