import 'package:connectivity/connectivity.dart';
import 'package:igroove_fan_box_one/api/igroove_api.dart';
import 'package:igroove_fan_box_one/api/translations/translation.dart';
import 'package:rxdart/rxdart.dart';

class Translations {
  final BehaviorSubject<Map<String, String>?> translationsStream =
      BehaviorSubject<Map<String, String>?>();

  Map<String, String>? _translations;
  Map<String, String>? get translations =>
      _translations ?? defaultTranslations['en'];

  Map<String, Map<String, String>> defaultTranslations = {
    'en': <String, String>{
      "loginScreenWelcome": "Welcome to iGroove",
      "emailLabelText": "Email",
      "passwordLabelText": "Password",
      "emailErrorMessage": "Enter valid email address",
      "rememberMe": "Save login",
      "passwordForgoten": "Forgot your password?",
      "signIn": "Sign in",
      "repareAccount": "Apply for account",
      "forgotPasswordHelperText":
          "Please enter your email address and we'll send you a new password.",
      "forgotPasswordSubmit": "Request new password",
      "forgotPasswordBackText": "Back to login",
      "connectionErrorText":
          "Something went wrong, please check your internet connection.",
    },
    'fr': <String, String>{
      "loginScreenWelcome": "Bienvenue chez iGroove",
      "emailLabelText": "Émail",
      "passwordLabelText": "Mot de passe",
      "rememberMe": "Sauvegarder la login",
      "passwordForgoten": "Mot de passe oublié ?",
      "emailErrorMessage": "Entrez une adresse email valide",
      "signIn": "Connecter",
      "repareAccount": "Demander un compte",
      "forgotPasswordHelperText":
          // ignore: lines_longer_than_80_chars
          "Veuillez entrer votre adresse e-mail et nous vous enverrons un nouveau mot de passe.",
      "forgotPasswordSubmit": "Demander un nouveau mot de passe",
      "forgotPasswordBackText": "Retour à login",
      "connectionErrorText":
          // ignore: lines_longer_than_80_chars
          "Une erreur s'est produite, veuillez vérifier votre connexion Internet.",
    },
    'de': <String, String>{
      "loginScreenWelcome": "Willkommen bei iGroove",
      "emailErrorMessage": "Geben Sie eine gültige E-Mail-Adresse ein",
      "connectionErrorText":
          "Etwas ist schiefgelaufen. Bitte überprüfe deine Internetverbindung.",
      "emailLabelText": "Email",
      "passwordLabelText": "Password",
      "rememberMe": "Remember me",
      "passwordForgoten": "Passwort vergessen?",
      "signIn": "Anmelden",
      "repareAccount": "Account beantragen",
      "forgotPasswordHelperText":
          // ignore: lines_longer_than_80_chars
          "Bitte gib deine Email Adresse ein, wir senden dir ein neues Passwort.",
      "forgotPasswordSubmit": "Neues Passwort anfordern",
      "forgotPasswordBackText": "Zurück zum Login",
    },
  };

  Future<Map<String, String>?> getTranslations({required String lang}) async {
    ConnectivityResult _connectivityResult;

    _connectivityResult = await Connectivity().checkConnectivity();
    if (_connectivityResult != ConnectivityResult.none) {
      TranslationsResponse response =
          await IGrooveAPI().translations.getTranslations(lang: lang);
      _translations = response.response;
      translationsStream.sink.add(_translations);
    } else {
      _translations = defaultTranslations[lang];
    }

    return _translations;
  }
}
