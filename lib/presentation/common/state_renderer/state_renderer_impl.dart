import 'package:flutter/material.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType get getStateRendererType;
  String get getMessage;

  String? getButtonText;
  void Function()? getDialogAction;
}

//? Loading State [POPUP, FULL SCREEN]

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => stateRendererType;
}

//? Error State [POPUP, FULL SCREEN]

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({
    required this.stateRendererType,
    required this.message,
  });

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => stateRendererType;
}

//? Content State

class ContentState extends FlowState {
  @override
  String get getMessage => Constants.empty;

  @override
  StateRendererType get getStateRendererType => StateRendererType.CONTENT_STATE;
}

//? Empty State [FULL SCREEN]

class EmptyState extends FlowState {
  String message;
  EmptyState({
    required this.message,
  });

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => StateRendererType.FULL_SCREEN_EMPTY_STATE;
}

//? Success State [POPUP ONLY]
class SuccessState extends FlowState {
  String message;
  SuccessState({
    required this.message,
    this.buttonText,
    this.dialogAction,
  });

  String? buttonText;
  void Function()? dialogAction;

  @override
  String? get getButtonText => buttonText;

  @override
  void Function()? get getDialogAction => dialogAction;

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => StateRendererType.POPUP_SUCCESS_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentScreenWidget,
    void Function()? retryFunction,
  }) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          _dismissDialog(context);
          if (getStateRendererType == StateRendererType.POPUP_LOADING_STATE) {
            _showPopup(
              context: context,
              stateRendererType: getStateRendererType,
              message: getMessage,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType,
              message: getMessage,
              retryActionFunction: retryFunction,
            );
          }
        }
      case SuccessState:
        {
          _dismissDialog(context);
          _showPopup(
            context: context,
            stateRendererType: getStateRendererType,
            message: getMessage,
            buttonText: getButtonText,
            dialogAction: getDialogAction,
          );

          return contentScreenWidget;
        }
      case ErrorState:
        {
          _dismissDialog(context);
          if (getStateRendererType == StateRendererType.POPUP_ERROR_STATE) {
            _showPopup(
              context: context,
              stateRendererType: getStateRendererType,
              message: getMessage,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType,
              message: getMessage,
              retryActionFunction: retryFunction,
            );
          }
        }
      case ContentState:
        {
          _dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          _dismissDialog(context);
          return StateRenderer(
            stateRendererType: getStateRendererType,
            message: getMessage,
            retryActionFunction: retryFunction,
          );
        }
      default:
        {
          _dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  bool _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  void _dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  void _showPopup({
    required BuildContext context,
    required StateRendererType stateRendererType,
    required String message,
    String? buttonText,
    void Function()? dialogAction,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StateRenderer(
          stateRendererType: stateRendererType,
          retryActionFunction: () {},
          buttonText: buttonText,
          dialogAction: dialogAction,
          message: message,
        ),
      ),
    );
  }
}
