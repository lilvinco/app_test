class RegularExpressions {
  static String email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static Pattern password = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\W]{5,}$";
  static Pattern website = r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)';
  static Pattern zipCodeCity = r'^([\d-]{1,}) ([\w\s\S]{2,})$';

}
