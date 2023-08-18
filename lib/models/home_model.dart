/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Banner {
  late int id;
  late String image;
  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

}

class Data {
  late List<Banner> banners;
  late List<Product> products;
  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banner>[];
      json['banners'].forEach((v) {
        banners.add(Banner.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  late int id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  late String image;
  late String name;
  late bool infavorites;
  late bool incart;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
  }
}

class HomeModel {
  late bool status;
  late Data? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
  }
}