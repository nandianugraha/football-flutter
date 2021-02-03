import 'dart:convert';

import '../api.dart';
import '../result.dart';

class SuccessAsList extends Result{
  List<dynamic> _data;

  SuccessAsList(Api api, List<dynamic> data) : super(api){
    this._data = data;
  }

  List<dynamic> data() {
    return this._data;
  }
}