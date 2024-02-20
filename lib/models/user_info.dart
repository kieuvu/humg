import 'package:class_builder/models/address_info.dart';

class UserInfo {
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? birthDate;
  AddressInfo? address;

  UserInfo({this.name, this.email, this.phoneNumber, this.birthDate, this.address});

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      birthDate: map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      address: map['address'] != null ? AddressInfo.fromMap(map['address']) : null,
    );
  }
}
