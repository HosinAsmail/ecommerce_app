import 'package:test/core/functions/firebase_functions.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';
import 'package:test/data/model/user%20model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../firebase_options.dart';

class InitServices {
  Future<void> init() async {
    // await StoreAllData().deleteDb();
    await StoreAllData().initializeDb();
    await StoreStepService().initSharedPreference();
    // StoreStepService().setStep('1');
    if (StoreStepService().getStep() == '2') {
      await UserModel.init(await StoreAllData().readData('users'));
    }
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    listenFirebase();
    await notificationPermission();
  }
}
