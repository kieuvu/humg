import 'package:info_selection/models/district.dart';
import 'package:info_selection/models/province.dart';
import 'package:info_selection/models/ward.dart';

class AddressInfo {
  Province? province;
  District? district;
  Ward? ward;
  String? street;

  AddressInfo({this.province, this.district, this.ward, this.street});

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      province: map['province'] != null ? Province.fromMap(map['province']) : null,
      district: map['district'] != null ? District.fromMap(map['district']) : null,
      ward: map['ward'] != null ? Ward.fromMap(map['ward']) : null,
      street: map['street'],
    );
  }
}
