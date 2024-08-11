import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Zone {
  final String uuid;
  final String name;
  final Set<dynamic> stores;

  const Zone({required this.uuid, required this.name, required this.stores});

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid.toString(),
      'name': name,
      'store_list': stores.toList(),
    };
  }

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      uuid: json['uuid'],
      name: json['name'],
      stores: json['store_list'].values.map((e) => e as String).toSet(),
    );
  }
}