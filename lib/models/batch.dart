class Batch {
  String id, name, status, description;
  double price;
  int startingDate;
  int timeStamp;

  static Batch empty() {
    return Batch(
      id: '',
      name: '',
      status: '',
      timeStamp: 0,
      description: '',
      price: 0,
      startingDate: 0
    );
  }

//<editor-fold desc="Data Methods">
  Batch({
    required this.id,
    required this.name,
    required this.status,
    required this.description,
    required this.price,
    required this.startingDate,
    required this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batch &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          status == other.status &&
          description == other.description &&
          price == other.price &&
          startingDate == other.startingDate &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      description.hashCode ^
      price.hashCode ^
      startingDate.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'Batch{' +
        ' id: $id,' +
        ' name: $name,' +
        ' status: $status,' +
        ' description: $description,' +
        ' price: $price,' +
        ' startingDate: $startingDate,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  Batch copyWith({
    String? id,
    String? name,
    String? status,
    String? description,
    double? price,
    int? startingDate,
    int? timeStamp,
  }) {
    return Batch(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      price: price ?? this.price,
      startingDate: startingDate ?? this.startingDate,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'status': this.status,
      'description': this.description,
      'price': this.price,
      'startingDate': this.startingDate,
      'timeStamp': this.timeStamp,
    };
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(), // Convert to double
      startingDate: map['startingDate'] as int,
      timeStamp: map['timeStamp'] as int,
    );
  }

//</editor-fold>
}

class Student {
  String id,
      name,
      image,
      email,
      phoneNumber,
      cnicNumber,
      country,
      city,
      province,
      notificationToken,
      feeStatus;
  bool blocked;
  int timeStamp;

//<editor-fold desc="Data Methods">
  Student({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.phoneNumber,
    required this.cnicNumber,
    required this.country,
    required this.city,
    required this.province,
    required this.notificationToken,
    required this.feeStatus,
    required this.blocked,
    required this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          cnicNumber == other.cnicNumber &&
          country == other.country &&
          city == other.city &&
          province == other.province &&
          notificationToken == other.notificationToken &&
          feeStatus == other.feeStatus &&
          blocked == other.blocked &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      cnicNumber.hashCode ^
      country.hashCode ^
      city.hashCode ^
      province.hashCode ^
      notificationToken.hashCode ^
      feeStatus.hashCode ^
      blocked.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'Student{' +
        ' id: $id,' +
        ' name: $name,' +
        ' image: $image,' +
        ' email: $email,' +
        ' phoneNumber: $phoneNumber,' +
        ' cnicNumber: $cnicNumber,' +
        ' country: $country,' +
        ' city: $city,' +
        ' province: $province,' +
        ' notificationToken: $notificationToken,' +
        ' feeStatus: $feeStatus,' +
        ' blocked: $blocked,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  Student copyWith({
    String? id,
    String? name,
    String? image,
    String? email,
    String? phoneNumber,
    String? cnicNumber,
    String? country,
    String? city,
    String? province,
    String? notificationToken,
    String? feeStatus,
    bool? blocked,
    int? timeStamp,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cnicNumber: cnicNumber ?? this.cnicNumber,
      country: country ?? this.country,
      city: city ?? this.city,
      province: province ?? this.province,
      notificationToken: notificationToken ?? this.notificationToken,
      feeStatus: feeStatus ?? this.feeStatus,
      blocked: blocked ?? this.blocked,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'cnicNumber': this.cnicNumber,
      'country': this.country,
      'city': this.city,
      'province': this.province,
      'notificationToken': this.notificationToken,
      'feeStatus': this.feeStatus,
      'blocked': this.blocked,
      'timeStamp': this.timeStamp,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      cnicNumber: map['cnicNumber'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      province: map['province'] as String,
      notificationToken: map['notificationToken'] as String,
      feeStatus: map['feeStatus'] as String,
      blocked: map['blocked'] as bool,
      timeStamp: map['timeStamp'] as int,
    );
  }

//</editor-fold>
}
