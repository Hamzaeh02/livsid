class ProductResponse {
  bool? success;
  int? statusCode;
  List<ProductData>? data;
  Meta? meta;

  ProductResponse({this.success, this.statusCode, this.data, this.meta});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class ProductData {
  String? id;
  String? title;
  String? type;
  String? categorySlug;
  String? coverImage;

  ProductData({
    this.id,
    this.title,
    this.type,
    this.categorySlug,
    this.coverImage,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    type = json['type'];
    categorySlug = json['categorySlug'];
    coverImage = json['coverImage'];
  }
}

class Meta {
  int? page;
  int? limit;

  Meta({this.page, this.limit});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
  }
}