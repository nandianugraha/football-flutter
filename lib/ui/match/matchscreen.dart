import 'package:flutter/material.dart';
import 'package:flutter_app/util/color.dart';
import 'package:flutter_app/util/defaultText.dart';
import 'package:flutter_app/util/helper.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreen createState() => _MatchesScreen();
}

class _MatchesScreen extends State<MatchesScreen> {

  List matches = ["Liga 1","Liga 2","Liga 3","Liga 4"];

  final _searchController = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _matches;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _dropDownMenuItems = getDropDownMenuItems();
    _matches = _dropDownMenuItems[0].value;
    // searchListener();
    // setState(() {
    //   _searchController.addListener(() {
    //     searchListener();
    //   });
    // });
  }

  searchListener() {
    print(_searchController.text);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String _matches in matches) {
      isLoading = false;
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: _matches, child: new Text(_matches)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool isSearch = false;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
           appBar: AppBar(
             actions: [
               GestureDetector(
                 onTap: () => Helper.searchBottom(context, _searchController, (){searchListener();}),
                   child: Icon(Icons.search))
             ],
             backgroundColor: Colors.blueGrey,
             title: DefaultText(textLabel: 'Matches',),
             bottom: TabBar(
               tabs: [
                 Tab(text: 'LAST MATCH',),
                 Tab(text: 'NEXT MATCH',),
               ],
             ),
           ),
           body: TabBarView(
             children: [
               listDokterGigi(),
               listDokterGigi()
             ],
           )
        ),
      ),
    );
  }

  void changedDropDownItem(String matches) {
    print("matches = $matches");
    setState(() {
      _matches = matches;
    });
  }

  Widget listDokterGigi() {
    final namaDokter = [
      "Nandia, drg.",
      "Nandia Ganteng, drg.",
      "Nandia Ganteng Sekali, drg.",
      "Nandia Ganteng Banget, drg."
    ];
    final descDokter = [
      "S1/Sarjana dan PROFESI, Fakultas Kedokteran Gigi Universitas Trisakti program studi Kedokteran Gigi",
      "S1/Sarjana dan PROFESI, Fakultas Kedokteran Gigi Universitas Trisakti program studi Kedokteran Gigi",
      "S1/Sarjana dan PROFESI, Fakultas Kedokteran Gigi Universitas Trisakti program studi Kedokteran Gigi",
      "S1/Sarjana dan PROFESI, Fakultas Kedokteran Gigi Universitas Trisakti program studi Kedokteran Gigi"
    ];
    final harga = [
      "Rp.100.000",
      "Rp.100.000",
      "Rp.100.000",
      "Rp.100.000"
    ];

    return ListView.builder(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Stack(children: [
            Column(
              children: [
                DefaultText(
                  padding: EdgeInsets.all(4),
                  colorbackground: Colors.blueGrey,
                  margin: EdgeInsets.only(top: 6, left: 280),
                  textLabel: 'satu',
                  colorsText: ColorsState.white,
                  sizeText: 10,
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, right: 8),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.info_outline, color: Colors.blueGrey)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color:Colors.blueGrey)),
              child: GestureDetector(
                // onTap: () => Scaffold.of(context).showSnackBar(Ui.snackbar(context, 'Coming soon!', 'OK', (){})),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              margin: EdgeInsets.only(top: 8),
                              textLabel: '${namaDokter[index]}',
                              fontWeight: FontWeight.bold,
                              sizeText: 14.0,
                              colorsText: ColorsState.backgroundColor,
                            ),
                            SizedBox(
                                width: 280,
                                child: DefaultText(
                                  maxLines: 2,
                                  textAlign: TextAlign.justify,
                                  textOverflow: TextOverflow.ellipsis,
                                  margin: EdgeInsets.only(top: 4),
                                  sizeText: 12.0,
                                  colorsText: Colors.grey,
                                  textLabel:
                                  '${descDokter[index]}',
                                )),
                            DefaultText(
                              margin: EdgeInsets.only(top: 4),
                              textLabel:
                              '${harga[index]}',
                              fontWeight: FontWeight.bold,
                              sizeText: 13,
                              colorsText: Colors.blueGrey,
                            ),
                            DefaultText(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                              padding: EdgeInsets.all(4),
                              border: Border.all(
                                  color: ColorsState.backgroundColor),
                              margin: EdgeInsets.only(top: 4, left: 185),
                              textLabel: 'KONSULTASI SEKARANG',
                              colorsText: ColorsState.backgroundColor,
                              sizeText: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]);
        });
  }

}
