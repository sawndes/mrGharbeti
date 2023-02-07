import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/chat.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    // if (index == 1) {
    //   print(index);
    //   ChatPage();
    // }
  }
}
