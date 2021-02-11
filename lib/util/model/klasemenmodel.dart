class KlasemenModel {
  String name;
  String teamid;
  String played;
  String goalsfor;
  String goalsagainst;
  String goalsdifference;
  String teamBadge;
  String win;
  String draw;
  String loss;
  String total;

  KlasemenModel(
      {this.name,
        this.teamid,
        this.played,
        this.goalsfor,
        this.goalsagainst,
        this.goalsdifference,
        this.teamBadge,
        this.win,
        this.draw,
        this.loss,
        this.total});

  KlasemenModel.fromJson(Map<String, dynamic> json) {
    name = json['strTeam'];
    teamid = json['idTeam'];
    played = json['intPlayed'];
    goalsfor = json['intGoalsFor'];
    goalsagainst = json['intGoalsAgainst'];
    goalsdifference = json['intGoalDifference'];
    teamBadge = json['strTeamBadge'];
    win = json['intWin'];
    draw = json['intDraw'];
    loss = json['intLoss'];
    total = json['intPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strTeam'] = this.name;
    data['idTeam'] = this.teamid;
    data['intPlayed'] = this.played;
    data['intGoalsFor'] = this.goalsfor;
    data['intGoalsAgainst'] = this.goalsagainst;
    data['intGoalDifference'] = this.goalsdifference;
    data['strTeamBadge'] = this.teamBadge;
    data['intWin'] = this.win;
    data['intDraw'] = this.draw;
    data['intLoss'] = this.loss;
    data['intPoints'] = this.total;
    return data;
  }
}
