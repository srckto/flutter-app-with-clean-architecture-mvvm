import 'package:dartz/dartz.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository repository;
  HomeUseCase({
    required this.repository,
  });
  
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await repository.getHomeData();
  }
}

