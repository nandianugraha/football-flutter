class LeaguesModel {
  String idLeague;
  String strLeague;

  LeaguesModel({
    this.idLeague,
    this.strLeague,
  });
  LeaguesModel.fromJson(Map<String, dynamic> json) {
    idLeague = json["idLeague"]?.toString();
    strLeague = json["strLeague"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["idLeague"] = idLeague;
    data["strLeague"] = strLeague;
    return data;
  }
}
