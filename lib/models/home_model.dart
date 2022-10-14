class HomeModel {
  late bool status;
  late Data data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Banners> banners = [];
  List<Products> products = [];
  Data.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(Banners.fromJson(banner));
    });
    json['products'].forEach((product) {
      products.add(Products.fromJson(product));
    });
  }
}

class Banners {
  late int id;
  late String image;
  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
