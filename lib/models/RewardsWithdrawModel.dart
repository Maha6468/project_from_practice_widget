
class Rewardswithdrawmodel {
  List<History>? result;

  Rewardswithdrawmodel({
    this.result,
  });

  Rewardswithdrawmodel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      final v = json['result'];
      final arr0 = <History>[];
      v.forEach((v) {
        arr0.add(History.fromJson(v));
      });
      result = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (result != null) {
      final v = result;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['result'] = arr0;
    }
    return data;
  }
}

class History {
  String? id;
  String? wallet;
  String? type;
  String? status;
  double? amount;
  String? transaction;
  double? finalAmount;
  int? createAt;
  int? updateAt;
  String? notes;

  History({
    this.id,
    this.wallet,
    this.type,
    this.status,
    this.amount,
    this.transaction,
    this.finalAmount,
    this.createAt,
    this.updateAt,
    this.notes,
  });
  History.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    wallet = json['wallet']?.toString();
    type = json['type']?.toString();
    status = json['status']?.toString();
    amount = json['amount']?.toDouble();
    transaction = json['transaction']?.toString();
    finalAmount = json['finalAmount']?.toDouble();
    createAt = json['createAt']?.toInt();
    updateAt = json['updateAt']?.toInt();
    notes = json['notes']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['wallet'] = wallet;
    data['type'] = type;
    data['status'] = status;
    data['amount'] = amount;
    data['transaction'] = transaction;
    data['finalAmount'] = finalAmount;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['notes'] = notes;
    return data;
  }
}