class Product {

  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? id;

  Product({this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String,dynamic> toMap(String id){
    return {
      'id': id,
      'name': name,
      'description':description,
      'price':price,
      'imageUrl':imageUrl,
    };
  }
  Product.fromMap(Map<String, dynamic> map)
      : name = map['name']?? "",
        id= map["id"]?? "",
        description = map['description']?? "",
        price = map['price']?? "",
        imageUrl = map['imageUrl']?? "";

}

