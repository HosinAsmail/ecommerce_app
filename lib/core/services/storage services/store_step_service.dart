
import 'package:shared_preferences/shared_preferences.dart';

class StoreStepService {
  // Private constructor for the singleton pattern
   late SharedPreferences sharedPreferences;

  StoreStepService._privateConstructor();

  static final StoreStepService _instance =
      StoreStepService._privateConstructor();
  // Singleton pattern explanation
  // because each time you call the constructor in this foramt class() , you create a new instance of the class which
  // the sharePref has not been initialized in this instance of the class, but when you create a private constructor
  // or when you call the class(), the factory down returns the same previous instance
  factory StoreStepService() {
    return _instance;
  }

  Future<void> initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setStep(String step) async {
    await sharedPreferences.setString('step', step);
  }

  String? getStep() {
    String? step = sharedPreferences.getString('step');
    return step;
  }

  Future<void> clear()async {
   await sharedPreferences.clear();
  }
}
