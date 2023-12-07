
import 'package:assignment_test/repositery/authrepositery/loginRepositery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_test/dataModel/loginModel.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginCubit(this._repository) : super(LoginInitial());

 Future<void> postLoginData(Login login) async {
  try {
    print("LoginCubit: postLoginData started");
    emit(LoginLoading());

    final success = await _repository.postLoginData(login);

    if (success) {
      print("LoginCubit: postLoginData success");
      emit(LoginSuccess());
    } else {
      print("LoginCubit: postLoginData failure");
      emit(LoginFailure(error: 'Login failed'));
    }
  } catch (e) {
    print("LoginCubit: postLoginData error - $e");
    emit(LoginFailure(error: 'An error occurred: $e'));
  }
}

}