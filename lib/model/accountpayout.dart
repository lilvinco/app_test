class AccountPayOut {
  int? status;
  int? deniedPayout;
  List<Balances>? balances;
  LastPayoutDetails? lastPayoutDetails;

  AccountPayOut(
      {this.status, this.deniedPayout, this.balances, this.lastPayoutDetails});

  AccountPayOut.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    deniedPayout = json['deniedPayout'];
    if (json['balances'] != null) {
      balances = <Balances>[];
      json['balances'].forEach((v) {
        balances!.add(Balances.fromJson(v));
      });
    }
    lastPayoutDetails = json['last_payout_details'] != null
        ? LastPayoutDetails.fromJson(json['last_payout_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['deniedPayout'] = deniedPayout;
    if (balances != null) {
      data['balances'] = balances!.map((Balances v) => v.toJson()).toList();
    }
    if (lastPayoutDetails != null) {
      data['last_payout_details'] = lastPayoutDetails!.toJson();
    }
    return data;
  }
}

class Balances {
  String? id;
  String? idUser;
  String? dateModified;
  String? currency;
  String? balance;
  String? primaryBalance;
  String? historyEntries;

  Balances(
      {this.id,
      this.idUser,
      this.dateModified,
      this.currency,
      this.balance,
      this.primaryBalance,
      this.historyEntries});

  Balances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    dateModified = json['date_modified'];
    currency = json['currency'];
    balance =
        _getRoundedNumberAsTwoSymbolsAfterDot(numberInString: json['balance']);
    primaryBalance = json['primary_balance'];
    historyEntries = json['history_entries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['date_modified'] = dateModified;
    data['currency'] = currency;
    data['balance'] = balance;
    data['primary_balance'] = primaryBalance;
    data['history_entries'] = historyEntries;
    return data;
  }

  String? _getRoundedNumberAsTwoSymbolsAfterDot({String? numberInString}) {
    String? result;
    if (numberInString != null) {
      double? number = double.tryParse(numberInString);
      if (number != null) {
        result = number.toStringAsFixed(2);
      } else {
        // print("Invalid double format");
        result = null;
      }
    } else {
      // print("Please enter number");
      result = null;
    }

    return result;
  }
}

class LastPayoutDetails {
  String? id;
  String? idUser;
  String? idBalance;
  String? dateRequested;
  String? dateModified;
  String? method;
  String? accountHolderName;
  String? iban;
  String? swift;
  String? bankName;
  String? clearing;
  String? streetNumber;
  String? postalCode;
  String? city;
  String? country;
  String? paypalEmail;
  String? amount;
  String? fee;
  String? amountWithFee;
  String? status;
  String? email;
  String? confirmemail;
  String? usdRoutingNumber;
  String? usdAccountNumber;
  String? usdBankAddress;
  String? usdBankName;
  String? usdAccountName;
  String? usdAccountHolderAdress;

  LastPayoutDetails(
      {this.id,
      this.idUser,
      this.idBalance,
      this.fee,
      this.amountWithFee,
      this.dateRequested,
      this.dateModified,
      this.method,
      this.accountHolderName,
      this.iban,
      this.swift,
      this.bankName,
      this.clearing,
      this.streetNumber,
      this.postalCode,
      this.city,
      this.country,
      this.paypalEmail,
      this.amount,
      this.status,
      this.email,
      this.confirmemail,
      this.usdRoutingNumber,
      this.usdAccountNumber,
      this.usdBankAddress,
      this.usdBankName,
      this.usdAccountName,
      this.usdAccountHolderAdress});

  LastPayoutDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    idBalance = json['idBalance'];
    dateRequested = json['date_requested'];
    dateModified = json['date_modified'];
    method = json['method'];
    accountHolderName = json['account_holder_name'];
    iban = json['iban'];
    swift = json['swift'];
    bankName = json['bank_name'];
    clearing = json['clearing'];
    streetNumber = json['streetNumber'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    paypalEmail = json['paypalEmail'];
    amount = json['amount'];
    fee = json['fee'];
    amountWithFee = json['amount_with_fee'];
    status = json['status'];
    email = json['email'];
    confirmemail = json['confirmemail'];
    usdRoutingNumber = json['usd_routing_number'];
    usdAccountNumber = json['usd_account_number'];
    usdBankAddress = json['usd_bank_address'];
    usdBankName = json['usd_bank_name'];
    usdAccountName = json['usd_account_name'];
    usdAccountHolderAdress = json['usd_account_holder_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['idBalance'] = idBalance;
    data['date_requested'] = dateRequested;
    data['date_modified'] = dateModified;
    data['method'] = method;
    data['account_holder_name'] = accountHolderName;
    data['iban'] = iban;
    data['swift'] = swift;
    data['bank_name'] = bankName;
    data['clearing'] = clearing;
    data['streetNumber'] = streetNumber;
    data['postalCode'] = postalCode;
    data['city'] = city;
    data['country'] = country;
    data['paypalEmail'] = paypalEmail;
    data['amount'] = amount;
    data['fee'] = fee;
    data['amount_with_fee'] = amountWithFee;
    data['status'] = status;
    data['email'] = email;
    data['confirmemail'] = confirmemail;
    data['usd_routing_number'] = usdRoutingNumber;
    data['usd_account_number'] = usdAccountNumber;
    data['usd_bank_address'] = usdBankAddress;
    data['usd_bank_name'] = usdBankName;
    data['usd_account_name'] = usdAccountName;
    data['usd_account_holder_address'] = usdAccountHolderAdress;
    return data;
  }
}
