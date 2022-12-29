import 'package:cuteshrew/core/domain/usecase/signin_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/data/user_create_data.dart';
import 'package:cuteshrew/presentation/mappers/user_create_data_mapper.dart';
import 'package:flutter/cupertino.dart';

enum RegisterState {
  INIT,
  LOADING,
  COMPLETED,
  FAILD,
  ERROR,
}

class RegisterProvider extends ChangeNotifier {
  late SigninUseCase _signinUseCase;

  RegisterState _state = RegisterState.INIT;
  RegisterState get state => _state;
  RegisterProvider({required SigninUseCase signinUseCase}) {
    _signinUseCase = signinUseCase;
  }

  Future<RegisterState> postSignIn(UserCreateData newUser) async {
    if (state != RegisterState.LOADING) {
      _state = RegisterState.LOADING;
      notifyListeners();

      UserCreateDataMapper mapper = UserCreateDataMapper();

      final result = await _signinUseCase(mapper.map(newUser));
      result.fold((Failure failure) {
        //TODO 나중에 응답코드같은거 정리해서 0: 문제없음 1: 아이디 중복 2: 기타 등등으로 바꾸면 좋을듯
        _state = RegisterState.FAILD;
      }, (data) {
        _state = RegisterState.COMPLETED;
      });
    }

    notifyListeners();
    return state;
  }
}
