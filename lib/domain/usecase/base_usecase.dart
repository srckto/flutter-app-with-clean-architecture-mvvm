import 'package:dartz/dartz.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> execute(Input input);
}
