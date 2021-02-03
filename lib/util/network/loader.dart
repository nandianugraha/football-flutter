import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class Loader {
  BuildContext _context;
  BuildContext context;
  bool _loadingIsExist = false;


  Loader(BuildContext _context) {
    this._context = _context;
    //_loadingIsExist = true;
//    _showLoader();
  }

  bool isLoading() {
    return _loadingIsExist;
  }

  void showLoader() {
    _loadingIsExist = true;
    showDialog(
      context: _context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        context = dialogContext;
        return new Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Container(
              height: 5,
              child: LinearProgressIndicator(),
            )
            // new Image(
            //   image: new AssetImage(Assets.loading),
            //   height: 60,
            //   width: 60,
            // ),
          ],
        );
      },
    );
  }

  void dismisLoader() {
    _loadingIsExist = false;
    Navigator.of(context, rootNavigator: true).pop();
//    Navigator.pop(_context);
  }
}
