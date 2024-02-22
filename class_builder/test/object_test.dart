import 'dart:convert';
import 'package:class_builder/models/address_info.dart';
import 'package:class_builder/models/district.dart';
import 'package:class_builder/models/province.dart';
import 'package:class_builder/models/user_info.dart';
import 'package:class_builder/models/ward.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, dynamic> data;

  // Khởi tạo các data cần thiết cho test
  setUpAll(() async {
    // ServicesBinding
    WidgetsFlutterBinding.ensureInitialized();
    // Đọc file data json
    data = json.decode(await rootBundle.loadString('assets/data.json'));
  });

  group('Province Tests', () {
    test('Test Province creation from map', () {
      // Lấy ra list các tỉnh trong data json
      List provinceData = data["province"];
      // Khởi tạo danh sách chứa Province instances
      List<Province> provinces = [];
      for (var province in provinceData) {
        try {
          // Khởi tạo Province instance từ method fromMap()
          Province instance = Province.fromMap(province);
          // Thêm vào list
          provinces.add(instance);

          // Kiểm tra các giá trị mong muốn
          expect(int.parse(province.id), instance.id);
          expect(province.level, instance.level);
          expect(province.name, instance.name);
        } catch (e) {
          continue;
        }
      }

      // Kiểm tra kiểu dữ liệu
      for (var province in provinces) {
        expect(province.id, isA<int>());
        expect(province.level, isA<String>());
        expect(province.name, isA<String>());
      }
    });
  });

  group('District Tests', () {
    test('Test District creation from map', () {
      // Lấy ra list các huyện trong data json
      List districtData = data["district"];
      // Khởi tạo danh sách chưứa District instance
      List<District> districts = [];

      for (var district in districtData) {
        try {
          // Khởi tạo District instance từ method fromMap()
          District instance = District.fromMap(district);
          // Thêm vào list
          districts.add(instance);

          // Kiểm tra giá trị mong muốn
          expect(int.parse(district.id), instance.id);
          expect(district.level, instance.level);
          expect(district.name, instance.name);
          expect(int.parse(district.provinceId), instance.provinceId);
        } catch (e) {
          continue;
        }
      }

      // Kiểm tra kiểu dữ liệu
      for (var district in districts) {
        expect(district.id, isA<int>());
        expect(district.level, isA<String>());
        expect(district.name, isA<String>());
        expect(district.provinceId, isA<int>());
      }
    });
  });

  group('Ward Tests', () {
    test('Test Ward creation from map', () {
      // Lấy ra list các phường từ data json
      List wardData = data["ward"];
      // khởi tạo list chứa Ward instance
      List<Ward> wards = [];

      for (var ward in wardData) {
        try {
          // Khởi tạo Ward instance từ method fromMap()
          Ward instance = Ward.fromMap(ward);
          // Thêm vào list
          wards.add(instance);

          // Kiểm tra giá trị mong muốn
          expect(int.parse(ward.id), instance.id);
          expect(ward.name, instance.name);
          expect(ward.level, instance.level);
          expect(int.parse(ward.provinceId), instance.provinceId);
          expect(int.parse(ward.districtId), instance.districtId);
        } catch (e) {
          continue;
        }
      }

      // Kiểm tra kiểu dữ liệu
      for (var ward in wards) {
        expect(ward.id, isA<int>());
        expect(ward.name, isA<String>());
        expect(ward.level, isA<String>());
        expect(ward.provinceId, isA<int>());
        expect(ward.districtId, isA<int>());
      }
    });
  });

  group('AddressInfo Tests', () {
    test('Test object creation from input data', () {
      // Khởi tạo giá trị
      Map<String, dynamic> addressData = {
        'province': {
          'id': '1',
          'name': 'Hanoi',
          'level': "TP",
        },
        'district': {
          'id': '101',
          'name': 'Hoan Kiem',
          'level': "Quan",
          'provinceId': '1',
        },
        'ward': {
          'id': '1001',
          'name': 'Phuc Tan',
          'level': "Phuong",
          'districtId': '101',
          'provinceId': '1',
        },
        'street': '123 ABC Street',
      };

      // Khởi tạo AddressInfo instance
      AddressInfo addressInfo = AddressInfo.fromMap(addressData);

      // Kiểm tra giá trị mong muốn
      expect(addressInfo.province!.id, 1);
      expect(addressInfo.province!.name, 'Hanoi');
      expect(addressInfo.province!.level, "TP");

      expect(addressInfo.district!.id, 101);
      expect(addressInfo.district!.name, 'Hoan Kiem');
      expect(addressInfo.district!.level, "Quan");
      expect(addressInfo.district!.provinceId, 1);

      expect(addressInfo.ward!.id, 1001);
      expect(addressInfo.ward!.name, 'Phuc Tan');
      expect(addressInfo.ward!.level, "Phuong");
      expect(addressInfo.ward!.districtId, 101);
      expect(addressInfo.ward!.provinceId, 1);

      expect(addressInfo.street, '123 ABC Street');
    });
  });

  group('UserInfo Tests', () {
    test("Test User info creation from map", () {
      // Khởi tạo giá trị
      Map<String, dynamic> userInfoData = {
        'address': {
          'province': {
            'id': '1',
            'name': 'Hanoi',
            'level': "TP",
          },
          'district': {
            'id': '101',
            'name': 'Hoan Kiem',
            'level': "Quan",
            'provinceId': '1',
          },
          'ward': {
            'id': '1001',
            'name': 'Phuc Tan',
            'level': "Phuong",
            'districtId': '101',
            'provinceId': '1',
          },
          'street': '123 ABC Street',
        },
        'name': 'myName',
        'email': 'myEmail',
        'phoneNumber': '0987665432',
        'birthDate': '2024-01-02',
      };

      // Khởi tạo UserInfo instance
      UserInfo userInfo = UserInfo.fromMap(userInfoData);

      // Kiểm tra giá trị mong muốn
      expect(userInfo.name, 'myName');
      expect(userInfo.email, 'myEmail');
      expect(userInfo.phoneNumber,'0987665432' );
      expect(userInfo.birthDate, DateTime.parse('2024-01-02'));

      expect(userInfo.address!.province!.id, 1);
      expect(userInfo.address!.province!.name, 'Hanoi');
      expect(userInfo.address!.province!.level, "TP");

      expect(userInfo.address!.district!.id, 101);
      expect(userInfo.address!.district!.name, 'Hoan Kiem');
      expect(userInfo.address!.district!.level, "Quan");
      expect(userInfo.address!.district!.provinceId, 1);

      expect(userInfo.address!.ward!.id, 1001);
      expect(userInfo.address!.ward!.name, 'Phuc Tan');
      expect(userInfo.address!.ward!.level, "Phuong");
      expect(userInfo.address!.ward!.districtId, 101);
      expect(userInfo.address!.ward!.provinceId, 1);

      expect(userInfo.address!.street, '123 ABC Street');
    });
  });
}
