class ReleaseValidationModel {
  int? status;
  UserSettings? userSettings;
  Helpers? helpers;
  List<Validations>? validations;

  ReleaseValidationModel(
      {this.status, this.userSettings, this.helpers, this.validations});

  ReleaseValidationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userSettings = json['userSettings'] != null
        ? UserSettings.fromJson(json['userSettings'])
        : null;
    helpers =
        json['helpers'] != null ? Helpers.fromJson(json['helpers']) : null;
    if (json['validations'] != null) {
      validations = <Validations>[];
      json['validations'].forEach((v) {
        validations!.add(Validations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userSettings != null) {
      data['userSettings'] = userSettings!.toJson();
    }
    if (helpers != null) {
      data['helpers'] = helpers!.toJson();
    }
    if (validations != null) {
      data['validations'] =
          validations!.map((Validations v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserSettings {
  int? skipSyntaxCheck;
  int? allowNicknameComposerLyricist;
  int? allowTrackWithoutLyrist;
  int? andCharEnabled;
  int? removeArtistNameValidationOnAlbumLevel;

  UserSettings(
      {this.skipSyntaxCheck,
      this.allowNicknameComposerLyricist,
      this.allowTrackWithoutLyrist,
      this.removeArtistNameValidationOnAlbumLevel,
      this.andCharEnabled});

  UserSettings.fromJson(Map<String, dynamic> json) {
    skipSyntaxCheck = json['skipSyntaxCheck'];
    allowNicknameComposerLyricist = json['allowNicknameComposerLyricist'];
    allowTrackWithoutLyrist = json['allowTrackWithoutLyrist'];
    removeArtistNameValidationOnAlbumLevel =
        json['removeArtistNameValidationOnAlbumLevel'];
    andCharEnabled = json['andCharEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skipSyntaxCheck'] = skipSyntaxCheck;
    data['allowNicknameComposerLyricist'] = allowNicknameComposerLyricist;
    data['allowTrackWithoutLyrist'] = allowTrackWithoutLyrist;
    data['removeArtistNameValidationOnAlbumLevel'] =
        removeArtistNameValidationOnAlbumLevel;
    data['andCharEnabled'] = andCharEnabled;
    return data;
  }
}

class Helpers {
  String? isRomanNumberRegex;
  List<String>? allowedLowerNames;
  String? validRealNameErrorMessage;
  String? validLetterCaseErrorMessage;
  Spotify? spotify;
  Spotify? apple;
  String? validPattern;
  String? errorClassicalGenre;

  Helpers(
      {this.isRomanNumberRegex,
      this.allowedLowerNames,
      this.validRealNameErrorMessage,
      this.validLetterCaseErrorMessage,
      this.spotify,
      this.apple,
      this.validPattern,
      this.errorClassicalGenre});

  Helpers.fromJson(Map<String, dynamic> json) {
    isRomanNumberRegex = json['isRomanNumberRegex'];
    allowedLowerNames = json['allowedLowerNames'].cast<String>();
    validRealNameErrorMessage = json['validRealNameErrorMessage'];
    validLetterCaseErrorMessage = json['validLetterCaseErrorMessage'];
    spotify =
        json['spotify'] != null ? Spotify.fromJson(json['spotify']) : null;
    apple = json['apple'] != null ? Spotify.fromJson(json['apple']) : null;
    validPattern = json['validPattern'];
    errorClassicalGenre = json['errorClassicalGenre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isRomanNumberRegex'] = isRomanNumberRegex;
    data['allowedLowerNames'] = allowedLowerNames;
    data['validRealNameErrorMessage'] = validRealNameErrorMessage;
    data['validLetterCaseErrorMessage'] = validLetterCaseErrorMessage;
    if (spotify != null) {
      data['spotify'] = spotify!.toJson();
    }
    if (apple != null) {
      data['apple'] = apple!.toJson();
    }
    data['validPattern'] = validPattern;
    data['errorClassicalGenre'] = errorClassicalGenre;
    return data;
  }
}

class Spotify {
  String? id;
  String? url;

  Spotify({this.id, this.url});

  Spotify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Validations {
  List<String>? fields;
  bool? required;
  List<String>? exclude;
  List<String>? regexMatch;
  List<String>? regexNotMatch;
  String? messageExclude;
  String? messageRegex;

  Validations(
      {this.fields,
      this.required,
      this.exclude,
      this.regexMatch,
      this.regexNotMatch,
      this.messageExclude,
      this.messageRegex});

  Validations.fromJson(Map<String, dynamic> json) {
    fields = json['fields'].cast<String>();
    required = json['required'];
    exclude = json['exclude'].cast<String>();
    regexMatch = json['regexMatch'].cast<String>();
    regexNotMatch = json['regexNotMatch'].cast<String>();
    messageExclude = json['messageExclude'];
    messageRegex = json['messageRegex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fields'] = fields;
    data['required'] = required;
    data['exclude'] = exclude;
    data['regexMatch'] = regexMatch;
    data['regexNotMatch'] = regexNotMatch;
    data['messageExclude'] = messageExclude;
    data['messageRegex'] = messageRegex;
    return data;
  }
}
