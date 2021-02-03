import 'dart:convert';

import '../api.dart';
import '../result.dart';

class SuccessAsString extends Result{
  String _data;

  SuccessAsString(Api api, String data) : super(api){
    this._data = data;
  }

  String data() {
    return this._data;
  }
}