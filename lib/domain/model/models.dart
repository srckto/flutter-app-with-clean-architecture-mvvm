class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class BaseResponseObject {
  int status;
  String message;
  BaseResponseObject({
    required this.status,
    required this.message,
  });
}

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Authentication {
  BaseResponseObject? base;
  Customer? customer;
  Contacts? contacts;
  Authentication({
    this.base,
    this.customer,
    this.contacts,
  });
}

class Service {
  int id;
  String title;
  String image;
  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;
  BannerAd({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });
}

class Store {
  int id;
  String title;
  String image;

  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;
  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });
}

class HomeObject {
  BaseResponseObject? base;
  HomeData? data;

  HomeObject({
    this.base,
    this.data,
  });
}

class StoreDetailsObject {
  BaseResponseObject? baseResponse;
  int id;
  String image;
  String title;
  String details;
  String services;
  String about;

  StoreDetailsObject({
     this.baseResponse,
    required this.id,
    required this.image,
    required this.title,
    required this.details,
    required this.services,
    required this.about,
  });
}
