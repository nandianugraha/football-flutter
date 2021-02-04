import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/constant.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/network/api.dart';

class KlasemenScreen extends StatefulWidget {
  @override
  _KlasemenScreen createState() => _KlasemenScreen();
}

class _KlasemenScreen extends State<KlasemenScreen> {
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
  List _year = ['2017-2018', '2018-2019', '2019-2020', '2020-2021'];

  String yearStr = '2020-2021';
  String _leagueId = '4328';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiKlasemen(_leagueId, yearStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: DefaultText(
            textLabel: "Klasemen",
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : dropDownLeague());
  }

  Widget dropDownLeague() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
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
                        apiKlasemen(newVal, yearStr);
                        // apiListTeams(_leagueId);
                      });
                    },
                    value: _leagueId == null ? '4328' : _leagueId,
                  ),
                ),
              ),
              Container(
                width: 125,
                margin: EdgeInsets.only(top: 12, right: 20),
                padding: EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: DefaultText(
                      textLabel: "Year...",
                    ),
                    items: _year.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        yearStr = newVal;
                        print(newVal);
                        apiKlasemen(_leagueId, newVal);
                      });
                    },
                    value: yearStr == null ? '2020-2021' : yearStr,
                  ),
                ),
              ),
            ],
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : table()
        ],
      ),
    );
  }

  Widget table() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          _column('No.'),
          _column('CLUB NAME'),
          _column('PLAYED'),
          _column('GF'),
          _column('GA'),
          _column('GD'),
          _column('W'),
          _column('D'),
          _column('L'),
          _column('TOTAL'),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Arya')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
            DataCell(Text('6')),
          ]),
          DataRow(cells: [
            DataCell(Text('12')),
            DataCell(Text('John')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
            DataCell(Text('9')),
          ]),
          DataRow(cells: [
            DataCell(Text('42')),
            DataCell(Text('Tony')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
            DataCell(Text('8')),
          ]),
        ],
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

  _column(String label) {
    return DataColumn(label: Text(label));
  }

  apiKlasemen(String league, String year){
    Constant.league = league;
    Constant.year = year;
    Api.createDefaultParams((parameter) {
      Api(context).execute(Constant.API_klasemen, false, parameter, (response) {
        print(response.data()['table']);
        setState(() {

        });
      });
    });
  }
}
