class KlasemenModel {
  String name;
  String teamid;
  int played;
  int goalsfor;
  int goalsagainst;
  int goalsdifference;
  int win;
  int draw;
  int loss;
  int total;

  KlasemenModel(
      {this.name,
        this.teamid,
        this.played,
        this.goalsfor,
        this.goalsagainst,
        this.goalsdifference,
        this.win,
        this.draw,
        this.loss,
        this.total});

  KlasemenModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    teamid = json['teamid'];
    played = json['played'];
    goalsfor = json['goalsfor'];
    goalsagainst = json['goalsagainst'];
    goalsdifference = json['goalsdifference'];
    win = json['win'];
    draw = json['draw'];
    loss = json['loss'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['teamid'] = this.teamid;
    data['played'] = this.played;
    data['goalsfor'] = this.goalsfor;
    data['goalsagainst'] = this.goalsagainst;
    data['goalsdifference'] = this.goalsdifference;
    data['win'] = this.win;
    data['draw'] = this.draw;
    data['loss'] = this.loss;
    data['total'] = this.total;
    return data;
  }
}
