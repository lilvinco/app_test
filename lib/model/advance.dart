import 'package:igroove_fan_box_one/model/advance_details.dart';

class Advance {
  String? contractID;
  String? contributorName;
  String? contractNumber;
  String? contractDuration;
  String? dateContract;
  String? advanceAmount;
  String? totalCredit;
  String? currency;
  String? status;
  StatusText? statusText;
  String? remainingRepayment;
  String? attachment;
  String? repaidPercentage;
  String? totalDebit;
  bool? isLive;
  List<String>? covers;
  AdvanceDetails? details;

  Advance({
    this.contributorName,
    this.contractNumber,
    this.contractDuration,
    this.dateContract,
    this.advanceAmount,
    this.totalCredit,
    this.status,
    this.statusText,
    this.attachment,
    this.isLive,
    this.repaidPercentage,
    this.remainingRepayment,
    this.totalDebit,
    this.currency,
    this.covers,
    this.details,
  });

  Advance.fromJson(Map<String, dynamic> json) {
    contributorName = json['contributor_name'];
    contractNumber = json['contract_number'];
    contractDuration = json['contract_duration'];
    contractID = json['idContract'];
    dateContract = json['date_contract'];
    currency = json['currency'];
    advanceAmount = json['advance_amount'];
    totalCredit = json['total_credit'];
    totalDebit = json['total_debit'];
    repaidPercentage = json['repaid_percentage'];
    remainingRepayment = json['remaining_repayment'];
    status = json['status'];
    statusText = json['status_text'] != null
        ? StatusText.fromJson(json['status_text'])
        : null;
    covers = json['covers'].cast<String>();
    attachment = json['attachment'];
    isLive = _getIsLive(statusNumber: json['status']);
  }

  _getIsLive({String? statusNumber}) {
    if (statusNumber == "4" || statusNumber == '3') {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contributor_name'] = contributorName;
    data['contract_number'] = contractNumber;
    data['contract_duration'] = contractDuration;
    data['currency'] = currency;
    data['date_contract'] = dateContract;
    data['idContract'] = contractID;
    data['advance_amount'] = advanceAmount;
    data['total_credit'] = totalCredit;
    data['total_debit'] = totalDebit;
    data['repaid_percentage'] = repaidPercentage;
    data['status'] = status;
    if (statusText != null) {
      data['status_text'] = statusText!.toJson();
    }
    data['attachment'] = attachment;
    data['covers'] = covers;
    return data;
  }
}

class StatusText {
  String? label;
  String? classAdmin;
  String? statusClass;

  StatusText({this.label, this.classAdmin, this.statusClass});

  StatusText.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    classAdmin = json['class-admin'];
    statusClass = json['class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['class-admin'] = classAdmin;
    data['class'] = statusClass;
    return data;
  }
}
