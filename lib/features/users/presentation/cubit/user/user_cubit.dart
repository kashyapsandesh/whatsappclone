import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:whatsappclone/features/users/domain/entities/user_entities.dart';
import 'package:whatsappclone/features/users/domain/usecases/users/get_all_users_usecase.dart';
import 'package:whatsappclone/features/users/domain/usecases/users/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  UserCubit({required this.updateUserUseCase, required this.getAllUsersUseCase})
      : super(UserInitial());

  Future<void> getAllUsers() async {
    emit(UserLoading());
    final streamResponse = getAllUsersUseCase.call();
    streamResponse.listen((users) {
      emit(UserLoaded(users: users));
    });
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } catch (e) {
      emit(UserFailure());
    }
  }
}
