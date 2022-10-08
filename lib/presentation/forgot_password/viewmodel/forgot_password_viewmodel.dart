import 'dart:async';

import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/forgot_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordViewModel({required this.forgotPasswordUseCase});

  final StreamController<String> _emailStreamController = StreamController<String>.broadcast();

  final StreamController<String> _isEmailInputValidStreamController =
      StreamController<String>.broadcast();

  String email = Constants.empty;

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void setEmail(String email) {
    this.email = email;
    inputEmail.add(email);
    inputIsEmailValid.add(email);
  }

  @override
  Future<void> forgotPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    var response = await forgotPasswordUseCase.execute(email);

    response.fold(
      (failure) {
        inputState.add(
          ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (response) {
        inputState.add(
          SuccessState(
            message: response.message,
          ),
        );
      },
    );
  }

  @override
  Sink<String> get inputEmail => _emailStreamController.sink;
  @override
  Stream<String> get outputEmail => _emailStreamController.stream;

  @override
  Sink<String> get inputIsEmailValid => _isEmailInputValidStreamController.sink;
  @override
  Stream<bool> get outputIsEmailValid =>
      _isEmailInputValidStreamController.stream.map((event) => _handleEmailValid(event));

  bool _handleEmailValid(String email) {
    if (email.isEmpty)
      return false;
    else
      return true;
  }
}

abstract class ForgotPasswordViewModelInputs {
  Sink<String> get inputEmail;
  Sink<String> get inputIsEmailValid;
  Future<void> forgotPassword();
  void setEmail(String email);
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<String> get outputEmail;
  Stream<bool> get outputIsEmailValid;
}
