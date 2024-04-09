class UserData {
  final int? id;
  final String name;
  final int age;
  final String gender;
  final String city;
  final String address;

  UserData({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'name': name,
      'age': age,
      'gender': gender,
      'city': city,
      'address': address,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      city: map['city'],
      address: map['address'],
    );
  }
}
