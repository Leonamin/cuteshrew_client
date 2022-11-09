import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:flutter/cupertino.dart';

enum RegisterState {
  INIT,
  LOADING,
  COMPLETED,
  FAILD,
  ERROR,
}

class RegisterProvider extends ChangeNotifier {
  CuteshrewApiClient api;
  RegisterState _state = RegisterState.INIT;
  RegisterState get state => _state;
  RegisterProvider({required this.api});

  Future<RegisterState> postSignIn(UserCreate newUser) async {
    if (state != RegisterState.LOADING) {
      _state = RegisterState.LOADING;
      notifyListeners();
      try {
        await api.postSignin(newUser);
        _state = RegisterState.COMPLETED;
      } catch (e) {
        //TODO 나중에 응답코드같은거 정리해서 0: 문제없음 1: 아이디 중복 2: 기타 등등으로 바꾸면 좋을듯
        _state = RegisterState.FAILD;
      }
    }

    notifyListeners();
    return state;
  }
}
