import 'dart:async';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/l10n/messages_all.dart';
import 'package:igroove_fan_box_one/localization/intl_server.dart';

class AppLocalizations {
  static late Locale currentLocal;

  static Future<AppLocalizations> load(Locale locale) {
    final String localeName = 'de';
    currentLocal = locale;

    return initializeMessages(localeName).then((bool _) {
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //Login Screen
  String? get loginButton => IntlServer.message("loginButton") ?? "loginButton";
  String? get loginSaveButton =>
      IntlServer.message("loginSaveButton") ?? "loginSaveButton";
  String? get loginForgetPasswordButton =>
      IntlServer.message("loginForgetPasswordButton") ??
      "loginForgetPasswordButton";
  String? get loginEmailFieldLabel =>
      IntlServer.message("loginEmailFieldLabel") ?? "loginEmailFieldLabel";
  String? get loginEmailFieldHint =>
      IntlServer.message("loginEmailFieldHint") ?? "loginEmailFieldHint";
  String? get loginEmailFieldValidationEmpty =>
      IntlServer.message("loginEmailFieldValidationEmpty") ??
      "loginEmailFieldValidationEmpty";
  String? get loginEmailFieldValidationRegex =>
      IntlServer.message("loginEmailFieldValidationRegex") ??
      "loginEmailFieldValidationRegex";
  String? get loginPasswordFieldLabel =>
      IntlServer.message("loginPasswordFieldLabel") ??
      "loginPasswordFieldLabel";
  String? get loginPasswordFieldHint =>
      IntlServer.message("loginPasswordFieldHint") ?? "loginPasswordFieldHint";
  String? get loginPasswordFieldValidationEmpty =>
      IntlServer.message("loginPasswordFieldValidationEmpty") ??
      "loginPasswordFieldValidationEmpty";
  String? get loginRegisterButton =>
      IntlServer.message("loginRegisterButton") ?? "loginRegisterButton";
  String? get loginWelcometext =>
      IntlServer.message("loginWelcometext") ?? "loginWelcometext";

  //Forget Password Screen
  String? get forgetPasswordDialogTitle =>
      IntlServer.message("forgetPasswordDialogTitle") ??
      "forgetPasswordDialogTitle";
  String? get forgetPasswordHeaderTitle =>
      IntlServer.message("forgetPasswordHeaderTitle") ??
      "forgetPasswordHeaderTitle";
  String? get forgetPasswordHeaderDescription =>
      IntlServer.message("forgetPasswordHeaderDescription") ??
      "forgetPasswordHeaderDescription";
  String? get forgetPasswordEmailFieldLabel =>
      IntlServer.message("forgetPasswordEmailFieldLabel") ??
      "forgetPasswordEmailFieldLabel";
  String? get forgetPasswordEmailFieldHint =>
      IntlServer.message("forgetPasswordEmailFieldHint") ??
      "forgetPasswordEmailFieldHint";
  String? get forgetPasswordEmailFieldValidationEmpty =>
      IntlServer.message("forgetPasswordEmailFieldValidationEmpty") ??
      "forgetPasswordEmailFieldValidationEmpty";
  String? get forgetPasswordRequestNewPasswordButton =>
      IntlServer.message("forgetPasswordRequestNewPasswordButton") ??
      "forgetPasswordRequestNewPasswordButton";
  String? get forgetPasswordBackToLoginButton =>
      IntlServer.message("forgetPasswordBackToLoginButton") ??
      "forgetPasswordBackToLoginButton";

  //Register Screen
  String? get registerDialogTitle =>
      IntlServer.message("registerDialogTitle") ?? "registerDialogTitle";
  String? get registerHeaderTitle =>
      IntlServer.message("registerHeaderTitle") ?? "registerHeaderTitle";
  String? get registerEmailFieldLabel =>
      IntlServer.message("registerEmailFieldLabel") ??
      "registerEmailFieldLabel";
  String? get registerEmailFieldHint =>
      IntlServer.message("registerEmailFieldHint") ?? "registerEmailFieldHint";
  String? get registerEmailFieldValidationEmpty =>
      IntlServer.message("registerEmailFieldValidationEmpty") ??
      "registerEmailFieldValidationEmpty";
  String? get registerEmailFieldValidationRegex =>
      IntlServer.message("registerEmailFieldValidationRegex") ??
      "registerEmailFieldValidationRegex";
  String? get registerUsernameFieldLabel =>
      IntlServer.message("registerUsernameFieldLabel") ??
      "registerUsernameFieldLabel";
  String? get registerUsernameFieldHint =>
      IntlServer.message("registerUsernameFieldHint") ??
      "registerUsernameFieldHint";
  String? get registerUsernameFieldValidationEmpty =>
      IntlServer.message("registerUsernameFieldValidationEmpty") ??
      "registerUsernameFieldValidationEmpty";
  String? get registerUsernameFieldValidationRegex =>
      IntlServer.message("registerUsernameFieldValidationRegex") ??
      "registerUsernameFieldValidationRegex";
  String? get registerUsernameFieldValidationNoSpace =>
      IntlServer.message("registerUsernameFieldValidationNoSpace") ??
      "registerUsernameFieldValidationNoSpace";
  String? get registerNameFieldLabel =>
      IntlServer.message("registerNameFieldLabel") ?? "registerNameFieldLabel";
  String? get registerNameFieldHint =>
      IntlServer.message("registerNameFieldHint") ?? "registerNameFieldHint";
  String? get registerNameFieldValidationEmpty =>
      IntlServer.message("registerNameFieldValidationEmpty") ??
      "registerNameFieldValidationEmpty";
  String? get registerNameFieldValidationRegex =>
      IntlServer.message("registerNameFieldValidationRegex") ??
      "registerNameFieldValidationRegex";
  String? get registerCityFieldLabel =>
      IntlServer.message("registerCityFieldLabel") ?? "registerCityFieldLabel";
  String? get registerCityFieldHint =>
      IntlServer.message("registerCityFieldHint") ?? "registerCityFieldHint";
  String? get registerCityFieldValidationEmpty =>
      IntlServer.message("registerCityFieldValidationEmpty") ??
      "registerCityFieldValidationEmpty";
  String? get registerBirthdayFieldLabel =>
      IntlServer.message("registerBirthdayFieldLabel") ??
      "registerBirthdayFieldLabel";
  String? get registerBirthdayFieldHint =>
      IntlServer.message("registerBirthdayFieldHint") ??
      "registerBirthdayFieldHint";
  String? get registerBirthdayFieldValidationEmpty =>
      IntlServer.message("registerBirthdayFieldValidationEmpty") ??
      "registerBirthdayFieldValidationEmpty";
  String? get registerTelephoneFieldLabel =>
      IntlServer.message("registerTelephoneFieldLabel") ??
      "registerTelephoneFieldLabel";
  String? get registerTelephoneFieldHint =>
      IntlServer.message("registerTelephoneFieldHint") ??
      "registerTelephoneFieldHint";
  String? get registerTelephoneFieldValidationEmpty =>
      IntlServer.message("registerTelephoneFieldValidationEmpty") ??
      "registerTelephoneFieldValidationEmpty";
  String? get registerPasswordFieldLabel =>
      IntlServer.message("registerPasswordFieldLabel") ??
      "registerPasswordFieldLabel";
  String? get registerPasswordFieldHint =>
      IntlServer.message("registerPasswordFieldHint") ??
      "registerPasswordFieldHint";
  String? get registerPasswordFieldValidationEmpty =>
      IntlServer.message("registerPasswordFieldValidationEmpty") ??
      "registerPasswordFieldValidationEmpty";
  String? get changePasswordNotEqual =>
      IntlServer.message("changePasswordNotEqual") ?? "changePasswordNotEqual";
  String? get registerPasswordConfirmFieldLabel =>
      IntlServer.message("registerPasswordConfirmFieldLabel") ??
      "registerPasswordConfirmFieldLabel";
  String? get registerPasswordConfirmFieldHint =>
      IntlServer.message("registerPasswordConfirmFieldHint") ??
      "registerPasswordConfirmFieldHint";
  String? get registerPasswordConfirmFieldValidationEmpty =>
      IntlServer.message("registerPasswordConfirmFieldValidationEmpty") ??
      "registerPasswordConfirmFieldValidationEmpty";
  String? get registerPasswordConfirmFieldValidationLenght =>
      IntlServer.message("registerPasswordConfirmFieldValidationLenght") ??
      "registerPasswordConfirmFieldValidationLenght";
  String? get registerPasswordConfirmFieldValidationRegex =>
      IntlServer.message("registerPasswordConfirmFieldValidationRegex") ??
      "registerPasswordConfirmFieldValidationRegex";
  String? get registerConfirmEmailButton =>
      IntlServer.message("registerConfirmEmailButton") ??
      "registerConfirmEmailButton";
  String? get registerRegisterButton =>
      IntlServer.message("registerRegisterButton") ?? "registerRegisterButton";
  String? get registerBackToLoginButton =>
      IntlServer.message("registerBackToLoginButton") ??
      "registerBackToLoginButton";

  String? get registerAgreementPartOne =>
      IntlServer.message("registerAgreementPartOne") ??
      "registerAgreementPartOne";
  String? get registerAgreementPartTwo =>
      IntlServer.message("registerAgreementPartTwo") ??
      "registerAgreementPartTwo";
  String? get registerAgreementPartThree =>
      IntlServer.message("registerAgreementPartThree") ??
      "registerAgreementPartThree";
  String? get registerAgreementPartFour =>
      IntlServer.message("registerAgreementPartFour") ??
      "registerAgreementPartFour";
  String? get registerAgreementPartFive =>
      IntlServer.message("registerAgreementPartFive") ??
      "registerAgreementPartFive";

  // Newsfeed screen
  String? get newsfeedAppBarHeader =>
      IntlServer.message("newsfeedAppBarHeader") ?? "newsfeedAppBarHeader";
  String? get newsfeedPicture =>
      IntlServer.message("newsfeedPicture") ?? "newsfeedPicture";
  String? get newsfeedVideo =>
      IntlServer.message("newsfeedVideo") ?? "newsfeedVideo";
  String? get newsfeedAddVideo =>
      IntlServer.message("newsfeedAddVideo") ?? "AddVideo";
  String? get newsfeedAudio =>
      IntlServer.message("newsfeedAudio") ?? "newsfeedAudio";
  String? get newsfeedAddAudio =>
      IntlServer.message("newsfeedAddAudio") ?? "AddAudio";
  String? get newsfeedRemoveAudio =>
      IntlServer.message("newsfeedRemoveAudio") ?? "RemoveAudio";
  String? get processingVideo =>
      IntlServer.message("processingVideo") ?? "processingVideo";
  String? get newsfeedRemoveVideo =>
      IntlServer.message("newsfeedRemoveVideo") ?? "RemoveVideo";

  String? get newsfeedAdd => IntlServer.message("newsfeedAdd") ?? "newsfeedAdd";
  String? get newsfeedUpdate =>
      IntlServer.message("newsfeedUpdate") ?? "newsfeedUpdate";
  String? get newsfeedCreate =>
      IntlServer.message("newsfeedCreate") ?? "newsfeedCreate";
  String? get newsfeedUpdateButton =>
      IntlServer.message("newsfeedUpdateButton") ?? "newsfeedUpdateButton";
  String? get hideFromNewsfeed =>
      IntlServer.message("hideFromNewsfeed") ?? "hideFromNewsfeed";

  String? get newsfeedSendMessageButton =>
      IntlServer.message("newsfeedSendMessageButton") ??
      "newsfeedSendMessageButton";
  String? get newsfeedSendMessageTitle =>
      IntlServer.message("newsfeedSendMessageTitle") ??
      "newsfeedSendMessageTitle";

  String? get newsfeedDescriptionTitle =>
      IntlServer.message("newsfeedDescriptionTitle") ??
      "newsfeedDescriptionTitle";
  String? get newsfeedDescriptionHint =>
      IntlServer.message("newsfeedDescriptionHint") ??
      "newsfeedDescriptionHint";
  String? get newsfeedDescriptionValidation =>
      IntlServer.message("newsfeedDescriptionValidation") ??
      "newsfeedDescriptionValidation";
  String? get newsfeedDescriptionLengthValidation =>
      IntlServer.message("newsfeedDescriptionLengthValidation") ??
      "newsfeedDescriptionLengthValidation";

  String? get newsfeedDescriptionLengthLongValidation =>
      IntlServer.message("newsfeedDescriptionLengthLongValidation") ??
      "newsfeedDescriptionLengthLongValidation";

  String? get newsfeedAddImage =>
      IntlServer.message("newsfeedAddImage") ?? "newsfeedAddImage";
  String? get newsfeedRemoveImage =>
      IntlServer.message("newsfeedRemoveImage") ?? "newsfeedRemoveImage";

  // Fan Box screen
  String? get fanboxAppBarHeader =>
      IntlServer.message("fanboxAppBarHeader") ?? "fanboxAppBarHeader";
  String? get fanboxTabMusic =>
      IntlServer.message("fanboxTabMusic") ?? "fanboxTabMusic";
  String? get fanboxTabVideo =>
      IntlServer.message("fanboxTabVideo") ?? "fanboxTabVideo";
  String? get fanboxTabBooklet =>
      IntlServer.message("fanboxTabBooklet") ?? "fanboxTabBooklet";
  String? get fanboxActivate =>
      IntlServer.message("fanboxActivate") ?? "fanboxActivate";
  String? get fanboxEnterCode =>
      IntlServer.message("fanboxEnterCode") ?? "fanboxEnterCode";
  String? get fanBoxAll => IntlServer.message("fanBoxAll") ?? "fanBoxAll";

  // Album screen
  String? get albumReleasedate =>
      IntlServer.message("albumReleasedate") ?? "albumReleasedate";

  // Track screen
  String? get trackReleasedate =>
      IntlServer.message("trackReleasedate") ?? "trackReleasedate";
  String? get trackDownloadText =>
      IntlServer.message("trackDownloadText") ?? "trackDownloadText";

  // Video screen
  String? get videoThumbnailUploadText =>
      IntlServer.message("videoThumbnailUploadText") ??
      "videoThumbnailUploadText";
  String? get videoDownloadText =>
      IntlServer.message("videoDownloadText") ?? "videoDownloadText";

  // Most asked Question screen
  String? get fanquestionAppBarHeader =>
      IntlServer.message("fanquestionAppBarHeader") ??
      "fanquestionAppBarHeader";
  // Notifications
  String? get noNotificationTitle =>
      IntlServer.message("noNotificationTitle") ?? "noNotificationTitle";
  String? get notificationTitle =>
      IntlServer.message("notificationTitle") ?? "notificationTitle";

  // Fan Ranking screen
  String? get fanRankingAppBarHeader =>
      IntlServer.message("fanRankingAppBarHeader") ?? "fanRankingAppBarHeader";
  String? get fanRankingColumnHeaderName =>
      IntlServer.message("fanRankingColumnHeaderName") ??
      "fanRankingColumnHeaderName";
  String? get fanRankingColumnHeaderCity =>
      IntlServer.message("fanRankingColumnHeaderCity") ??
      "fanRankingColumnHeaderCity";
  String? get fanRankingColumnHeaderPoints =>
      IntlServer.message("fanRankingColumnHeaderPoints") ??
      "fanRankingColumnHeaderPoints";
  String? get fanRankingNotAvailable =>
      IntlServer.message("fanRankingNotAvailable") ?? "fanRankingNotAvailable";
  String? get fanRankingMyPlacement =>
      IntlServer.message("fanRankingMyPlacement") ?? "fanRankingMyPlacement";
  String? get fanRankingTop100 =>
      IntlServer.message("fanRankingTop100") ?? "fanRankingTop100";
  String? get fanRankingPointSystem =>
      IntlServer.message("fanRankingPointSystem") ?? "fanRankingPointSystem";
  String? get fanRankingPoints =>
      IntlServer.message("fanRankingPoints") ?? "fanRankingPoints";
  String? get fanRankingPoint =>
      IntlServer.message("fanRankingPoint") ?? "fanRankingPoint";

  // More Screen
  String? get moreAppBarHeader =>
      IntlServer.message("moreAppBarHeader") ?? "moreAppBarHeader";
  String? get moreEditProfileButton =>
      IntlServer.message("moreEditProfileButton") ?? "moreEditProfileButton";
  String? get moreSupportButton =>
      IntlServer.message("moreSupportButton") ?? "moreSupportButton";
  String? get moreLogoutButton =>
      IntlServer.message("moreLogoutButton") ?? "moreLogoutButton";

  // Support Screen
  String? get supportAppBarHeader =>
      IntlServer.message("supportAppBarHeader") ?? "supportAppBarHeader";
  String? get supportSubjectFieldLabel =>
      IntlServer.message("supportSubjectFieldLabel") ??
      "supportSubjectFieldLabel";
  String? get supportSubjectFieldHint =>
      IntlServer.message("supportSubjectFieldHint") ??
      "supportSubjectFieldHint";
  String? get supportSubjectFieldValidationEmpty =>
      IntlServer.message("supportSubjectFieldValidationEmpty") ??
      "supportSubjectFieldValidationEmpty";
  String? get supportMessageFieldLabel =>
      IntlServer.message("supportMessageFieldLabel") ??
      "supportMessageFieldLabel";
  String? get supportMessageFieldHint =>
      IntlServer.message("supportMessageFieldHint") ??
      "supportMessageFieldHint";
  String? get supportMessageFieldValidationEmpty =>
      IntlServer.message("supportMessageFieldValidationEmpty") ??
      "supportMessageFieldValidationEmpty";
  String? get supportMessageFieldValidationRegex =>
      IntlServer.message("supportMessageFieldValidationRegex") ??
      "supportMessageFieldValidationRegex";
  String? get supportSendMessageButton =>
      IntlServer.message("supportSendMessageButton") ??
      "supportSendMessageButton";
  String? get supportDialogTitle =>
      IntlServer.message("supportDialogTitle") ?? "supportDialogTitle";

  // Navigation Screen
  String? get navigationNewsfeed =>
      IntlServer.message("navigationNewsfeed") ?? "navigationNewsfeed";
  String? get navigationFanBox =>
      IntlServer.message("navigationFanBox") ?? "navigationFanBox";
  String? get navigationFanQuestions =>
      IntlServer.message("navigationFanQuestions") ?? "navigationFanQuestions";
  String? get navigationFanRanking =>
      IntlServer.message("navigationFanRanking") ?? "navigationFanRanking";
  String? get navigationMore =>
      IntlServer.message("navigationMore") ?? "navigationMore";

  // Comment Screen
  String? get commentWriteCommentText =>
      IntlServer.message("commentWriteCommentText") ??
      "commentWriteCommentText";
  String? get commentWriteQuestionText =>
      IntlServer.message("commentWriteQuestionText") ??
      "commentWriteQuestionText";
  String? get commentQuestions =>
      IntlServer.message("commentQuestions") ?? "commentQuestions";
  String? get commentVotes =>
      IntlServer.message("commentVotes") ?? "commentVotes";
  String? get commentUnVote =>
      IntlServer.message("commentUnVote") ?? "commentUnVote";
  String? get commentNotValid =>
      IntlServer.message("commentNotValid") ?? "commentNotValid";
  String? get commentQuestionValidationEmpty =>
      IntlServer.message("commentQuestionValidationEmpty") ??
      "commentQuestionValidationEmpty";
  String? get commentCommentValidationEmpty =>
      IntlServer.message("commentCommentValidationEmpty") ??
      "commentCommentValidationEmpty";
  String? get commentVote => IntlServer.message("commentVote") ?? "commentVote";
  String? get commentReplyTo =>
      IntlServer.message("commentReplyTo") ?? "commentReplyTo";
  String? get commentReply =>
      IntlServer.message("commentReply") ?? "commentReply";

  // Force update Screen
  String? get forceUpdateTitle =>
      IntlServer.message("forceUpdateTitle") ?? "forceUpdateTitle";
  String? get forceUpdateDescription =>
      IntlServer.message("forceUpdateDescription") ?? "forceUpdateDescription";
  String? get forceUpdateButton =>
      IntlServer.message("forceUpdateButton") ?? "forceUpdateButton";

  String? get agreeToTermsAndConditionsTitle =>
      IntlServer.message("agreeToTermsAndConditionsTitle") ??
      "agreeToTermsAndConditionsTitle";
  String? get agreeToTermsAndConditionsMessage =>
      IntlServer.message("agreeToTermsAndConditionsMessage") ??
      "agreeToTermsAndConditionsMessage";

  String? get artistCannotPostQuestionTitle =>
      IntlServer.message("artistCannotPostQuestionTitle") ??
      "artistCannotPostQuestionTitle";
  String? get artistCannotPostQuestionMessage =>
      IntlServer.message("artistCannotPostQuestionMessage") ??
      "artistCannotPostQuestionMessage";

  //General Screen
  String? get generalDialogSorry =>
      IntlServer.message("generalDialogSorry") ?? "generalDialogSorry";

  String? get generalDialogSorryText =>
      IntlServer.message("generalDialogSorryText") ?? "generalDialogSorryText";
  String? get generalView => IntlServer.message("generalView") ?? "generalView";
  String? get generalViews =>
      IntlServer.message("generalViews") ?? "generalViews";
  String? get generalLike => IntlServer.message("generalLike") ?? "generalLike";
  String? get generalLikes =>
      IntlServer.message("generalLikes") ?? "generalLikes";
  String? get generalComment =>
      IntlServer.message("generalComment") ?? "generalComment";
  String? get generalComments =>
      IntlServer.message("generalComments") ?? "generalComments";
  String? get generalClose =>
      IntlServer.message("generalClose") ?? "generalClose";
  String? get generalAdd => IntlServer.message("generalAdd") ?? "generalAdd";
  String? get generalFixedPost =>
      IntlServer.message("generalFixedPost") ?? "generalFixedPost";
  String? get generalNoData =>
      IntlServer.message("generalNoData") ?? "generalNoData";
  String? get generalDone => IntlServer.message("generalDone") ?? "generalDone";
  String? get generalNoPermissionGrantedTitle =>
      IntlServer.message("generalNoPermissionGrantedTitle") ??
      "generalNoPermissionGrantedTitle";
  String? get generalNoPermissionGrantedText =>
      IntlServer.message("generalNoPermissionGrantedText") ??
      "generalNoPermissionGrantedText";
  String? get generalYes => IntlServer.message("generalYes") ?? "generalYes";
  String? get generalNo => IntlServer.message("generalNo") ?? "generalNo";
  String? get generalUnselectAll =>
      IntlServer.message("generalUnselectAll") ?? "generalUnselectAll";
  String? get generalSelectAll =>
      IntlServer.message("generalSelectAll") ?? "generalSelectAll";
  String? get generalInConstruction =>
      IntlServer.message("generalInConstruction") ?? "generalInConstruction";
  String? get generalDownloadWillBePrepared =>
      IntlServer.message("generalDownloadWillBePrepared") ??
      "generalDownloadWillBePrepared";
  String? get generalPhoneNotVerified =>
      IntlServer.message("generalPhoneNotVerified") ??
      "generalPhoneNotVerified";
  String? get generalSuccessArchivedTitle =>
      IntlServer.message("generalSuccessArchivedTitle") ??
      "generalSuccessArchivedTitle";

  String? get generalSuccessPinTitle =>
      IntlServer.message("generalSuccessPinTitle") ?? "generalSuccessPinTitle";
  String? get generalSuccessPinText =>
      IntlServer.message("generalSuccessPinText") ?? "generalSuccessPinText";
  String? get generalSuccessUnpinTitle =>
      IntlServer.message("generalSuccessUnpinTitle") ??
      "generalSuccessUnpinTitle";
  String? get generalSuccessUnpinText =>
      IntlServer.message("generalSuccessUnpinText") ??
      "generalSuccessUnpinText";

  String? get generalSuccessArchivedText =>
      IntlServer.message("generalSuccessArchivedText") ??
      "generalSuccessArchivedText";
  String? get generalSuccessReportedTitle =>
      IntlServer.message("generalSuccessReportedTitle") ??
      "generalSuccessReportedTitle";
  String? get generalSuccessReportedText =>
      IntlServer.message("generalSuccessReportedText") ??
      "generalSuccessReportedText";
  String? get generalArchive =>
      IntlServer.message("generalArchive") ?? "generalArchive";
  String? get generalReportContent =>
      IntlServer.message("generalReportContent") ?? "generalReportContent";
  String? get generalReportUser =>
      IntlServer.message("generalReportUser") ?? "generalReportUser";
  String? get generalEdit => IntlServer.message("generalEdit") ?? "generalEdit";
  String? get generalPin => IntlServer.message("generalPin") ?? "generalPin";
  String? get generalUnpin =>
      IntlServer.message("generalUnpin") ?? "generalUnpin";

  //Profile Screen
  String? get profileAppBarHeader =>
      IntlServer.message("profileAppBarHeader") ?? "profileAppBarHeader";
  String? get profileSaveButton =>
      IntlServer.message("profileSaveButton") ?? "profileSaveButton";
  String? get profileUsernameFieldLabel =>
      IntlServer.message("profileUsernameFieldLabel") ??
      "profileUsernameFieldLabel";
  String? get profileUsernameFieldHint =>
      IntlServer.message("profileUsernameFieldHint") ??
      "profileUsernameFieldHint";
  String? get profileNameFieldHint =>
      IntlServer.message("profileNameFieldHint") ?? "profileNameFieldHint";
  String? get profileNameFieldValidationEmpty =>
      IntlServer.message("profileNameFieldValidationEmpty") ??
      "profileNameFieldValidationEmpty";
  String? get profileNameFieldValidationRegex =>
      IntlServer.message("profileNameFieldValidationRegex") ??
      "profileNameFieldValidationRegex";
  String? get profileNameFieldLabel =>
      IntlServer.message("profileNameFieldLabel") ?? "profileNameFieldLabel";
  String? get profileCityFieldLabel =>
      IntlServer.message("profileCityFieldLabel") ?? "profileCityFieldLabel";
  String? get profileCityFieldHint =>
      IntlServer.message("profileCityFieldHint") ?? "profileCityFieldHint";
  String? get profileCityFieldValidationEmpty =>
      IntlServer.message("profileCityFieldValidationEmpty") ??
      "profileCityFieldValidationEmpty";
  String? get profileBirthdayFieldLabel =>
      IntlServer.message("profileBirthdayFieldLabel") ??
      "profileBirthdayFieldLabel";
  String? get profileBirthdayFieldHint =>
      IntlServer.message("profileBirthdayFieldHint") ??
      "profileBirthdayFieldHint";
  String? get profileBirthdayFieldValidationEmpty =>
      IntlServer.message("profileBirthdayFieldValidationEmpty") ??
      "profileBirthdayFieldValidationEmpty";
  String? get profileTelephoneFieldLabel =>
      IntlServer.message("profileTelephoneFieldLabel") ??
      "profileTelephoneFieldLabel";
  String? get profileTelephoneFieldHint =>
      IntlServer.message("profileTelephoneFieldHint") ??
      "profileTelephoneFieldHint";
  String? get profileTelephoneFieldValidationEmpty =>
      IntlServer.message("profileTelephoneFieldValidationEmpty") ??
      "profileTelephoneFieldValidationEmpty";
  String? get profileTelephoneFieldValidationValidOne =>
      IntlServer.message("profileTelephoneFieldValidationValidOne") ??
      "profileTelephoneFieldValidationValidOne";
  String? get profileChangePasswordButton =>
      IntlServer.message("profileChangePasswordButton") ??
      "profileChangePasswordButton";
  String? get profilUploadPicture =>
      IntlServer.message("profilUploadPicture") ?? "profilUploadPicture";
  String? get profileVerifyTelephoneSuccessTitle =>
      IntlServer.message("profileVerifyTelephoneSuccessTitle") ??
      "profileVerifyTelephoneSuccessTitle";
  String? get profileVerifyTelephoneSuccessText =>
      IntlServer.message("profileVerifyTelephoneSuccessText") ??
      "profileVerifyTelephoneSuccessText";
  String? get profileVerifyTelephoneSendCodeTitle =>
      IntlServer.message("profileVerifyTelephoneSendCodeTitle") ??
      "profileVerifyTelephoneSendCodeTitle";
  String? get profileVerifyTelephoneSendCodeText =>
      IntlServer.message("profileVerifyTelephoneSendCodeText") ??
      "profileVerifyTelephoneSendCodeText";
  String? get profileUpdateSuccessTitle =>
      IntlServer.message("profileUpdateSuccessTitle") ??
      "profileUpdateSuccessTitle";
  String? get profileUpdateSuccessText =>
      IntlServer.message("profileUpdateSuccessText") ??
      "profileUpdateSuccessText";

  String? get successfullyAddedToNewsfeedTitle =>
      IntlServer.message("successfullyAddedToNewsfeedTitle") ??
      "successfullyAddedToNewsfeedTitle";
  String? get successfullyAddedToNewsfeedMessage =>
      IntlServer.message("successfullyAddedToNewsfeedMessage") ??
      "successfullyAddedToNewsfeedMessage";

  String? get successfullyAddedToNewsfeedUpdateTitle =>
      IntlServer.message("successfullyAddedToNewsfeedUpdateTitle") ??
      "successfullyAddedToNewsfeedUpdateTitle";
  String? get successfullyAddedToNewsfeedUpdateMessage =>
      IntlServer.message("successfullyAddedToNewsfeedUpdateMessage") ??
      "successfullyAddedToNewsfeedUpdateMessage";

  String? get newsfeedSendMessageToUserTitle =>
      IntlServer.message("newsfeedSendMessageToUserTitle") ??
      "newsfeedSendMessageToUserTitle";
  String? get newsfeedSendMessageToUserMessage =>
      IntlServer.message("newsfeedSendMessageToUserMessage") ??
      "newsfeedSendMessageToUserMessage";

  // Most asked question Screen
  String? get mostAskedQuestionsOpen =>
      IntlServer.message("mostAskedQuestionsOpen") ?? "mostAskedQuestionsOpen";
  String? get mostAskedQuestionsAnswered =>
      IntlServer.message("mostAskedQuestionsAnswered") ??
      "mostAskedQuestionsAnswered";
  String? get mostAskedQuestionsFanQuestions =>
      IntlServer.message("mostAskedQuestionsFanQuestions") ??
      "mostAskedQuestionsFanQuestions";
  String? get profileTelephoneNotVerified =>
      IntlServer.message("profileTelephoneNotVerified") ??
      "profileTelephoneNotVerified";
  String? get profileVerifyTelephone =>
      IntlServer.message("profileVerifyTelephone") ?? "profileVerifyTelephone";
  String? get profileVerifyTelephoneButton =>
      IntlServer.message("profileVerifyTelephoneButton") ??
      "profileVerifyTelephoneButton";
  String? get profileVerifyTelephoneSendCode =>
      IntlServer.message("profileVerifyTelephoneSendCode") ??
      "profileVerifyTelephoneSendCode";
  String? get profileVerifyTelephoneEnterCode =>
      IntlServer.message("profileVerifyTelephoneEnterCode") ??
      "profileVerifyTelephoneEnterCode";

  //Change password Screen
  String? get changePasswordAppBarHeader =>
      IntlServer.message("changePasswordAppBarHeader") ??
      "changePasswordAppBarHeader";
  String? get changePasswordPasswordFieldLabel =>
      IntlServer.message("changePasswordPasswordFieldLabel") ??
      "changePasswordPasswordFieldLabel";
  String? get changePasswordPasswordFieldHint =>
      IntlServer.message("changePasswordPasswordFieldHint") ??
      "changePasswordPasswordFieldHint";
  String? get changePasswordPasswordFieldValidationEmpty =>
      IntlServer.message("changePasswordPasswordFieldValidationEmpty") ??
      "changePasswordPasswordFieldValidationEmpty";
  String? get changePasswordNewPasswordFieldLabel =>
      IntlServer.message("changePasswordNewPasswordFieldLabel") ??
      "changePasswordNewPasswordFieldLabel";
  String? get changePasswordNewPasswordFieldHint =>
      IntlServer.message("changePasswordNewPasswordFieldHint") ??
      "changePasswordNewPasswordFieldHint";
  String? get changePasswordNewPasswordFieldValidationEmpty =>
      IntlServer.message("changePasswordNewPasswordFieldValidationEmpty") ??
      "changePasswordNewPasswordFieldValidationEmpty";
  String? get changePasswordConfirmPasswordFieldLabel =>
      IntlServer.message("changePasswordConfirmPasswordFieldLabel") ??
      "changePasswordConfirmPasswordFieldLabel";
  String? get changePasswordConfirmPasswordFieldHint =>
      IntlServer.message("changePasswordConfirmPasswordFieldHint") ??
      "changePasswordConfirmPasswordFieldHint";
  String? get changePasswordConfirmPasswordFieldValidationEmpty =>
      IntlServer.message("changePasswordConfirmPasswordFieldValidationEmpty") ??
      "changePasswordConfirmPasswordFieldValidationEmpty";
  String? get changePasswordSaveButton =>
      IntlServer.message("changePasswordSaveButton") ??
      "changePasswordSaveButton";
  String? get changePasswordDialogText =>
      IntlServer.message("changePasswordDialogText") ??
      "changePasswordDialogText";

  //Verify screen
  String? get verifyRegisterCodeInvalid =>
      IntlServer.message("verifyRegisterCodeInvalid") ??
      "verifyRegisterCodeInvalid";
  String? get verifyRegisterCodeInvalidTitle =>
      IntlServer.message("verifyRegisterCodeInvalidTitle") ??
      "verifyRegisterCodeInvalidTitle";
  String? get verifyRegisterCodeFillOut =>
      IntlServer.message("verifyRegisterCodeFillOut") ??
      "verifyRegisterCodeFillOut";
  String? get verifyRegisterTitle =>
      IntlServer.message("verifyRegisterTitle") ?? "verifyRegisterTitle";
  String? get verifyRegisterDescription =>
      IntlServer.message("verifyRegisterDescription") ??
      "verifyRegisterDescription";
  String? get verifyRegisterEmailFieldLabel =>
      IntlServer.message("verifyRegisterEmailFieldLabel") ??
      "verifyRegisterEmailFieldLabel";
  String? get verifyRegisterEmailFieldHint =>
      IntlServer.message("verifyRegisterEmailFieldHint") ??
      "verifyRegisterEmailFieldHint";
  String? get verifyRegisterEmailFieldValidationEmpty =>
      IntlServer.message("verifyRegisterEmailFieldValidationEmpty") ??
      "verifyRegisterEmailFieldValidationEmpty";
  String? get verifyRegisterEmailFieldValidationRegex =>
      IntlServer.message("verifyRegisterEmailFieldValidationRegex") ??
      "verifyRegisterEmailFieldValidationRegex";
  String? get verifyRegisterEmptyField =>
      IntlServer.message("verifyRegisterEmptyField") ??
      "verifyRegisterEmptyField";
  String? get verifyRegisterPasteCode =>
      IntlServer.message("verifyRegisterPasteCode") ??
      "verifyRegisterPasteCode";
  String? get verifyRegisterDialogSuccessTitle =>
      IntlServer.message("verifyRegisterDialogSuccessTitle") ??
      "verifyRegisterDialogSuccessTitle";
  String? get verifyRegisterFanBoxTitle =>
      IntlServer.message("verifyRegisterFanBoxTitle") ??
      "verifyRegisterFanBoxTitle";
  String? get verifyRegisterBack =>
      IntlServer.message("verifyRegisterBack") ?? "verifyRegisterBack";

  // File chooser screen
  String? get fileChooserCurrentCoverSize =>
      IntlServer.message("fileChooserCurrentCoverSize") ??
      "fileChooserCurrentCoverSize";
  String? get fileChooserUploadOptions =>
      IntlServer.message("fileChooserUploadOptions") ??
      "fileChooserUploadOptions";
  String? get fileChooserPickMediaUpload =>
      IntlServer.message("fileChooserPickMediaUpload") ??
      "fileChooserPickMediaUpload";
  String? get fileChooserDropBoxTitle =>
      IntlServer.message("fileChooserDropBoxTitle") ??
      "fileChooserDropBoxTitle";
  String? get fileChooserConnectAs =>
      IntlServer.message("fileChooserConnectAs") ?? "fileChooserConnectAs";
  String? get fileChooserGuest =>
      IntlServer.message("fileChooserGuest") ?? "fileChooserGuest";
  String? get fileChooserNoDropBoxFilesFound =>
      IntlServer.message("fileChooserNoDropBoxFilesFound") ??
      "fileChooserNoDropBoxFilesFound";

  // Audio Upload
  String? get audioTooShort =>
      IntlServer.message("audioTooShort") ?? "audioTooShort";

  // More section
  String? get moreSectionTermsPartOne =>
      IntlServer.message("moreSectionTermsPartOne") ??
      "moreSectionTermsPartOne";
  String? get moreSectionTermsPartTwo =>
      IntlServer.message("moreSectionTermsPartTwo") ??
      "moreSectionTermsPartTwo";
  String? get moreSectionTermsPartThree =>
      IntlServer.message("moreSectionTermsPartThree") ??
      "moreSectionTermsPartThree";
  String? get moreSectionTermsPartFour =>
      IntlServer.message("moreSectionTermsPartFour") ??
      "moreSectionTermsPartFour";
  String? get moreSectionTermsPartFive =>
      IntlServer.message("moreSectionTermsPartFive") ??
      "moreSectionTermsPartFive";
  String? get moreInfo => IntlServer.message("moreInfo") ?? "moreInfo";

  String? get fanBoxOverviewAvailable =>
      IntlServer.message("fanBoxOverviewAvailable") ??
      "fanBoxOverviewAvailable";
  String? get fanBoxOverviewDay =>
      IntlServer.message("fanBoxOverviewDay") ?? "fanBoxOverviewDay";
  String? get fanBoxOverviewHour =>
      IntlServer.message("fanBoxOverviewHour") ?? "fanBoxOverviewHour";
  String? get fanBoxOverviewMinute =>
      IntlServer.message("fanBoxOverviewMinute") ?? "fanBoxOverviewMinute";
  String? get fanBoxOverviewDays =>
      IntlServer.message("fanBoxOverviewDays") ?? "fanBoxOverviewDays";
  String? get fanBoxOverviewHours =>
      IntlServer.message("fanBoxOverviewHours") ?? "fanBoxOverviewHours";
  String? get fanBoxOverviewMinutes =>
      IntlServer.message("fanBoxOverviewMinutes") ?? "fanBoxOverviewMinutes";

  String? get termAndContidionLink =>
      IntlServer.message("termAndContidionLink") ?? "termAndContidionLink";
  String? get moreInfoLink => IntlServer.message("moreInfoLink") ?? "";
  String? get dataPrivacyLink =>
      IntlServer.message("dataPrivacyLink") ?? "dataPrivacyLink";
  String? get invalidPin => IntlServer.message("invalidPin") ?? "invalidPin";
  String? get nothingOnClipBoard =>
      IntlServer.message("nothingOnClipBoard") ?? "nothingOnClipBoard";
  String? get fileTooLarge =>
      IntlServer.message("fileTooLarge") ?? "fileTooLarge";

  String? get orderByLikes =>
      IntlServer.message("orderByLikes") ?? "orderByLikes";

  String? get orderByVotes =>
      IntlServer.message("orderByVotes") ?? "orderByVotes";

  String get orderByNewest =>
      IntlServer.message("orderByNewest") ?? "orderByNewest";

  String get refreshingFeed =>
      IntlServer.message("refreshingFeed") ?? "refreshingFeed";

  String get addCommentTitle =>
      IntlServer.message("addCommentTitle") ?? "addCommentTitle";
  String get addQuestionTitle =>
      IntlServer.message("addQuestionTitle") ?? "addQuestionTitle";

  String get addAnswerTitle =>
      IntlServer.message("addAnswerTitle") ?? "addAnswerTitle";
  String get addAnswerText =>
      IntlServer.message("addAnswerText") ?? "addAnswerText";

  String get sendMessage => IntlServer.message("sendMessage") ?? "sendMessage";

  String get exitAppTitle =>
      IntlServer.message("exitAppTitle") ?? "exitAppTitle";
  String get exitAppContent =>
      IntlServer.message("exitAppContent") ?? "exitAppContent";
  String get exitAppConfirm =>
      IntlServer.message("exitAppConfirm") ?? "exitAppConfirm";
  String get exitAppCancel =>
      IntlServer.message("exitAppCancel") ?? "exitAppCancel";

  String get deleteAccountButton =>
      IntlServer.message("deleteAccountButton") ?? "deleteAccountButton";
  String get deleteAccountCancelText =>
      IntlServer.message("deleteAccountCancelText") ??
      "deleteAccountCancelText";
  String get deleteAccountTitle =>
      IntlServer.message("deleteAccountTitle") ?? "deleteAccountTitle";
  String get deleteAccountConfirmText =>
      IntlServer.message("deleteAccountConfirmText") ??
      "deleteAccountConfirmText";
  String get deleteAccountMessage =>
      IntlServer.message("deleteAccountMessage") ?? "deleteAccountMessage";

  String get deleteAccountMessageResponseTitle =>
      IntlServer.message("deleteAccountMessageResponseTitle") ??
      "deleteAccountMessageResponseTitle";
  String get deleteAccountMessageResponseMessage =>
      IntlServer.message("deleteAccountMessageResponseMessage") ??
      "deleteAccountMessageResponseMessage";

  String? getLocale(String? key) {
    return IntlServer.message(key) ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  // Returns true if the local is supported
  @override
  bool isSupported(Locale locale) {
    return ['de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
