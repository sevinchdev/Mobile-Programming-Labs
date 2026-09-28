// Problem 2: interface class DBConnector implemented in a concrete MySQLConnector class.

abstract interface class DBConnector {
  void connect();
  void query(String sql);
  void disconnect();
}

class MySQLConnector implements DBConnector {
  @override
  void connect() => print('Connected to MySQL');

  @override
  void query(String sql) => print('Running on MySQL: $sql');

  @override
  void disconnect() => print('Disconnected from MySQL');
}

void main() {
  DBConnector db = MySQLConnector();
  db.connect();
  db.query('SELECT * FROM users');
  db.disconnect();
}
