import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/components/build_image.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = sl<HomeViewModel>();

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
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

    return Container(
      width: size.width,
      height: size.height,
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                retryFunction: () {
                  _viewModel.getHomeData();
                },
                contentScreenWidget: _ContentWidget(viewModel: _viewModel),
              ) ??
              Container();
        },
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSize.s12),
          _BuildCarouselSlider(viewModel: viewModel),
          SizedBox(height: AppSize.s12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: Text(
              AppStrings.services.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(height: AppSize.s12),
          _BuildServices(viewModel: viewModel),
          SizedBox(height: AppSize.s12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: Text(
              AppStrings.stores.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(height: AppSize.s12),
          _BuildStores(viewModel: viewModel),
        ],
      ),
    );
  }
}

class _BuildCarouselSlider extends StatelessWidget {
  const _BuildCarouselSlider({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BannerAd>>(
      stream: viewModel.outputBanners,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: Constants.carouselSliderDuration),
          ),
          items: snapshot.data!.map((element) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s10),
              child: BuildImage(imageUrl: element.image),
            );
          }).toList(),
        );
      },
    );
  }
}

class _BuildServices extends StatelessWidget {
  const _BuildServices({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Service>>(
      stream: viewModel.outputServices,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return Container(
          height: AppSize.s150,
          child: ListView.separated(
            clipBehavior: Clip.none,
            itemCount: snapshot.data?.length ?? Constants.zero,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: AppSize.s4);
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: AppSize.s4),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: AppSize.s4,
                      color: ColorManager.lightGrey,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      child: BuildImage(
                        imageUrl: snapshot.data?[index].image ?? Constants.empty,
                        width: 114,
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: AppSize.s4),
                    Text(
                      snapshot.data?[index].title ?? Constants.empty,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BuildStores extends StatelessWidget {
  const _BuildStores({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Store>>(
      stream: viewModel.outputStores,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: AppSize.s20,
            crossAxisSpacing: AppSize.s20,
            children: snapshot.data!
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                    },
                    child: BuildImage(
                      imageUrl: e.image,
                      height: 110,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
