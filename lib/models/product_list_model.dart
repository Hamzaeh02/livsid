class ProductListModel {
  bool? success;
  int? statusCode;
  List<ProductListData>? data;
  Meta? meta;

  ProductListModel({this.success, this.statusCode, this.data, this.meta});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ProductListData>[];
      json['data'].forEach((v) {
        data!.add(ProductListData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class ProductListData {
  String? sId;
  String? title;
  String? coverImage;
  int? price;

  ProductListData({this.sId, this.title, this.coverImage, this.price});

  ProductListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    coverImage = json['coverImage'];
    price = json['price'];
  }
}

class Meta {
  int? page;
  int? limit;
  String? sort;

  Meta({this.page, this.limit, this.sort});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    sort = json['sort'];
  }
}