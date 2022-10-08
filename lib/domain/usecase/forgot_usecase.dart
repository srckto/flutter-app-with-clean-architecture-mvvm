import 'package:dartz/dartz.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, BaseResponseObject> {
  Repository repository;
  ForgotPasswordUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, BaseResponseObject>> execute(String input) async {
    return await repository.forgot(input);
  }
}
