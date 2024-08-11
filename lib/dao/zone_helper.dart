import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/model/zone.dart';

class ZoneHelper {
  static final ZoneHelper _instance = ZoneHelper.internal();
  factory ZoneHelper() => _instance;
  final _supabase = Supabase.instance.client;

  ZoneHelper.internal();

  Future<List<Zone>> loadZoneList() async {
    final response = await _supabase.from('zones').select();
    return response.map((e) => Zone.fromJson(e)).toList();
  }

  Future<Zone?> loadZone(String uuid) async {
    final response = await _supabase.from('zones').select().eq('uuid', uuid);
    return response.map((e) => Zone.fromJson(e)).firstOrNull;
  }

  Future<void> saveZone(Zone zone) async {
    await _supabase.from('zones').upsert(zone.toJson());
  }
}