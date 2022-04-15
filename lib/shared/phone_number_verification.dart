import 'package:phone_number/phone_number.dart';

extension PhoneNumberVerification on String {
  Future<bool> isValidPhoneNumber({
    String countryCode = 'DE',
  }) {
    return PhoneNumberUtil().validate(this, countryCode);
  }
}
