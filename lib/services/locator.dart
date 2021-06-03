import 'package:chataplication/repository/user_repository.dart';
import 'package:chataplication/services/fake_auth_service.dart';
import 'package:chataplication/services/firebase_auth_service.dart';
import 'package:chataplication/services/firebase_database_service.dart';
import 'package:chataplication/services/firebase_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getit = GetIt.instance;

void setuplocator() {
  getit.registerLazySingleton(() => FireBaseAuthService());
  getit.registerLazySingleton(() => FakeAuthService());
  getit.registerLazySingleton(() => UserRepository());
  getit.registerLazySingleton(() => FireBaseDatabase());
  getit.registerLazySingleton(() => FireBaseStorage());
}
