
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = sl<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AppStorage _appStorage = sl<AppStorage>();

  @override
  void initState() {
    _viewModel.start();
    _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoginSuccessfullyStreamController.stream.listen((isLoginSuccess) async {
      if (isLoginSuccess) {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await _appStorage.setIsUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
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
                    userNameController: _userNameController,
                    passwordController: _passwordController,
                  ),
                  retryFunction: () {},
                ) ??
                _ContentWidget(
                  viewModel: _viewModel,
                  userNameController: _userNameController,
                  passwordController: _passwordController,
                );
          }),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required LoginViewModel viewModel,
    required TextEditingController userNameController,
    required TextEditingController passwordController,
  })  : _viewModel = viewModel,
        _userNameController = userNameController,
        _passwordController = passwordController,
        super(key: key);

  final LoginViewModel _viewModel;
  final TextEditingController _userNameController;
  final TextEditingController _passwordController;

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
                stream: _viewModel.outputIsUserNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s20),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s40),
              StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllValid,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (snapshot.data == null || !snapshot.data!)
                            ? null
                            : () {
                                _viewModel.login();
                              },
                        child: Text(AppStrings.login.tr()),
                      ),
                    );
                  }),
              SizedBox(height: AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                    },
                    child: Text(
                      AppStrings.forgetPassword.tr(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: FontSize.s14,
                            fontWeight: FontWightManager.regular,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.registerRoute);
                    },
                    child: Text(
                      AppStrings.registerText.tr(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: FontSize.s14,
                            fontWeight: FontWightManager.regular,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
