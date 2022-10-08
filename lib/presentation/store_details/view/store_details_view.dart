import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/components/build_image.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/store_details/viewmodel/store_details_viewmodel.dart';

class StoreDetailsView extends StatefulWidget {
  StoreDetailsView({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<StoreDetailsView> {
  final _viewModel = sl<StoreDetailsViewModel>();

  @override
  void initState() {
    _viewModel.start();
    _viewModel.getStoreDetails(widget.id ?? 1);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeDetails.tr()),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _ContentWidget(viewModel: _viewModel),
                ) ??
                Container();
          },
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final StoreDetailsViewModel viewModel;
  const _ContentWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return StreamBuilder<StoreDetailsObject>(
      stream: viewModel.outputStoreDetails,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildImage(
                  imageUrl: snapshot.data?.image ?? Constants.empty,
                ),
                SizedBox(height: AppSize.s20),
                Text(
                  AppStrings.details.tr(),
                  style: theme.headlineLarge,
                ),
                SizedBox(height: AppSize.s10),
                Text(
                  snapshot.data?.details ?? Constants.empty,
                  style: theme.headlineSmall,
                ),
                SizedBox(height: AppSize.s10),
                Text(
                  AppStrings.services.tr(),
                  style: theme.headlineLarge,
                ),
                SizedBox(height: AppSize.s10),
                Text(
                  snapshot.data?.services ?? Constants.empty,
                  style: theme.headlineSmall,
                ),
                SizedBox(height: AppSize.s10),
                Text(
                  AppStrings.about.tr(),
                  style: theme.headlineLarge,
                ),
                SizedBox(height: AppSize.s10),
                Text(
                  snapshot.data?.about ?? Constants.empty,
                  style: theme.headlineSmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
