bool isValidEmailAddress(String it) =>
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(it);

bool isValidPassword(String it) => it.length >= 6;

bool isValidRegisterPassword(String it) =>
    RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(it);

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsSpecialCharacter =>
      contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get containsDigit => contains(RegExp(r'[0-9]'));
}
