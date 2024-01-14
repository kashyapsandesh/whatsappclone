


import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';
import 'package:whatsappclone/features/users/domain/repository/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.createUser(user);
  }

}