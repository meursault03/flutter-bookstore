import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  /// Verifica se existe um e-mail salvo para determinar se o usuário está autenticado.
  Future<bool> isLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    return email != null;
  }

  /// Recupera os dados de 'nome', 'sobrenome' e 'email' do armazenamento local.
  Future<Map<String, String?>> getSession() async {
    var prefs = await SharedPreferences.getInstance();

    return {
      'forename': prefs.getString('forename'),
      'surname': prefs.getString('surname'),
      'email': prefs.getString('email'),
    };
  }

  /// Persiste as informações do usuário no disco de forma assíncrona.
  Future<void> saveSession(
    String forename,
    String surname,
    String email,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('forename', forename);
    await prefs.setString('surname', surname);
    await prefs.setString('email', email);
  }

  /// Remove todos os dados do armazenamento local, encerrando a sessão atual.
  Future<void> clearSession() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
