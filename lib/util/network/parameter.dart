import 'dart:collection';
import 'dart:convert';

class Parameter {
  Map<String, Object> data;
  Parameter() {
    this.data = new HashMap();
  }

  Parameter set(String key, Object value) {
    data[key] = value;
    return this;
  }

  Map<String, Object> getData() {
    return data;
  }

  String getJson() {
    String result = json.encode(data);
    return result;
  }

  setData(Map<String, Object> data){
    this.data = data;
  }
}

