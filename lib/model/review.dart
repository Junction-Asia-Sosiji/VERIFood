import 'package:uuid/uuid.dart';

class Review {
  // uuid: UUID
  // rating: Integer
  // author_name: Text
  // author_week: Integer
  // created_at: Long
  // food: UUID
  // checklist: Integer
  // comment: Text
  // picture_url: Text

  final Uuid uuid;
  final int rating;
  final String authorName;
  final int authorWeek;
  final int createdAt;
  final Uuid food;
  final int checklist;
  final String comment;
  final String pictureUrl;

  const Review({
    required this.uuid,
    required this.rating,
    required this.authorName,
    required this.authorWeek,
    required this.createdAt,
    required this.food,
    required this.checklist,
    required this.comment,
    required this.pictureUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid.toString(),
      'rating': rating,
      'authorName': authorName,
      'authorWeek': authorWeek,
      'createdAt': createdAt,
      'food': food.toString(),
      'checklist': checklist,
      'comment': comment,
      'pictureUrl': pictureUrl,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      uuid: Uuid.parse(json['uuid']) as Uuid,
      rating: json['rating'],
      authorName: json['authorName'],
      authorWeek: json['authorWeek'],
      createdAt: json['createdAt'],
      food: Uuid.parse(json['food']) as Uuid,
      checklist: json['checklist'],
      comment: json['comment'],
      pictureUrl: json['pictureUrl'],
    );
  }

}