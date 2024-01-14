
import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';
import 'package:whatsappclone/features/users/domain/repository/user_repository.dart';

class GetSingleUserUseCase {
  final UserRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }

}