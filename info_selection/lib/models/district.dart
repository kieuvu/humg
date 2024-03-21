class District {
  String id;
  String name;
  String level;
  String provinceId;

  District({required this.id, required this.name, required this.level, required this.provinceId});

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'],
      name: map['name'],
      level: map['level'],
      provinceId: map['provinceId'],
    );
  }
}
