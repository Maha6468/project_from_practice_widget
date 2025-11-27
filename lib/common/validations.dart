import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  static final requiredValidator = RequiredValidator(errorText: "This field is required");
  static final addressValidator = RequiredValidator(errorText: "Address is required");
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please Enter your password'),
    // MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    /*MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')*/
  ]);
  static final emailValidator = MultiValidator(
      [RequiredValidator(errorText: 'Please Enter your email'), EmailValidator(errorText: 'Enter a valid email address')]);
  static final numberValidator = MultiValidator([
    RequiredValidator(errorText: 'Number is required'),
    PatternValidator(r'^[6-9]\d{9}$', errorText: 'Enter a valid mobile number')
  ]);
  static final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Please Enter your Full name'),
    PatternValidator(r'^[A-Za-z\s]+$', errorText: 'Enter a valid name')
  ]);


}