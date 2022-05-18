String userTable = 'user';

class UserFields {
  static String id = '_id';
  static String name = 'name';
  static String gender = 'gender';
  static String image = 'image';
}

class User {
  int? id;
  String? name;
  String? gender;
  String? image;
  User({this.id, this.name, this.gender, this.image});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map[UserFields.id] as int,
        name: map[UserFields.name] as String?,
        image: map[UserFields.image] as String?,
        gender: map[UserFields.gender] as String?);
  }

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.gender: gender,
        UserFields.image: image
      };
}
