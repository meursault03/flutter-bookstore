import 'package:shared_preferences/shared_preferences.dart';

/// Gerenciador de sessão. Não é um widget — persiste dados do usuário via SharedPreferences.
///
/// Deve ser inicializado uma vez via [init] antes do uso.
class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  late final SharedPreferences _prefs;

  /// Inicializa o gerenciador com a instância de SharedPreferences.
  /// Deve ser chamado uma vez em main() antes de runApp().
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Verifica se existe um e-mail salvo para determinar se o usuário está autenticado.
  bool isLoggedIn() {
    var email = _prefs.getString('email');
    return email != null;
  }

  /// Recupera os dados de 'nome', 'sobrenome' e 'email' do armazenamento local.
  Map<String, String?> getSession() {
    return {
      'forename': _prefs.getString('forename'),
      'surname': _prefs.getString('surname'),
      'email': _prefs.getString('email'),
    };
  }

  /// Persiste as informações do usuário no disco de forma assíncrona.
  Future<void> saveSession(
    String forename,
    String surname,
    String email,
  ) async {
    await _prefs.setString('forename', forename);
    await _prefs.setString('surname', surname);
    await _prefs.setString('email', email);
  }

  /// Remove todos os dados do armazenamento local, encerrando a sessão atual.
  Future<void> clearSession() async {
    await _prefs.clear();
  }

  /// Armazena o valor de 'rememberMe' no armazenamento local.
  Future<void> setRememberMe(bool value) async {
    await _prefs.setBool('rememberMe', value);
  }

  /// Recupera o valor de 'rememberMe' do armazenamento local.
  bool getRememberMe() {
    return _prefs.getBool('rememberMe') ?? false;
  }
}
