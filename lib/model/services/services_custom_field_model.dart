class ServicesCustomFieldModel {
  int? status;
  List<Payload>? payload;

  ServicesCustomFieldModel({this.status, this.payload});

  ServicesCustomFieldModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? type;
  String? content;
  String? name;
  String? subtype;
  bool? required;
  String? label;
  String? addButtonLabel;
  int? maxLength;
  String? helper;
  List<Options>? options;
  List<Payload>? fields;
  String? text;
  Validations? validations;

  Payload(
      {this.type,
      this.content,
      this.name,
      this.subtype,
      this.required,
      this.label,
      this.helper,
      this.fields,
      this.addButtonLabel,
      this.maxLength,
      this.options,
      this.validations,
      this.text});

  Payload.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    name = json['name'];
    subtype = json['subtype'];
    required = json['required'];
    label = json['label'];
    helper = json['helper'];
    addButtonLabel = json['add_button_label'];
    if (json['fields'] != null) {
      fields = <Payload>[];
      json['fields'].forEach((v) {
        fields!.add(Payload.fromJson(v));
      });
    }
    maxLength = json['max_length'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    validations = json['validations'] != null
        ? Validations.fromJson(json['validations'])
        : null;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['content'] = content;
    data['name'] = name;
    data['subtype'] = subtype;
    data['required'] = required;
    data['max_length'] = maxLength;
    data['add_button_label'] = addButtonLabel;
    data['label'] = label;
    data['helper'] = helper;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['text'] = text;
    return data;
  }
}

class Options {
  String? value;
  String? text;

  Options({this.value, this.text});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}

class Validations {
  DateBetween? dateBetween;

  Validations({this.dateBetween});

  Validations.fromJson(Map<String, dynamic> json) {
    dateBetween = json['date_between'] != null
        ? DateBetween.fromJson(json['date_between'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dateBetween != null) {
      data['date_between'] = dateBetween!.toJson();
    }
    return data;
  }
}

class DateBetween {
  String? error;
  int? datePreorder;
  int? dateRelease;

  DateBetween({this.error, this.datePreorder, this.dateRelease});

  DateBetween.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    datePreorder = json['date_preorder'];
    dateRelease = json['date_release'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['date_preorder'] = datePreorder;
    data['date_release'] = dateRelease;
    return data;
  }
}
