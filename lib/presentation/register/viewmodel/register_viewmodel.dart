import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/register_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/data_classes.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  RegisterUseCase registerUseCase;
  AppStorage appStorage;

  RegisterViewModel({required this.registerUseCase ,required this.appStorage});

  StreamController<String> _nameStreamController = StreamController<String>.broadcast();
  StreamController<String> _emailStreamController = StreamController<String>.broadcast();
  StreamController<String> _passwordStreamController = StreamController<String>.broadcast();
  StreamController<String> _phoneNumberStreamController = StreamController<String>.broadcast();

  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  RegisterObject registerObject = RegisterObject();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _nameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _phoneNumberStreamController.close();
    _areAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  void setEmail(String email) {
    registerObject.email = email;
    inputEmail.add(email);
    inputAreAllValid.add(null);
  }

  @override
  void setName(String name) {
    registerObject.name = name;
    inputName.add(name);
    inputAreAllValid.add(null);
  }

  @override
  void setPassword(String password) {
    registerObject.password = password;
    inputPassword.add(password);
    inputAreAllValid.add(null);
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    registerObject.phoneNumber = phoneNumber;
    inputPhoneNumber.add(phoneNumber);
    inputAreAllValid.add(null);
  }

  //! Sinks
  @override
  Sink<String> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String> get inputName => _nameStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Sink<String> get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink<void> get inputAreAllValid => _areAllInputsValidStreamController.sink;

  //! Streams
  @override
  Stream<bool> get outputEmailValid => _emailStreamController.stream.map(_isEmailValid);

  @override
  Stream<bool> get outputNameValid => _nameStreamController.stream.map(_isNameValid);

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream.map(_isPasswordValid);

  @override
  Stream<bool> get outputPhoneNumberValid =>
      _phoneNumberStreamController.stream.map(_isPhoneNumberValid);

  @override
  Stream<bool> get outputAreAllValid =>
      _areAllInputsValidStreamController.stream.map((event) => _handleInputValid());

  //! FUNCTIONS
  @override
  Future<void> register(BuildContext context) async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    var response = await registerUseCase.execute(
      RegisterUseCaseInput(
        email: registerObject.email,
        name: registerObject.name,
        password: registerObject.password,
        phoneNumber: registerObject.phoneNumber,
      ),
    );
    response.fold(
      (failure) {
        inputState.add(
          ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR_STATE, message: failure.message),
        );
      },
      (authentication) {
        inputState.add(
          SuccessState(
            message: authentication.base?.message ?? Constants.empty,
            buttonText: AppStrings.goToHome,
            dialogAction: () async {
              await appStorage.setIsUserLoggedIn();
              Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
            },
          ),
        );
      },
    );
  }

  //! PRIVATE FUNCTIONS
  bool _handleInputValid() {
    if (!_isNameValid(registerObject.name) ||
        !_isEmailValid(registerObject.email) ||
        !_isPasswordValid(registerObject.password) ||
        !_isPhoneNumberValid(registerObject.phoneNumber)) {
      return false;
    } else
      return true;
  }

  bool _isNameValid(String value) {
    if (value.isEmpty)
      return false;
    else
      return true;
  }

  bool _isEmailValid(String value) {
    if (value.isEmpty)
      return false;
    else
      return true;
  }

  bool _isPasswordValid(String value) {
    if (value.isEmpty)
      return false;
    else
      return true;
  }

  bool _isPhoneNumberValid(String value) {
    if (value.isEmpty)
      return false;
    else
      return true;
  }
}

abstract class RegisterViewModelInputs {
  Future<void> register(BuildContext context);
  void setName(String name);
  void setEmail(String email);
  void setPassword(String password);
  void setPhoneNumber(String phoneNumber);
  Sink<String> get inputName;
  Sink<String> get inputEmail;
  Sink<String> get inputPassword;
  Sink<String> get inputPhoneNumber;
  Sink<void> get inputAreAllValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputNameValid;
  Stream<bool> get outputEmailValid;
  Stream<bool> get outputPasswordValid;
  Stream<bool> get outputPhoneNumberValid;
  Stream<bool> get outputAreAllValid;
}
