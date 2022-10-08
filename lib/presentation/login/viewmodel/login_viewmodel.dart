import 'dart:async';

import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/data_classes.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController<String> _userNameStreamController = StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  LoginObject loginObject = LoginObject();
  final StreamController<bool> isUserLoginSuccessfullyStreamController =
      StreamController<bool>.broadcast();
  final LoginUseCase loginUseCase;

  LoginViewModel({
    required this.loginUseCase,
  });

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoginSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Future<void> login() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      message: AppStrings.loading,
    ));
    Either<Failure, Authentication> response = await loginUseCase.execute(
      LoginUseCaseInput(email: loginObject.userName, password: loginObject.password),
    );

    response.fold(
      (failure) {
        inputState.add(
          ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (authentication) {
        isUserLoginSuccessfullyStreamController.add(true);
        inputState.add(ContentState());
      },
    );
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllValid.add(null);
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllValid.add(null);
  }

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Sink<String> get inputUserName => _userNameStreamController.sink;

  @override
  Sink<void> get inputAreAllValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputAreAllValid =>
      _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream.map(_handleUserNameValid);

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(_handlePasswordValid);

  //! Private Functions
  bool _handleUserNameValid(String? value) {
    if (value == null || value.isEmpty || value.length < 5)
      return false;
    else
      return true;
  }

  bool _handlePasswordValid(String? value) {
    if (value == null || value.isEmpty || value.length < 5)
      return false;
    else
      return true;
  }

  bool _areAllInputsValid() {
    return _handleUserNameValid(loginObject.userName) && _handlePasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  void setUserName(String userName);
  void setPassword(String password);
  Future<void> login();
  Sink<String> get inputUserName;
  Sink<String> get inputPassword;
  Sink<void> get inputAreAllValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputAreAllValid;
}
