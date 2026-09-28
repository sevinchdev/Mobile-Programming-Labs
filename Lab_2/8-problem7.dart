// Problem 7: complex hierarchy passing immutable configuration parameters up the inheritance chain.

class AppConfig {
  final String appName;
  final int version;

  const AppConfig(this.appName, this.version);
}

class Service {
  final AppConfig config;

  Service(this.config);

  void info() => print('${config.appName} v${config.version}');
}

class DatabaseService extends Service {
  final String host;

  DatabaseService(super.config, this.host);

  @override
  void info() {
    super.info();
    print('Database host: $host');
  }
}

class CachedDatabaseService extends DatabaseService {
  final int cacheSize;

  CachedDatabaseService(super.config, super.host, this.cacheSize);

  @override
  void info() {
    super.info();
    print('Cache size: $cacheSize MB');
  }
}

void main() {
  const config = AppConfig('MobileApp', 2);
  var service = CachedDatabaseService(config, 'localhost', 64);
  service.info();
}
