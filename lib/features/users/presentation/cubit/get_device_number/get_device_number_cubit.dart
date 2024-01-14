import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:whatsappclone/features/users/domain/entities/contact_entity.dart';
import 'package:whatsappclone/features/users/domain/usecases/users/get_device_number_usecase.dart';

part 'get_device_number_state.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  GetDeviceNumberUseCase getDeviceNumberUseCase;
  GetDeviceNumberCubit({required this.getDeviceNumberUseCase}) : super(GetDeviceNumberInitial());

  Future<void> getDeviceNumber() async {
    try{
      final contactNumbers=await getDeviceNumberUseCase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumbers));
    }catch(_){
      emit(GetDeviceNumberFailure());
    }
  }
}