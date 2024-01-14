
import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';
import 'package:whatsappclone/features/users/domain/repository/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.updateUser(user);
  }

}