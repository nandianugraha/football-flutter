class Constant{

  static String league;
  static String year;

  static String API_listLeague = "api/v1/json/1/search_all_leagues.php?&s=Soccer";
  static String API_listLastMatch = "api/v1/json/1/eventspastleague.php?id=";
  static String API_listNextMatch = "api/v1/json/1/eventsnextleague.php?id=";
  static String API_listTeams = "/api/v1/json/1/lookup_all_teams.php?id=";
  static String API_klasemen = "api/v1/json/1/lookuptable.php?l=${league}&s=${year}";
}