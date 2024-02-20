class District {
  int id;
  String name;
  String level;
  int provinceId;

  District({required this.id, required this.name, required this.level, required this.provinceId});

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'],
      provinceId: int.parse(map['provinceId']),
      name: map['name'],
      level: map['level'],
    );
  }
}

