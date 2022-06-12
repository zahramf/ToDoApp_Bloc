import 'package:to_do_app_bloc/home/model/user.dart';
import 'package:hive/hive.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
    await _users.clear();
    await _users.add(User("username1", "password1"));
    await _users.add(User("username2", "password2"));
  }

  Future<String?> authenticateUser(
      final String? username, final String? password) async {
    final success = _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
