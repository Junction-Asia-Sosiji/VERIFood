import 'package:uuid/uuid.dart';

class Zone {
  final Uuid uuid;
  final String name;
  final Set<Uuid> stores;

  const Zone({required this.uuid, required this.name, required this.stores});

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid.toString(),
      'name': name,
      'stores': stores.map((store) => store.toString()).toList(),
    };
  }

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      uuid: Uuid.parse(json['uuid']) as Uuid,
      name: json['name'],
      stores: json['stores'].map((store) => Uuid.parse(store)).toSet(),
    );
  }
}