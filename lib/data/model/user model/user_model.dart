class UserModel {
  final String userId;
  final String userEmail;
  final String userPhone;
  final String username;
  final String usersApprove;

  UserModel({
    required this.userEmail,
    required this.userId,
    required this.userPhone,
    required this.username,
    required this.usersApprove,
  });

  factory UserModel.fromJson(dynamic data) {
    var jsonDateBase = data['data'][0];
    return UserModel(
        userEmail: jsonDateBase['users_email'],
        userId: jsonDateBase['users_id'],
        userPhone: jsonDateBase['users_phone'],
        username: jsonDateBase['users_name'],
        usersApprove: jsonDateBase['users_approve']);
  }

  // Singleton pattern implementation
  static UserModel? _instance;

  static UserModel get instance {
    return _instance!;
  }

  static bool get isInitialized => _instance != null;

  static Future<void> init(dynamic data) async {
    if (_instance != null) {
      throw Exception("UserModel is already initialized.");
    }
    var jsonDateBase = data[0];
    _instance = UserModel(
      userEmail: jsonDateBase['users_email'],
      userId: jsonDateBase['users_id'],
      userPhone: jsonDateBase['users_phone'],
      username: jsonDateBase['users_name'],
      usersApprove: jsonDateBase['users_approve'],
    );
  }
}

// Example of initializing UserModel with data from the 'users' table:
// UserModel.init(userData);

// Example of accessing UserModel instance:
// var userModel = UserModel.instance;
// print(userModel.username);
