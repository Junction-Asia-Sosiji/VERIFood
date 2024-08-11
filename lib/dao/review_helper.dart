import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/dao/store_helper.dart';
import 'package:veri_food/model/review.dart';

class ReviewHelper {
  static final ReviewHelper _instance = ReviewHelper.internal();
  factory ReviewHelper() => _instance;
  final _supabase = Supabase.instance.client;

  ReviewHelper.internal();

  Future<List<Review>> loadReviewList() async {
    final response = await _supabase.from('reviews').select();
    return response.map((e) => Review.fromJson(e)).toList();
  }

  Future<Review?> loadReview(Uuid uuid) async {
    final response = await _supabase.from('reviews').select().eq('uuid', uuid.toString());
    return response.map((e) => Review.fromJson(e)).firstOrNull;
  }

  Future<void> saveReview(Review review) async {
    await _supabase.from('reviews').upsert(review.toJson());
  }

  Future<double> loadAverageRating(Uuid storeUuid) async {
    var reviewUuids = await StoreHelper().loadStore(storeUuid).then((store) => store?.reviewList);
    if (reviewUuids == null) {
      return 0;
    }
    var storeReviews = reviewUuids.map((reviewUuid) => loadReview(reviewUuid)).toList();
    var ratings = storeReviews.map((review) => review.then((r) => r?.rating)).toList();
    var totalRating = 0.0;
    for (var rating in ratings) {
      totalRating += await rating ?? 0;
    }
    return totalRating / storeReviews.length / 2;
  }
}