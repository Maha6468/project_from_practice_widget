class WithdrawSetupModel {
  int? maxWithdrawLimit;
  bool? isButtonVisible;
  int? minWithdrawLimit;
  int? withDrawFeeInShib;

  WithdrawSetupModel({
    this.maxWithdrawLimit,
    this.isButtonVisible,
    this.minWithdrawLimit,
    this.withDrawFeeInShib,
  });
  WithdrawSetupModel.fromJson(Map<String, dynamic> json) {
    maxWithdrawLimit = json['maxWithdrawLimit']?.toInt();
    isButtonVisible = json['isButtonVisible'];
    minWithdrawLimit = json['minWithdrawLimit']?.toInt();
    withDrawFeeInShib = json['withDrawFeeInShib']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['maxWithdrawLimit'] = maxWithdrawLimit;
    data['isButtonVisible'] = isButtonVisible;
    data['minWithdrawLimit'] = minWithdrawLimit;
    data['withDrawFeeInShib'] = withDrawFeeInShib;
    return data;
  }
}