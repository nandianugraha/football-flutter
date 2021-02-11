import 'dart:convert';
import 'package:flutter_app/util/model/leaguemodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/color.dart';
import 'package:flutter_app/util/constant.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/helper.dart';
import 'package:flutter_app/util/model/matchmodel.dart';
import 'package:flutter_app/util/network/api.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreen createState() => _MatchesScreen();
}

class _MatchesScreen extends State<MatchesScreen> {
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
  List<MatchModel> _matches = [];
  List<MatchModel> _matchesNext = [];
  final _searchController = TextEditingController();
  String _leagueId = '4328';
  String tabs = Constant.API_listLastMatch;
  String tabsNext = Constant.API_listNextMatch;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiMatches(tabs, _leagueId);
      apiMatchesNext(tabsNext, _leagueId);
    });
  }

  searchListener() {
    print(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
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
                textLabel: 'Matches',
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'LAST MATCH',
                  ),
                  Tab(
                    text: 'NEXT MATCH',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : matchesPageLast(Constant.API_listLastMatch),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : matchesPageNext(Constant.API_listNextMatch)
              ],
            )),
      ),
    );
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

  Widget matchesPageLast(String tabs) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                      apiMatches(tabs, _leagueId);
                    });
                  },
                  value: _leagueId == null ? '4328' : _leagueId,
                ),
              ),
            ),
            isLoading ? Center(child: CircularProgressIndicator()) : listLast()
          ],
        ),
      ),
    );
  }

  Widget matchesPageNext(String tabs) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                      apiMatchesNext(tabs, _leagueId);
                    });
                  },
                  value: _leagueId == null ? '4328' : _leagueId,
                ),
              ),
            ),
            isLoading ? Center(child: CircularProgressIndicator()) : listNext()
          ],
        ),
      ),
    );
  }

  Widget listLast() {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              print(index);
            },
            child: Container(
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
                Column(
                  children: [
                    DefaultText(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      textLabel: _matches[index].dateEvent,
                      colorsText: Colors.blueGrey,
                      sizeText: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    DefaultText(
                      sizeText: 12,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      textLabel: _matches[index].strTime,
                      colorsText: Colors.blueGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 100,
                          child: DefaultText(
                            alignment: Alignment.center,
                            sizeText: 16,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            textLabel: _matches[index].strHomeTeam,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          width: 100,
                          child: DefaultText(
                            sizeText: 16,
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.center,
                            textLabel: 'vs',
                          ),
                        ),
                        Container(
                          width: 100,
                          child: DefaultText(
                            sizeText: 16,
                            textAlign: TextAlign.center,
                            alignment: Alignment.center,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textLabel: _matches[index].strAwayTeam,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 100,
                          child: DefaultText(
                            sizeText: 16,
                            textAlign: TextAlign.center,
                            alignment: Alignment.center,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textLabel: _matches[index].intHomeScore == null
                                ? ' '
                                : _matches[index].intHomeScore,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          width: 100,
                        ),
                        Container(
                          width: 100,
                          child: DefaultText(
                            sizeText: 16,
                            textAlign: TextAlign.center,
                            alignment: Alignment.center,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textLabel: _matches[index].intAwayScore == null
                                ? ' '
                                : _matches[index].intAwayScore,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ]),
            ),
          );
        });
  }

  Widget listNext() {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _matchesNext.length,
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
              DefaultText(
                sizeText: 16,
                fontWeight: FontWeight.bold,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60),
                textLabel: 'vs',
              ),
              Column(
                children: [
                  DefaultText(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    textLabel: _matchesNext[index].dateEvent,
                    colorsText: Colors.blueGrey,
                    sizeText: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  DefaultText(
                    sizeText: 12,
                    fontWeight: FontWeight.bold,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    textLabel: _matchesNext[index].strTime,
                    colorsText: Colors.blueGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultText(
                        sizeText: 16,
                        fontWeight: FontWeight.bold,
                        textLabel: _matchesNext[index].strHomeTeam,
                      ),
                      DefaultText(
                        sizeText: 16,
                        fontWeight: FontWeight.bold,
                        textLabel: _matchesNext[index].strAwayTeam,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultText(
                        sizeText: 16,
                        fontWeight: FontWeight.bold,
                        textLabel: _matchesNext[index].intHomeScore == null
                            ? ' '
                            : _matchesNext[index].intHomeScore,
                      ),
                      DefaultText(
                        sizeText: 16,
                        fontWeight: FontWeight.bold,
                        textLabel: _matchesNext[index].intAwayScore == null
                            ? ' '
                            : _matchesNext[index].intHomeScore,
                      )
                    ],
                  )
                ],
              ),
            ]),
          );
        });
  }

  apiMatches(String tabs, String league) {
    if (league.isEmpty) league = "4328";
    isLoading = true;
    _matches = [];
    setState(() {});
    Api.createDefaultParams((parameter) {
      Api(context).execute('${tabs}$league', false, parameter, (response) {
        isLoading = false;
        print(response.data()['events']);
        List match = response.data()['events'];
        _matches.clear();
        match.forEach((element) {
          _matches.add(MatchModel.fromJson(element));
          print('matched >> $element');
        });

        setState(() {});
      });
    });
  }

  apiMatchesNext(String tabs, String league) {
    if (league.isEmpty) league = "4328";
    isLoading = true;
    _matchesNext = [];
    Api.createDefaultParams((parameter) {
      Api(context).execute('${tabs}$league', false, parameter, (response) {
        isLoading = false;
        print(response.data()['events']);
        List match = response.data()['events'];
        _matchesNext.clear();
        match.forEach((element) {
          _matchesNext.add(MatchModel.fromJson(element));
          print('matched >> $element');
        });

        setState(() {});
      });
    });
  }
}
