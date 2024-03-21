class Ward {
  String id;
  String name;
  String level;
  String districtId;
  String provinceId;

  Ward({required this.id, required this.name, required this.level, required this.districtId, required this.provinceId});

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: map['id'],
      name: map['name'],
      level: map['level'],
      districtId: map['districtId'],
      provinceId: map['provinceId'],
    );
  }
}
