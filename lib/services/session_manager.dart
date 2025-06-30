class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  String? _username;
  String? _password;
  String? _token;

  // Setters
  void setLoginData(String username, String password, String token) {
    _username = username;
    _password = password;
    _token = token;
  }

  // Getters
  String? get username => _username;
  String? get password => _password;
  String? get token => _token;

  // Clear data
  void clear() {
    // _username = null;
    // _password = null;
    _token = null;
  }
}
