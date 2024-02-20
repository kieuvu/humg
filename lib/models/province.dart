class Province {
  int id;
  String name;
  String level;

  Province({required this.id, required this.name, required this.level});

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: int.parse(map['id']),
      name: map['name'],
      level: map['level'],
    );
  }
}
