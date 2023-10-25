class Payment{
  String id,user_id,batch_id;
  double amount;
  Map paymentInfo;

//<editor-fold desc="Data Methods">
  Payment({
    required this.id,
    required this.user_id,
    required this.batch_id,
    required this.amount,
    required this.paymentInfo,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          user_id == other.user_id &&
          batch_id == other.batch_id &&
          amount == other.amount &&
          paymentInfo == other.paymentInfo);

  @override
  int get hashCode =>
      id.hashCode ^
      user_id.hashCode ^
      batch_id.hashCode ^
      amount.hashCode ^
      paymentInfo.hashCode;

  @override
  String toString() {
    return 'Payment{' +
        ' id: $id,' +
        ' user_id: $user_id,' +
        ' batch_id: $batch_id,' +
        ' amount: $amount,' +
        ' paymentInfo: $paymentInfo,' +
        '}';
  }

  Payment copyWith({
    String? id,
    String? user_id,
    String? batch_id,
    double? amount,
    Map? paymentInfo,
  }) {
    return Payment(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      batch_id: batch_id ?? this.batch_id,
      amount: amount ?? this.amount,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'user_id': this.user_id,
      'batch_id': this.batch_id,
      'amount': this.amount,
      'paymentInfo': this.paymentInfo,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      batch_id: map['batch_id'] as String,
      amount: map['amount'] as double,
      paymentInfo: map['paymentInfo'] as Map,
    );
  }

//</editor-fold>
}