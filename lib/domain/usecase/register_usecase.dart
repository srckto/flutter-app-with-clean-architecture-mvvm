import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/requests.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository repository;
  RegisterUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    return await repository.register(
      RegisterRequest(
        name: input.name,
        phoneNumber: input.phoneNumber,
        email: input.email,
        password: input.password,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String name;
  String phoneNumber;
  String email;
  String password;
  RegisterUseCaseInput({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
