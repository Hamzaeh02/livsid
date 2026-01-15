class ProductModel {
  bool? success;
  int? statusCode;
  String? msg;
  Data? data;

  ProductModel({this.success, this.statusCode, this.msg, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  ProductDetail? product;
  List<RelatedProduct>? relatedProducts;

  Data({this.product, this.relatedProducts});

  Data.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? ProductDetail.fromJson(json['product']) : null;
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProduct>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(RelatedProduct.fromJson(v));
      });
    }
  }
}

class ProductDetail {
  Location? location;
  String? sId;
  String? userId;
  String? title;
  String? subtitle;
  String? description;
  String? type;
  String? categorySlug;
  String? coverImage;
  List<String>? images;
  int? price;
  String? currency;
  int? ratingAvg;
  int? ratingCount;
  String? city;
  String? address;
  bool? isActive;
  List<String>? tags;
  String? createdAt;

  ProductDetail({
    this.location,
    this.sId,
    this.userId,
    this.title,
    this.subtitle,
    this.description,
    this.type,
    this.categorySlug,
    this.coverImage,
    this.images,
    this.price,
    this.currency,
    this.ratingAvg,
    this.ratingCount,
    this.city,
    this.address,
    this.isActive,
    this.tags,
    this.createdAt,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    userId = json['userId'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    type = json['type'];
    categorySlug = json['categorySlug'];
    coverImage = json['coverImage'];
    images = json['images']?.cast<String>();
    price = json['price'];
    currency = json['currency'];
    ratingAvg = json['ratingAvg'];
    ratingCount = json['ratingCount'];
    city = json['city'];
    address = json['address'];
    isActive = json['isActive'];
    tags = json['tags']?.cast<String>();
    createdAt = json['createdAt'];
  }
}

class RelatedProduct {
  String? sId;
  String? title;
  String? coverImage;
  int? price;

  RelatedProduct({this.sId, this.title, this.coverImage, this.price});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    coverImage = json['coverImage'];
    price = json['price'];
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num?)?.toDouble();
    lng = (json['lng'] as num?)?.toDouble();
  }
}