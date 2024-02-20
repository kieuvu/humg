class Ward {
  int id;
  String name;
  int level;
  int districtId;
  int provinceId;

  Ward({required this.id, required this.name, required this.level, required this.districtId, required this.provinceId});

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: int.parse(map['id']),
      districtId: int.parse(map['districtId']),
      provinceId: int.parse(map['provinceId']),
      name: map['name'],
      level: map['level'],
    );
  }
}
