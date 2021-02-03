import 'dart:convert';

import '../api.dart';
import '../result.dart';

class Success extends Result{
  Map _data;

  Success(Api api, Map data) : super(api){
    this._data = data;
  }

  Map data() {
    return this._data;
  }
}