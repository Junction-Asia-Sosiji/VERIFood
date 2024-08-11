import 'package:uuid/uuid.dart';

import 'package:uuid/uuid.dart';

class Store {
  // uuid: UUID
  // name: Text
  // latitude: Integer
  // longitude: Integer
  // likes: Integer
  // review_list: json(List<UUID>)
  // food_list: json(List<UUID>)

  final Uuid uuid;
  final String name;
  final int mapX;
  final int mapY;
  final int likes;
  final List<Uuid> reviewList;
  final List<Uuid> foodList;


  const Store({
    required this.uuid,
    required this.name,
    required this.mapX,
    required this.mapY,
    required this.likes,
    required this.reviewList,
    required this.foodList,
  });

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid.toString(),
      'name': name,
      'mapX': mapX,
      'mapY': mapY,
      'likes': likes,
      'reviewList': reviewList.map((review) => review.toString()).toList(),
      'foodList': foodList.map((food) => food.toString()).toList(),
    };
  }

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      uuid: Uuid.parse(json['uuid']) as Uuid,
      name: json['name'],
      mapX: json['mapX'],
      mapY: json['mapY'],
      likes: json['likes'],
      reviewList: json['reviewList'].map((review) => Uuid.parse(review)).toList(),
      foodList: json['foodList'].map((food) => Uuid.parse(food)).toList(),
    );
  }
}