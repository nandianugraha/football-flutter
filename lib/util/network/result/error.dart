import '../result.dart';
import '../api.dart';

class Error extends Result {
  int _errCode;
  String _errMessage;
  Error(Api api, int errCode, String errMessage) : super(api) {
    this._errCode = errCode;
    this._errMessage = errMessage;
  }

  String get errMessage => _errMessage.replaceAll("Exception: ", "");

  int get errCode => _errCode;


}