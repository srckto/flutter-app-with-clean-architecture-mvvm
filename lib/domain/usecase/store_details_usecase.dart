import 'package:dartz/dartz.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<int, StoreDetailsObject> {
  Repository repository;
  StoreDetailsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, StoreDetailsObject>> execute(int input) async {
    return await repository.getStoreDetails(input);
  }
}
