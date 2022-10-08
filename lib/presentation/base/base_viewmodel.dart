import 'dart:async';

import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  final StreamController<FlowState> _inputStreamController =
      BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink<FlowState> get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream;
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink<FlowState> get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
