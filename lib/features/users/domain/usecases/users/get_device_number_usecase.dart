import 'package:whatsappclone/features/users/domain/entities/contact_entity.dart';
import 'package:whatsappclone/features/users/domain/repository/user_repository.dart';

class GetDeviceNumberUseCase {
  final UserRepository repository;

  GetDeviceNumberUseCase({required this.repository});

  Future<List<ContactEntity>> call() async {
    return repository.getDeviceNumber();
  }

}