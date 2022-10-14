class FavGetModel {
  late bool status;
  late Data data;
  FavGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<FavDataItemsModel> data = [];
  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach(
      (element) {
        data.add(FavDataItemsModel.fromJson(element));
      },
    );
  }
}

class FavDataItemsModel {
  late int favId;
  late Product product;
  FavDataItemsModel.fromJson(Map<String, dynamic> json) {
    favId = json['id'];
    product = Product.fromJson(json['product']);
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
