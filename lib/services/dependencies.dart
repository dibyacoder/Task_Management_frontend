import 'package:frontend_todo/services/api.dart';
import 'package:get/get.dart';


Future<void> init() async {
  //controllers
  Get.lazyPut(() => Api());
  
}