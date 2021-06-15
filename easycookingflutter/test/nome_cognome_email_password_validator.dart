import 'package:easycookingflutter/auth/authenticate/register.dart';
import 'package:easycookingflutter/auth/authenticate/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {

  test('empty name registration returns error string', () {

    var result = NomeFieldValidator.validate('');
    expect(result, 'Nome non può essere vuoto');
  });

  test ('non-empty name registration returns null', () {

    var result = NomeFieldValidator.validate('nome');
    expect(result, null);
  });

  test('empty surname registration returns error string', () {

    var result = CognomeFieldValidator.validate('');
    expect(result, 'Cognome non può essere vuoto');
  });

  test ('non-empty surname registration returns null', () {

    var result = CognomeFieldValidator.validate('cognome');
    expect(result, null);
  });

  test('empty email registration returns error string', () {

     var result = EmailFieldValidator.validate('');
     expect(result, 'Email non può essere vuoto');
  });

  test ('non-empty email registration returns null', () {

    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty email authentication returns error string', () {

    var result = EmailValidator.validate('');
    expect(result, 'Email non può essere vuoto');
  });

  test ('non-empty email authentication returns null', () {

    var result = EmailValidator.validate('email');
    expect(result, null);
  });


  test('empty password registration returns error string', () {

    var result = PasswordFieldValidator.validate('');
    expect(result, 'Inserisci una password più lunga di 6 caratteri');
  });

  test ('non-empty password registration returns null', () {

    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

  test('empty password authentication returns error string', () {

    var result = PasswordValidator.validate('');
    expect(result, 'Inserisci una password più lunga di 6 caratteri');
  });

  test ('non-empty password authentication returns null', () {

    var result = PasswordValidator.validate('password');
    expect(result, null);
  });

}