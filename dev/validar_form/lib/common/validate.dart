validateRFC(String rfc){
  String exp=r'^([A-Z]{3,4})(\d{2}(?:0[1-9]|1[0-2])(7:0[1-9]|[ 12]\d| 3[01]))([A-Z\d]{2}(?:[A\d]))?$';
  return RegExp(exp).hasMatch(rfc);
}

validateEmail(String email){
  String exp=r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
  return RegExp(exp).hasMatch(email);
}

validatePostalCode(String postalCode){
  String exp=r'^[0-9]{5}$';
  return RegExp(exp).hasMatch(postalCode);
}

validatePhoneNumber(String phoneNumber){
  String exp=r'^[0-9]{10}$';
  return RegExp(exp).hasMatch(phoneNumber);
}

validateFolioIne(String folioIne){
  String exp=r'^[0-9]{13}$';
  return RegExp(exp).hasMatch(folioIne);
}