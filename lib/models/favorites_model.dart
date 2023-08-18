class FavoritesModel {
  late bool status;
  String? message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  late List<FavoritesData> data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = <FavoritesData>[];
    json['data'].forEach((v) {
      data.add(FavoritesData.fromJson(v));
    });
  }
}

class FavoritesData {
  late int id;
  late Product product;
  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }

}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
