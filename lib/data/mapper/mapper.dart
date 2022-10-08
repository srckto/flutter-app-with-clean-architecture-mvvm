import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/response/responses.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id ?? Constants.empty,
      name: this?.name ?? Constants.empty,
      numOfNotifications: this?.numOfNotifications ?? Constants.zero,
    );
  }
}

extension BaseResponseMapper on BaseResponse? {
  BaseResponseObject toDomain() {
    return BaseResponseObject(
      status: this?.status ?? Constants.one,
      message: this?.message ?? Constants.empty,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone ?? Constants.empty,
      email: this?.email ?? Constants.empty,
      link: this?.link ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      base: this?.base.toDomain(),
      contacts: this?.contacts.toDomain(),
      customer: this?.customer.toDomain(),
    );
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id ?? Constants.zero,
      title: this?.title ?? Constants.empty,
      image: this?.image ?? Constants.empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      id: this?.id ?? Constants.zero,
      title: this?.title ?? Constants.empty,
      image: this?.image ?? Constants.empty,
      link: this?.link ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id ?? Constants.zero,
      title: this?.title ?? Constants.empty,
      image: this?.image ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<BannerAd> bannersAd = this?.data?.banners?.map((e) => e.toDomain()).toList() ?? [];
    List<Store> stores = this?.data?.stores?.map((e) => e.toDomain()).toList() ?? [];
    List<Service> services = this?.data?.services?.map((e) => e.toDomain()).toList() ?? [];

    var data = HomeData(banners: bannersAd, services: services, stores: stores);

    return HomeObject(base: this?.base.toDomain(), data: data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetailsObject toDomain() {
    return StoreDetailsObject(
      baseResponse: this?.baseResponse.toDomain(),
      about: this?.about ?? Constants.empty,
      details: this?.details ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      image: this?.image ?? Constants.empty,
      services: this?.services ?? Constants.empty,
      title: this?.title ?? Constants.empty,
    );
  }
}
