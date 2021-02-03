import 'package:flutter/cupertino.dart';

import 'api.dart';


class Result {
  Api _api;

  Result(Api api){
   this._api = api;
  }

  Api get api => _api;



}