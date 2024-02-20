class Ward {
  int id;
  String name;
  String level;
  int districtId;
  int provinceId;

  Ward({required this.id, required this.name, required this.level, required this.districtId, required this.provinceId});

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: int.parse(map['id']),
      name: map['name'],
      level: map['level'],
      districtId: int.parse(map['districtId']),
      provinceId: int.parse(map['provinceId']),
    );
  }
}
