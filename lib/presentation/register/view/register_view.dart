import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = sl<RegisterViewModel>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void _bind() {
    _viewModel.start();
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _phoneNumberController
        .addListener(() => _viewModel.setPhoneNumber(_phoneNumberController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
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
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    phoneNumberController: _phoneNumberController,
                  ),
                  retryFunction: () {},
                ) ??
                _ContentWidget(
                  viewModel: _viewModel,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  phoneNumberController: _phoneNumberController,
                );
          }),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required RegisterViewModel viewModel,
    required TextEditingController nameController,
    required TextEditingController passwordController,
    required TextEditingController emailController,
    required TextEditingController phoneNumberController,
  })  : _viewModel = viewModel,
        _nameController = nameController,
        _passwordController = passwordController,
        _emailController = emailController,
        _phoneNumberController = phoneNumberController,
        super(key: key);

  final RegisterViewModel _viewModel;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _phoneNumberController;

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
                stream: _viewModel.outputNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username.tr(),
                      labelText: AppStrings.username.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s20),
              StreamBuilder<bool>(
                stream: _viewModel.outputEmailValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.emailHint.tr(),
                      labelText: AppStrings.emailHint.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.invalidEmail.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s20),
              StreamBuilder<bool>(
                stream: _viewModel.outputPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password.tr(),
                      labelText: AppStrings.password.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError.tr(),
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.s20),
              StreamBuilder<bool>(
                stream: _viewModel.outputPhoneNumberValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: AppStrings.phoneNumber.tr(),
                      labelText: AppStrings.phoneNumber.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.phoneNumberError.tr(),
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
                                _viewModel.register(context);
                              },
                        child: Text(AppStrings.register.tr()),
                      ),
                    );
                  }),
              SizedBox(height: AppSize.s8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.alreadyHaveAccount.tr(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWightManager.regular,
                        ),
                  ),
                ),
              ),
              SizedBox(height: AppSize.s40),
            ],
          ),
        ),
      ),
    );
  }
}
