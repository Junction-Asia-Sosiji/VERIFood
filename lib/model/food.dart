import 'package:uuid/uuid.dart';

class Food {
  // uuid: UUID
  // name: Text
  // price: nullable Integer
  // picture_url: nullable Text

  final String uuid;
  final String name;
  final int? price;
  final String? pictureUrl;

  const Food({
    required this.uuid,
    required this.name,
    this.price,
    this.pictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid.toString(),
      'name': name,
      'price': price,
      'pictureUrl': pictureUrl,
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      uuid: json['uuid'],
      name: json['name'],
      price: json['price'],
      pictureUrl: json['pictureUrl'],
    );
  }
}