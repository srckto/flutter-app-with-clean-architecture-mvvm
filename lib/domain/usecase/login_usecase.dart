import 'package:dartz/dartz.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/requests.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository repository;
  LoginUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    return await repository.login(LoginRequest(email: input.email, password: input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}
