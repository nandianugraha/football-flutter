import 'dart:collection';

import 'dart:convert';

class ParameterString {
  Map<String,String> data;

  ParameterString() {
    this.data = new HashMap();
  }

  ParameterString set(String key, String value) {
    data[key] = value;
    return this;
  }

  Map<String, String> getData() {
    return data;
  }

  String getJson() {
    String result = json.encode(data);
    return result;
  }

  setData(Map<String, String> data){
    this.data = data;
  }

}