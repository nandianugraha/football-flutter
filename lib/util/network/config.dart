class Config {
  static Env environment = Env.development;
  
  static bool enableForceLog = false;
  static bool isTesting = false;

  static String _path = '/user/';

  static String _developmentDomain = 'www.thesportsdb.com/';
  static String _stagingDomain = 'dtech';
  static String _productionDomain = 'trim';

  static String _developmentAuthId = 'a678803588713b45ae8baf50adefb813';
  static String _stagingAuthId = 'a67880350adefb813';
  static String _productionAuthId = 'd8ef0669d24781b7071b0';

  static String token = 'MZ5ALEkb24JY76njnVlY7FJhr8b6kIdOV6ReYr8w9QqR9AbWf6s';

  static bool get isDevelopment => environment == Env.development;
  static bool get isStaging => environment == Env.staging;
  static bool get isProduction => environment == Env.production;

  static String get scheme => isProduction ? 'https' : 'https';
  static String get baseUrl => scheme + '://' + domain;
  static String get baseUrlNoPath => scheme + '://' + domain;
  static String get langPackUrl => scheme + '://' + domain + '/lang/pack/';

  static String get domain {
    String domain = '';
    switch(environment){
      case Env.development:
        domain = _developmentDomain;
        break;
      case Env.staging:
        domain = _stagingDomain;
        break;
      case Env.production:
        domain = _productionDomain;
        break;
    }
    return domain;
  }

  static String get authId{
    String authId = '';
    switch(environment){
      case Env.development:
        // authId = _developmentAuthId;
        break;
      case Env.staging:
        authId = _stagingAuthId;
        break;
      case Env.production:
        authId = _productionAuthId;
        break;
    }
    return authId;
  }

}

enum Env{
  development, staging, production
}