import 'package:get/get.dart';
closeLoadingDialog(){
  if (Get.isDialogOpen!) {
            Get.back();
          }
}