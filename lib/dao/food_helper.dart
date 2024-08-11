import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/model/food.dart';

class FoodHelper {
  static final FoodHelper _instance = FoodHelper.internal();
  factory FoodHelper() => _instance;
  final _supabase = Supabase.instance.client;
  FoodHelper.internal();

  Future<List<Food>> loadFoodList() async {
    final response = await _supabase.from('foods').select();
    return response.map((e) => Food.fromJson(e)).toList();
  }

  Future<Food?> loadFood(Uuid uuid) async {
    final response = await _supabase.from('foods').select().eq('uuid', uuid.toString());
    return response.map((e) => Food.fromJson(e)).firstOrNull;
  }

  Future<void> saveFood(Food food) async {
    await _supabase.from('foods').upsert(food.toJson());
  }
}