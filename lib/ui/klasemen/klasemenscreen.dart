import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/constant.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/model/klasemenmodel.dart';
import 'package:flutter_app/util/network/api.dart';

class KlasemenScreen extends StatefulWidget {
  @override
  _KlasemenScreen createState() => _KlasemenScreen();
}

class _KlasemenScreen extends State<KlasemenScreen> {
  int number;
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

  List<KlasemenModel> _klasemenModel = [];

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
                        apiKlasemen(_leagueId, yearStr);
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
          isLoading ? Center(child: CircularProgressIndicator()) :
          Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  margin: EdgeInsets.only(top: 10, bottom: 8, left: 2, right: 2),
                  height: 50,
                ),
                table()
          ])
        ],
      ),
    );
  }

  Widget table() {
    for(number=1 ; number <= _klasemenModel.length ; number++) {
      return isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 70,
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
          rows: _klasemenModel.map((e) =>
              DataRow(cells: [
                DataCell(Text('${number++}')),
                DataCell(Text(e.name)),
                DataCell(Text(e.played.toString())),
                DataCell(Text(e.goalsfor.toString())),
                DataCell(Text(e.goalsagainst.toString())),
                DataCell(Text(e.goalsdifference.toString())),
                DataCell(Text(e.win.toString())),
                DataCell(Text(e.draw.toString())),
                DataCell(Text(e.loss.toString())),
                DataCell(Text(e.total.toString())),
              ])).toList(),
        ),
      );
    }
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

  apiKlasemen(String league, String year) {
    isLoading = true;
    Api.createDefaultParams((parameter) {
      Api(context).execute('api/v1/json/1/lookuptable.php?l=$league&s=$year', false, parameter, (response) {
        isLoading = false;
        print(response.data()['table']);
        List klasemen = response.data()['table'];
        _klasemenModel.clear();
        klasemen.forEach((element) {
          _klasemenModel.add(KlasemenModel.fromJson(element));
        });

        setState(() {});
      });
    });
  }
}
