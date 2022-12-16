class AddressModel {
  final String id;
  final String phoneNumber;
  final String area;
  final String pincode;
  final String house;
  final String town;
  final String landMark;
  final String name;
  final String userId;
  final String? state;

  AddressModel({
    required this.id,
    required this.area,
    required this.state,
    required this.house,
    required this.landMark,
    required this.name,
    required this.phoneNumber,
    required this.pincode,
    required this.town,
    required this.userId,
  });

  factory AddressModel.fromMap(
    Map<String, dynamic> map, {
    required String? id,
  }) {
    return AddressModel(
      id: id ?? map[AddressModelKey.id],
      area: map[AddressModelKey.area],
      house: map[AddressModelKey.house],
      state: map[AddressModelKey.state],
      landMark: map[AddressModelKey.landMark],
      name: map[AddressModelKey.name],
      phoneNumber: map[AddressModelKey.phoneNumber],
      pincode: map[AddressModelKey.pincode],
      town: map[AddressModelKey.town],
      userId: map[AddressModelKey.userId],
    );
  }

  String shortReadable() {
    return '$name - $house';
  }

  String fullReadable() {
    return '$name - $house\n$area $landMark\n$state -  $pincode';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'area': area,
      'pin_code': pincode,
      'house': house,
      'town': town,
      'land_mark': landMark,
      'name': name,
      'user_id': userId,
      'state': state,
    };
  }
}

class AddressModelKey {
  static const id = 'id';
  static const userId = 'user_id';
  static const area = 'area';
  static const house = 'house';
  static const state = 'state';
  static const landMark = 'land_mark';
  static const name = 'full_name';
  static const phoneNumber = 'phone_number';
  static const pincode = 'pin_code';
  static const town = 'town';
}
