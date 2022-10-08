import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

enum StateRendererType {
  //! POPUP STATES [DIALOG]
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS_STATE,

  //! FULL SCREEN STATES [FULL SCREEN]
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_EMPTY_STATE,

  //! GENERAL
  CONTENT_STATE,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.message,
    this.buttonText,
    this.dialogAction,
    required this.retryActionFunction,
  }) : super(key: key);

  final StateRendererType stateRendererType;
  final String message;
  final String? buttonText;
  final void Function()? retryActionFunction;
  final void Function()? dialogAction;

  @override
  Widget build(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          content: _GetRendererWidget(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GetAnimatedImage(
                jsonImagePath: JsonImagePath.loading,
              ),
            ],
          ),
        );

      case StateRendererType.POPUP_SUCCESS_STATE:
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          content: _GetRendererWidget(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GetAnimatedImage(
                jsonImagePath: JsonImagePath.success,
              ),
              SizedBox(height: AppSize.s8),
              _GetTextWidget(message: message),
              SizedBox(height: AppSize.s8),
              _GetElevatedButton(
                text: buttonText ?? AppStrings.ok,
                onPressed: dialogAction ??
                    () {
                      Navigator.pop(context);
                    },
              ),
            ],
          ),
        );

      case StateRendererType.POPUP_ERROR_STATE:
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          content: _GetRendererWidget(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GetAnimatedImage(
                jsonImagePath: JsonImagePath.error,
              ),
              SizedBox(height: AppSize.s8),
              _GetTextWidget(message: message),
              SizedBox(height: AppSize.s8),
              _GetElevatedButton(
                text: AppStrings.ok,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _GetRendererWidget(
          children: [
            _GetAnimatedImage(
              jsonImagePath: JsonImagePath.loading,
            ),
            _GetTextWidget(message: AppStrings.loading),
          ],
        );
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _GetRendererWidget(
          children: [
            _GetAnimatedImage(
              jsonImagePath: JsonImagePath.error,
            ),
            SizedBox(height: AppSize.s8),
            _GetTextWidget(message: message),
            SizedBox(height: AppSize.s8),
            _GetElevatedButton(
              text: AppStrings.retryAgain,
              onPressed: retryActionFunction,
            ),
          ],
        );
      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _GetRendererWidget(
          children: [
            _GetAnimatedImage(
              jsonImagePath: JsonImagePath.empty,
              repeat: false,
            ),
            SizedBox(height: AppSize.s8),
            _GetTextWidget(message: AppStrings.noContent),
          ],
        );
      case StateRendererType.CONTENT_STATE:
        return Container();
    }
  }
}

class _GetRendererWidget extends StatelessWidget {
  const _GetRendererWidget({
    Key? key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
  }) : super(key: key);
  final List<Widget> children;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

class _GetAnimatedImage extends StatelessWidget {
  const _GetAnimatedImage({
    Key? key,
    required this.jsonImagePath,
    this.repeat = true,
  }) : super(key: key);
  final String jsonImagePath;
  final bool repeat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(
        jsonImagePath,
        repeat: repeat,
      ),
    );
  }
}

class _GetTextWidget extends StatelessWidget {
  const _GetTextWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message.tr(),
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }
}

class _GetElevatedButton extends StatelessWidget {
  const _GetElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * AppSize.s0_5,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text.tr()),
      ),
    );
  }
}
