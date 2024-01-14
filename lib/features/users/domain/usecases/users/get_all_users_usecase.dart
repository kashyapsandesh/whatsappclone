
import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';
import 'package:whatsappclone/features/users/domain/repository/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }

}