import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/store_details_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel({required this.storeDetailsUseCase});

  BehaviorSubject<StoreDetailsObject> _storeDetailsStreamController =
      BehaviorSubject<StoreDetailsObject>();

  @override
  void start() {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Future<void> getStoreDetails(int id) async {
    final response = await storeDetailsUseCase.execute(id);
    response.fold(
      (failure) {
        inputState.add(
          ErrorState(
            stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (storeDetailsObject) {
        inputStoreDetails.add(storeDetailsObject);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Sink<StoreDetailsObject> get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetailsObject> get outputStoreDetails => _storeDetailsStreamController.stream;
}

abstract class StoreDetailsViewModelInput {
  Future<void> getStoreDetails(int id);
  Sink<StoreDetailsObject> get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetailsObject> get outputStoreDetails;
}
