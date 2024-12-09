import 'package:doctor_app/features/login_screen/data/models/login_request_body.dart';
import 'package:doctor_app/features/login_screen/data/repo/login_repo.dart';
import 'package:doctor_app/features/login_screen/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  void emitloginState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(success: (loginResp) {
      emit(LoginState.success(loginResp));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }
}