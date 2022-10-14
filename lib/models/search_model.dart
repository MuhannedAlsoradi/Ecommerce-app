class SearchModel {
  late bool status;
  Data? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Product> data = [];
  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach(
      (element) {
        data.add(Product.fromJson(element));
      },
    );
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
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
