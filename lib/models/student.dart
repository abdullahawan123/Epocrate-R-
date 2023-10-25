class Student{
  String id,batchId,feeStatus;
  Map<String,dynamic> grades;
  int timeStamp;

//<editor-fold desc="Data Methods">
  Student({
    required this.id,
    required this.batchId,
    required this.feeStatus,
    required this.grades,
    required this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          batchId == other.batchId &&
          feeStatus == other.feeStatus &&
          grades == other.grades &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      id.hashCode ^
      batchId.hashCode ^
      feeStatus.hashCode ^
      grades.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'Student{' +
        ' id: $id,' +
        ' batchId: $batchId,' +
        ' feeStatus: $feeStatus,' +
        ' grades: $grades,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  Student copyWith({
    String? id,
    String? batchId,
    String? feeStatus,
    Map<String, dynamic>? grades,
    int? timeStamp,
  }) {
    return Student(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      feeStatus: feeStatus ?? this.feeStatus,
      grades: grades ?? this.grades,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'batchId': this.batchId,
      'feeStatus': this.feeStatus,
      'grades': this.grades,
      'timeStamp': this.timeStamp,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      batchId: map['batchId'] as String,
      feeStatus: map['feeStatus'] as String,
      grades: map['grades'] as Map<String, dynamic>,
      timeStamp: map['timeStamp'] as int,
    );
  }

//</editor-fold>
}


class FeeStatus{
  String status,month;

//<editor-fold desc="Data Methods">
  FeeStatus({
    required this.status,
    required this.month,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeStatus &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          month == other.month);

  @override
  int get hashCode => status.hashCode ^ month.hashCode;

  @override
  String toString() {
    return 'FeeStatus{' + ' status: $status,' + ' month: $month,' + '}';
  }

  FeeStatus copyWith({
    String? status,
    String? month,
  }) {
    return FeeStatus(
      status: status ?? this.status,
      month: month ?? this.month,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'month': this.month,
    };
  }

  factory FeeStatus.fromMap(Map<String, dynamic> map) {
    return FeeStatus(
      status: map['status'] as String,
      month: map['month'] as String,
    );
  }

//</editor-fold>
}