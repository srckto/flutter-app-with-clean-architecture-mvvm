import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel = sl<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();

  void _bind() async {
    _viewModel.start();
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _ContentWidget(
                    viewModel: _viewModel,
                    emailController: _emailController,
                  ),
                  retryFunction: () {},
                ) ??
                _ContentWidget(
                  viewModel: _viewModel,
                  emailController: _emailController,
                );
          }),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required ForgotPasswordViewModel viewModel,
    required TextEditingController emailController,
  })  : _viewModel = viewModel,
        _emailController = emailController,
        super(key: key);

  final ForgotPasswordViewModel _viewModel;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSize.s60),
              Image.asset(ImageAssets.splashLogo),
              SizedBox(height: AppSize.s40),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsEmailValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.emailHint.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.invalidEmail.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s40),
              StreamBuilder<bool>(
                  stream: _viewModel.outputIsEmailValid,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (snapshot.data == null || !snapshot.data!)
                            ? null
                            : () {
                                _viewModel.forgotPassword();
                              },
                        child: Text(AppStrings.resetPassword.tr()),
                      ),
                    );
                  }),
              SizedBox(height: AppSize.s8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // _viewModel.forgotPassword();
                  },
                  child: Text(
                    AppStrings.didNotReceiveEmail.tr(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWightManager.regular,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
