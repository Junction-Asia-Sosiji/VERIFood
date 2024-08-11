import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/model/store.dart';

class StoreHelper {
  static final StoreHelper _instance = StoreHelper._internal();
  factory StoreHelper() => _instance;
  final _supabase = Supabase.instance.client;

  StoreHelper._internal();

  Future<List<Store>> loadStoreList() async {
    final response = await _supabase.from('stores').select();
    return response.map((e) => Store.fromJson(e)).toList();
  }

  Future<Store?> loadStore(Uuid uuid) async {
    final response = await _supabase.from('stores').select().eq('uuid', uuid.toString());
    return response.map((e) => Store.fromJson(e)).firstOrNull;
  }

  Future<void> saveStore(Store store) async {
    await _supabase.from('stores').upsert(store.toJson());
  }
}