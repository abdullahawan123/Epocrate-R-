class User{

  String id,name,userName,email,phone,password,gender,notificationToken,image,type,documents;
  int timeStamp,dob;
  bool blocked;

//<editor-fold desc="Data Methods">
  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    required this.gender,
    required this.notificationToken,
    required this.image,
    required this.type,
    required this.documents,
    required this.timeStamp,
    required this.dob,
    required this.blocked,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          userName == other.userName &&
          email == other.email &&
          phone == other.phone &&
          password == other.password &&
          gender == other.gender &&
          notificationToken == other.notificationToken &&
          image == other.image &&
          type == other.type &&
          documents == other.documents &&
          timeStamp == other.timeStamp &&
          dob == other.dob &&
          blocked == other.blocked);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      gender.hashCode ^
      notificationToken.hashCode ^
      image.hashCode ^
      type.hashCode ^
      documents.hashCode ^
      timeStamp.hashCode ^
      dob.hashCode ^
      blocked.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' name: $name,' +
        ' userName: $userName,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' password: $password,' +
        ' gender: $gender,' +
        ' notificationToken: $notificationToken,' +
        ' image: $image,' +
        ' type: $type,' +
        ' documents: $documents,' +
        ' timeStamp: $timeStamp,' +
        ' dob: $dob,' +
        ' blocked: $blocked,' +
        '}';
  }

  User copyWith({
    String? id,
    String? name,
    String? userName,
    String? email,
    String? phone,
    String? password,
    String? gender,
    String? notificationToken,
    String? image,
    String? type,
    String? documents,
    int? timeStamp,
    int? dob,
    bool? blocked,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      notificationToken: notificationToken ?? this.notificationToken,
      image: image ?? this.image,
      type: type ?? this.type,
      documents: documents ?? this.documents,
      timeStamp: timeStamp ?? this.timeStamp,
      dob: dob ?? this.dob,
      blocked: blocked ?? this.blocked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'userName': this.userName,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
      'gender': this.gender,
      'notificationToken': this.notificationToken,
      'image': this.image,
      'type': this.type,
      'documents': this.documents,
      'timeStamp': this.timeStamp,
      'dob': this.dob,
      'blocked': this.blocked,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      notificationToken: map['notificationToken'] as String,
      image: map['image'] as String,
      type: map['type'] as String,
      documents: map['documents'] as String,
      timeStamp: map['timeStamp'] as int,
      dob: map['dob'] as int,
      blocked: map['blocked'] as bool,
    );
  }

//</editor-fold>
}