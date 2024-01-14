

import 'package:whatsappclone/features/users/domain/entities/contact_entity.dart';
import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';

abstract class UserRepository {

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);

  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUID();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Stream<List<UserEntity>> getAllUsers();
  Stream<List<UserEntity>> getSingleUser(String uid);

  Future<List<ContactEntity>> getDeviceNumber();
}