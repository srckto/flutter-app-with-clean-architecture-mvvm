

class BaseResponse {
  int? status;
  String? message;
  BaseResponse({
    this.status,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      status: map['status'],
      message: map['message'],
    );
  }
}

class CustomerResponse {
  String? id;
  String? name;
  int? numOfNotifications;
  CustomerResponse({
    this.id,
    this.name,
    this.numOfNotifications,
  });
  factory CustomerResponse.fromMap(Map<String, dynamic> map) {
    return CustomerResponse(
      id: map['id'],
      name: map['name'],
      numOfNotifications: map['numOfNotifications']?.toInt(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numOfNotifications': numOfNotifications,
    };
  }
}

class ContactsResponse {
  String? phone;
  String? email;
  String? link;
  ContactsResponse({
    this.phone,
    this.email,
    this.link,
  });

  factory ContactsResponse.fromMap(Map<String, dynamic> map) {
    return ContactsResponse(
      phone: map['phone'],
      email: map['email'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'link': link,
    };
  }
}

class AuthenticationResponse {
  BaseResponse? base;
  CustomerResponse? customer;
  ContactsResponse? contacts;

  AuthenticationResponse({
    this.base,
    this.customer,
    this.contacts,
  });

  factory AuthenticationResponse.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponse(
      base: BaseResponse.fromMap(map),
      customer: map['customer'] != null ? CustomerResponse.fromMap(map['customer']) : null,
      contacts: map['contacts'] != null ? ContactsResponse.fromMap(map['contacts']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'base': base?.toMap(),
      'customer': customer?.toMap(),
      'contacts': contacts?.toMap(),
    };
  }
}

class ServiceResponse {
  int? id;
  String? title;
  String? image;
  ServiceResponse({
    this.id,
    this.title,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory ServiceResponse.fromMap(Map<String, dynamic> map) {
    return ServiceResponse(
      id: map['id']?.toInt(),
      title: map['title'],
      image: map['image'],
    );
  }
}

class BannerResponse {
  int? id;
  String? title;
  String? image;
  String? link;
  BannerResponse({
    this.id,
    this.title,
    this.image,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'link': link,
    };
  }

  factory BannerResponse.fromMap(Map<String, dynamic> map) {
    return BannerResponse(
      id: map['id']?.toInt(),
      title: map['title'],
      image: map['image'],
      link: map['link'],
    );
  }
}

class StoreResponse {
  int? id;
  String? title;
  String? image;
  StoreResponse({
    this.id,
    this.title,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory StoreResponse.fromMap(Map<String, dynamic> map) {
    return StoreResponse(
      id: map['id']?.toInt(),
      title: map['title'],
      image: map['image'],
    );
  }
}

class HomeDataResponse {
  List<ServiceResponse>? services;
  List<BannerResponse>? banners;
  List<StoreResponse>? stores;

  HomeDataResponse({
    this.services,
    this.banners,
    this.stores,
  });

  Map<String, dynamic> toMap() {
    return {
      'services': services?.map((x) => x.toMap()).toList(),
      'banners': banners?.map((x) => x.toMap()).toList(),
      'stores': stores?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeDataResponse.fromMap(Map<String, dynamic> map) {
    return HomeDataResponse(
      services: map['services'] != null
          ? List<ServiceResponse>.from(map['services']?.map((x) => ServiceResponse.fromMap(x)))
          : null,
      banners: map['banners'] != null
          ? List<BannerResponse>.from(map['banners']?.map((x) => BannerResponse.fromMap(x)))
          : null,
      stores: map['stores'] != null
          ? List<StoreResponse>.from(map['stores']?.map((x) => StoreResponse.fromMap(x)))
          : null,
    );
  }
}

class HomeResponse {
  BaseResponse? base;
  HomeDataResponse? data;
  HomeResponse({
    this.base,
    this.data,
  });

  factory HomeResponse.fromMap(Map<String, dynamic> map) {
    return HomeResponse(
      base: BaseResponse.fromMap(map),
      data: map['data'] != null ? HomeDataResponse.fromMap(map['data']) : null,
    );
  }
}

class StoreDetailsResponse {
  BaseResponse? baseResponse;
  int? id;
  String? image;
  String? title;
  String? details;
  String? services;
  String? about;

  StoreDetailsResponse({
    this.baseResponse,
    this.id,
    this.image,
    this.title,
    this.details,
    this.services,
    this.about,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': image,
      'title': title,
      'details': details,
      'services': services,
      'about': about,
    };
  }

  factory StoreDetailsResponse.fromMap(Map<String, dynamic> map) {
    return StoreDetailsResponse(
      baseResponse: BaseResponse.fromMap(map),
      id: map['id']?.toInt(),
      image: map['image'],
      title: map['title'],
      details: map['details'],
      services: map['services'],
      about: map['about'],
    );
  }
}
