class MatchModel {
  String idEvent;
  String strEvent;
  String strHomeTeam;
  String strAwayTeam;
  String intHomeScore;
  String intAwayScore;
  String strHomeGoalDetails;
  String strAwayGoalDetails;
  String strHomeRedCards;
  String strHomeYellowCards;
  String strHomeLineupGoalkeeper;
  String strHomeLineupDefense;
  String strHomeLineupMidfield;
  String strHomeLineupForward;
  String strHomeLineupSubstitutes;
  String strHomeFormation;
  String strAwayRedCards;
  String strAwayYellowCards;
  String strAwayLineupGoalkeeper;
  String strAwayLineupDefense;
  String strAwayLineupMidfield;
  String strAwayLineupForward;
  String strAwayLineupSubstitutes;
  String strAwayFormation;
  String intHomeShots;
  String intAwayShots;
  String strDate;
  String dateEvent;
  String strTime;
  String idHomeTeam;
  String idAwayTeam;

  MatchModel(
      {this.idEvent,
        this.strEvent,
        this.strHomeTeam,
        this.strAwayTeam,
        this.intHomeScore,
        this.intAwayScore,
        this.strHomeGoalDetails,
        this.strAwayGoalDetails,
        this.strHomeRedCards,
        this.strHomeYellowCards,
        this.strHomeLineupGoalkeeper,
        this.strHomeLineupDefense,
        this.strHomeLineupMidfield,
        this.strHomeLineupForward,
        this.strHomeLineupSubstitutes,
        this.strHomeFormation,
        this.strAwayRedCards,
        this.strAwayYellowCards,
        this.strAwayLineupGoalkeeper,
        this.strAwayLineupDefense,
        this.strAwayLineupMidfield,
        this.strAwayLineupForward,
        this.strAwayLineupSubstitutes,
        this.strAwayFormation,
        this.intHomeShots,
        this.intAwayShots,
        this.strDate,
        this.dateEvent,
        this.strTime,
        this.idHomeTeam,
        this.idAwayTeam,
      });

  MatchModel.fromJson(Map<String, dynamic> json) {
    idEvent = json["idEvent"]?.toString();
    strEvent = json["strEvent"]?.toString();
    strHomeTeam = json["strHomeTeam"]?.toString();
    strAwayTeam = json["strAwayTeam"]?.toString();
    intHomeScore = json["intHomeScore"]?.toString();
    intAwayScore = json["intAwayScore"]?.toString();
    strHomeGoalDetails = json["strHomeGoalDetails"]?.toString();
    strHomeRedCards = json["strHomeRedCards"]?.toString();
    strHomeYellowCards = json["strHomeYellowCards"]?.toString();
    strHomeLineupGoalkeeper = json["strHomeLineupGoalkeeper"]?.toString();
    strHomeLineupDefense = json["strHomeLineupDefense"]?.toString();
    strHomeLineupMidfield = json["strHomeLineupMidfield"]?.toString();
    strHomeLineupForward = json["strHomeLineupForward"]?.toString();
    strHomeLineupSubstitutes = json["strHomeLineupSubstitutes"]?.toString();
    strHomeFormation = json["strHomeFormation"]?.toString();
    strAwayRedCards = json["strAwayRedCards"]?.toString();
    strAwayYellowCards = json["strAwayYellowCards"]?.toString();
    strAwayGoalDetails = json["strAwayGoalDetails"]?.toString();
    strAwayLineupGoalkeeper = json["strAwayLineupGoalkeeper"]?.toString();
    strAwayLineupDefense = json["strAwayLineupDefense"]?.toString();
    strAwayLineupMidfield = json["strAwayLineupMidfield"]?.toString();
    strAwayLineupForward = json["strAwayLineupForward"]?.toString();
    strAwayLineupSubstitutes = json["strAwayLineupSubstitutes"]?.toString();
    strAwayFormation = json["strAwayFormation"]?.toString();
    intHomeShots = json["intHomeShots"]?.toString();
    intAwayShots = json["intAwayShots"]?.toString();
    dateEvent = json["dateEvent"]?.toString();
    strDate = json["strDate"]?.toString();
    strTime = json["strTime"]?.toString();
    idHomeTeam = json["idHomeTeam"]?.toString();
    idAwayTeam = json["idAwayTeam"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["idEvent"] = idEvent;
    data["strEvent"] = strEvent;
    data["strHomeTeam"] = strHomeTeam;
    data["strAwayTeam"] = strAwayTeam;
    data["intHomeScore"] = intHomeScore;
    data["intAwayScore"] = intAwayScore;
    data["strHomeGoalDetails"] = strHomeGoalDetails;
    data["strHomeRedCards"] = strHomeRedCards;
    data["strHomeYellowCards"] = strHomeYellowCards;
    data["strHomeLineupGoalkeeper"] = strHomeLineupGoalkeeper;
    data["strHomeLineupDefense"] = strHomeLineupDefense;
    data["strHomeLineupMidfield"] = strHomeLineupMidfield;
    data["strHomeLineupForward"] = strHomeLineupForward;
    data["strHomeLineupSubstitutes"] = strHomeLineupSubstitutes;
    data["strHomeFormation"] = strHomeFormation;
    data["strAwayRedCards"] = strAwayRedCards;
    data["strAwayYellowCards"] = strAwayYellowCards;
    data["strAwayGoalDetails"] = strAwayGoalDetails;
    data["strAwayLineupGoalkeeper"] = strAwayLineupGoalkeeper;
    data["strAwayLineupDefense"] = strAwayLineupDefense;
    data["strAwayLineupMidfield"] = strAwayLineupMidfield;
    data["strAwayLineupForward"] = strAwayLineupForward;
    data["strAwayLineupSubstitutes"] = strAwayLineupSubstitutes;
    data["strAwayFormation"] = strAwayFormation;
    data["intHomeShots"] = intHomeShots;
    data["intAwayShots"] = intAwayShots;
    data["dateEvent"] = dateEvent;
    data["strDate"] = strDate;
    data["strTime"] = strTime;
    data["idHomeTeam"] = idHomeTeam;
    data["idAwayTeam"] = idAwayTeam;
    return data;
  }
}