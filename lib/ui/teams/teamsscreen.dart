import 'package:flutter/material.dart';
import 'package:flutter_app/util/constant.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/helper.dart';
import 'package:flutter_app/util/model/teamsmodel.dart';
import 'package:flutter_app/util/network/api.dart';

class TeamsScreen extends StatefulWidget {
  @override
  _TeamsScreen createState() => _TeamsScreen();
}

class _TeamsScreen extends State<TeamsScreen> {
  List _leagues = [
    '4328',
    '4332',
    '4334',
    '4335',
    '4337',
    '4344',
    '4480',
    '4790'
  ];
  String _leagueId = '4328';
  bool isLoading = false;
  final _searchController = TextEditingController();
  List<Teams> _teams = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiListTeams(_leagueId);
    });
  }

  searchListener() {
    print(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () =>
                    Helper.searchBottom(context, _searchController, () {
                      searchListener();
                    }),
                child: Icon(Icons.search))
          ],
          backgroundColor: Colors.blueGrey,
          title: DefaultText(
            textLabel: 'Teams',
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: teamsUI(),
        ));
  }

  String matches(String item) {
    String text;
    switch (item) {
      case '4328':
        text = 'English Premier League';
        setState(() {});
        break;
      case '4332':
        text = 'Italian Serie A';
        setState(() {});
        break;
      case '4334':
        text = 'French Ligue 1';
        setState(() {});
        break;
      case '4335':
        text = 'Spanish La Liga';
        setState(() {});
        break;
      case '4337':
        text = 'Dutch Eredivisie';
        setState(() {});
        break;
      case '4344':
        text = 'Portuguese Primeira Liga';
        setState(() {});
        break;
      case '4480':
        text = 'UEFA Champions League';
        setState(() {});
        break;
      case '4790':
        text = 'Indonesian Super League';
        setState(() {});
        break;
    }

    return text;
  }

  Widget teamsUI() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 12, left: 20, right: 20),
          padding: EdgeInsets.all(8),
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: DefaultText(
                textLabel: "Choose League...",
              ),
              items: _leagues.map((item) {
                return DropdownMenuItem(
                  child: Text(matches(item)),
                  value: item,
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _leagueId = newVal;
                  print(_leagueId);
                  apiListTeams(_leagueId);
                });
              },
              value: _leagueId == null ? '4328' : _leagueId,
            ),
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator()) : listTeams()
      ],
    );
  }

  Widget listTeams() {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _teams.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey[200],
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(_teams[index].strTeamBadge, width: 50, height: 50,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          margin: EdgeInsets.only(left: 10),
                          sizeText: 16,
                          fontWeight: FontWeight.bold,
                          textLabel: _teams[index].strTeam,
                        ),
                        DefaultText(
                          margin: EdgeInsets.only(left: 10),
                          sizeText: 12,
                          colorsText: Colors.grey,
                          textLabel: _teams[index].intFormedYear,
                        ),
                        DefaultText(
                          margin: EdgeInsets.only(left: 10),
                          sizeText: 12,
                          colorsText: Colors.grey,
                          textLabel: _teams[index].strStadium,
                        )
                      ],
                    )
                  ],
                ),
              ]));
        });
  }

  apiListTeams(String league) async {
    isLoading = true;
    setState(() {});
    Api.createDefaultParams((parameter) {
      Api(context).execute(Constant.API_listTeams + league, false, parameter,
          (response) {
        isLoading = false;
        print(response.data()['teams']);
        List team = response.data()['teams'];
        _teams.clear();
        team.forEach((element) {
          _teams.add(Teams.fromJson(element));
        });
        setState(() {});
      });
    });
  }
}
