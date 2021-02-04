class Teams {
  String idTeam;
  String strTeam;
  String strManager;
  String strStadium;
  String strStadiumThumb;
  String strStadiumDescription;
  String intStadiumCapacity;
  String strDescriptionEN;
  String strCountry;
  String strTeamBadge;
  String strTeamJersey;
  String strTeamLogo;
  String intFormedYear;

  Teams(
      {this.idTeam,
      this.strTeam,
      this.strManager,
      this.strStadium,
      this.strStadiumThumb,
      this.strStadiumDescription,
      this.intStadiumCapacity,
      this.strDescriptionEN,
      this.strCountry,
      this.strTeamBadge,
      this.strTeamJersey,
      this.strTeamLogo,
      this.intFormedYear});

  Teams.fromJson(Map<String, dynamic> json) {
    idTeam = json['idTeam'];
    strTeam = json['strTeam'];
    strManager = json['strManager'];
    strStadium = json['strStadium'];
    strStadiumThumb = json['strStadiumThumb'];
    strStadiumDescription = json['strStadiumDescription'];
    intStadiumCapacity = json['intStadiumCapacity'];
    strDescriptionEN = json['strDescriptionEN'];
    strCountry = json['strCountry'];
    strTeamBadge = json['strTeamBadge'];
    strTeamJersey = json['strTeamJersey'];
    strTeamLogo = json['strTeamLogo'];
    intFormedYear = json['intFormedYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTeam'] = this.idTeam;
    data['strTeam'] = this.strTeam;
    data['strManager'] = this.strManager;
    data['strStadium'] = this.strStadium;
    data['strStadiumThumb'] = this.strStadiumThumb;
    data['strStadiumDescription'] = this.strStadiumDescription;
    data['intStadiumCapacity'] = this.intStadiumCapacity;
    data['strDescriptionEN'] = this.strDescriptionEN;
    data['strCountry'] = this.strCountry;
    data['strTeamBadge'] = this.strTeamBadge;
    data['strTeamJersey'] = this.strTeamJersey;
    data['strTeamLogo'] = this.strTeamLogo;
    data['intFormedYear'] = this.intFormedYear;
    return data;
  }
}
