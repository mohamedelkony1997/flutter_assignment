class ItemModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final List<String> related; 
  final String type;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.related,
    required this.type,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['imageurl'],
      related: List<String>.from(json['related']),
      type: json['type'],
    );
  }
}
