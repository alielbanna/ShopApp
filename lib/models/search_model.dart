import 'package:shop_app/models/favorites_model.dart';

class SearchModel {
  late bool status;
  //late String message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  List<Product> data = [];
  //String? firstPageUrl;
  //int? from;
  //int? lastPage;
  //String? lastPageUrl;
  //String? nextPageUrl;
  //String? path;
  //int? perPage;
  //String? prevPageUrl;
  //int? to;
  //int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    //data = <FavoriteData>[];
    (json['data'] as List<dynamic>).forEach((v) {
      data.add(Product.fromJson(v as Map<String, dynamic>));
    });

    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
    // total = json['total'];
  }
}

// class FavoriteData {
//   late int id;
//   late Product product;
//
//   FavoriteData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product = Product.fromJson(json['product']);
//   }
// }

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  //late int discount;
  late String image;
  late String name;
  //String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    //discount = json['discount'];
    image = json['image'];
    name = json['name'];
    // description = json['description'];
  }
}
