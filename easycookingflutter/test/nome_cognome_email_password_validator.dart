import 'package:easycookingflutter/auth/authenticate/register.dart';
import 'package:easycookingflutter/auth/authenticate/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

/*
funzione utilizzata per effettuare i test
 */

void main () {

  //test per verificare che la casella nome nella registrazione non può essere vuota
  test('empty name registration returns error string', () {

    var result = NomeFieldValidator.validate('');
    expect(result, 'Nome non può essere vuoto');
  });

  //test per verificare se ci sono errori nell'inserimento del nome nella registrazione
  test ('non-empty name registration returns null', () {

    var result = NomeFieldValidator.validate('nome');
    expect(result, null);
  });

  //test per verificare che la casella cognome nella registrazione non può essere vuota
  test('empty surname registration returns error string', () {

    var result = CognomeFieldValidator.validate('');
    expect(result, 'Cognome non può essere vuoto');
  });

  //test per verificare se ci sono errori nell'inserimento del cognome nella registrazione
  test ('non-empty surname registration returns null', () {

    var result = CognomeFieldValidator.validate('cognome');
    expect(result, null);
  });

  //test per verificare che la casella email nella registrazione non può essere vuota
  test('empty email registration returns error string', () {

     var result = EmailFieldValidator.validate('');
     expect(result, 'Email non può essere vuoto');
  });

  //test per verificare se ci sono errori nell'inserimento della mail nella registrazione
  test ('non-empty email registration returns null', () {

    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  //test per verificare che la casella email nell'autenticazione non può essere vuota
  test('empty email authentication returns error string', () {

    var result = EmailValidator.validate('');
    expect(result, 'Email non può essere vuoto');
  });

  //test per verificare se ci sono errori nell'inserimento della mail nell'autenticazione
  test ('non-empty email authentication returns null', () {

    var result = EmailValidator.validate('email');
    expect(result, null);
  });

  //test per verificare che la casella password nella registrazione non può essere vuota
  test('empty password registration returns error string', () {

    var result = PasswordFieldValidator.validate('');
    expect(result, 'Inserisci una password più lunga di 6 caratteri');
  });

  //test per verificare se ci sono errori nell'inserimento della password nella registrazione
  test ('non-empty password registration returns null', () {

    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

  //test per verificare che la casella password nell'autenticazione non può essere vuota
  test('empty password authentication returns error string', () {

    var result = PasswordValidator.validate('');
    expect(result, 'Inserisci una password più lunga di 6 caratteri');
  });

  //test per verificare se ci sono errori nell'inserimento della password nell'autenticazione
  test ('non-empty password authentication returns null', () {

    var result = PasswordValidator.validate('password');
    expect(result, null);
  });

}