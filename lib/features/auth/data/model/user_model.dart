class UserModel {
  String? uid;
  String? email;
  bool? is_active;

  UserModel({
    required this.uid,
    required this.email,
    required this.is_active,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    is_active = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['is_active'] = is_active;
    data['uid'] = uid;
    return data;
  }
}
