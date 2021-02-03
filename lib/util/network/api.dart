import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import '../ui.dart';
import 'config.dart';
import 'parameter.dart';
import 'package:http/http.dart' as http;
import 'loader.dart';
import 'result/error.dart';
import 'package:path/path.dart' as path;
import 'paginator.dart';
import 'result/success.dart';
import 'result/successAsList.dart';
import 'result/successAsString.dart';

class Api {
  BuildContext _context;
  OnSuccessListener _onSuccessListener;
  OnSuccessListListener _onSuccessListListener;
  OnSuccessStringListener _onSuccessStringListener;
  OnErrorListener _onErrorListener;
  OnExceptionListener _onExceptionListener;
  OnCompleteListener _onCompleteListener;
  String _appName = 'sss';
  Loader _loader;
  bool _isLoading;
  bool _isShowDialog;
  Paginator _paginator;
  bool isDataAsList = false;
  bool isDataAsString = false;
  Duration timeoutDuration = Duration(minutes: 3);

  Api(BuildContext _context) {
    this._context = _context;
    _loader = new Loader(_context);
    _isLoading = true;
    _isShowDialog = true;
  }

  Api setSuccessListener(OnSuccessListener _onSuccessListener) {
    this._onSuccessListener = _onSuccessListener;
    return this;
  }

  Api setSuccessListListener(OnSuccessListListener _onSuccessListListener) {
    this._onSuccessListListener = _onSuccessListListener;
    return this;
  }

  Api setErrorListener(OnErrorListener _onErrorListener) {
    this._onErrorListener = _onErrorListener;
    return this;
  }

  Api setLoading(bool _isLoading) {
    this._isLoading = _isLoading;
    return this;
  }

  Api setExceptionListener(OnExceptionListener _onExceptionListener) {
    this._onExceptionListener = _onExceptionListener;
    return this;
  }

  Api setCompleteListener(OnCompleteListener _onCompleteListener) {
    this._onCompleteListener = _onCompleteListener;
    return this;
  }

  Api setIsShowDialog(bool value) {
    this._isShowDialog = value;
    return this;
  }

  Paginator createPaginator() {
    this._paginator = new Paginator(this);
    return this._paginator;
  }

  Paginator getPaginator() {
    return this._paginator;
  }

  static createDefaultParams(OnCreateDefaultParamsListener callback) async {
    Parameter params = createParams();
    callback(params);
  }

  static Parameter createParams() {
    Parameter params = new Parameter();
    return params;
  }

  BuildContext get context => _context;

  String _getUrl(String _method) {
    return Config.baseUrl + _method;
  }

  execute(String _method,bool isGet, Parameter _parameter,
      OnSuccessListener _onSuccessListener,
      {OnSuccessListListener onSuccessListListener,
        OnSuccessStringListener onSuccessStringListener}) async {
    int _errCode = 0;
    String _errMessage = '';

    if (_onSuccessListener != null) {
      this._onSuccessListener = _onSuccessListener;
    }

    if (onSuccessListListener != null) {
      this._onSuccessListListener = onSuccessListListener;
    }
    if (onSuccessStringListener != null) {
      this._onSuccessStringListener = onSuccessStringListener;
    }

    if (this._onErrorListener == null) {
      this._onErrorListener = (error) {

        Ui(context).errorAlert(title: 'Oops', message: error.errMessage);

      };
    }

    if (this._onExceptionListener == null) {
      this._onExceptionListener = (ex) {
        String msg = ex.toString().replaceAll("Exception: ", "");
        // if (ex is SocketException) {
        msg = "No Connection Found \r\n Please check your network connection.";
        // }

        Ui(context).errorAlert(title: 'Oops', message: msg);

      };
    }

    if (_errCode == 0) {
      if (_method == null || _method.isEmpty) {
        _errCode++;
        _errMessage = 'Method empty';
      }
    }

    if (_errCode == 0) {
      if (_parameter == null) {
        _errCode++;
        _errMessage = 'Parameter empty';
      }
    }

    if (_errCode == 0) {
      if (this._paginator != null) {
        this
            ._paginator
            .setOnSuccessPaginator(this._onSuccessListener)
            .setup(_method, isGet, _parameter);
      }
    }

    var requestParams = "";
    var index = 0;

    _parameter.data.forEach((key, val) {
      index++;
      requestParams += "$key=$val${index == _parameter.data.length ? '' : '&'}";
    });
    // print("Requestnya ${Config.baseUrl}$_method?$requestParams");

    try {
      if (_errCode == 0) {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          executeFuture(_method,isGet, _parameter, _onSuccessListener).then((body) {
            try {
              // print('body${body}');
            } on FormatException catch (ex) {
              print('FormatException $_method : ${ex.message}');
              print(body);
            }

            if (body != null){
              Map item = jsonDecode(body);
              if (_loader.isLoading()) {
                _loader.dismisLoader();
              }

              // print('body hasil ${item['code'] is String}');
              int code = 200;
              if (item['status'] is String){
                code = int.parse(item['status']);
              }else if (item['status'] is int){
                code = item['status'];
              }
              if (code == 200) {
                if (_method == '/api/login'){
                  Map response = item['data'];
                  String apisess = response['apisess'];
                  // print('token == > $token');
                  // Preferences.setApisess(apisess);
                }

                if (item['data'] is List) {
                  SuccessAsList success =
                  new SuccessAsList(this, item['data']);
                  this._onSuccessListListener(success);
                } else if (item['data'] is String) {
                  SuccessAsString success =
                  new SuccessAsString(this, item['data']);
                  this._onSuccessStringListener(success);
                } else {
                  Success success = new Success(this, item);
                  this._onSuccessListener(success);
                }
              } else {
                _handleResponseError('${item['code']}', item['message'], _method, _parameter, _onSuccessListener);
                this._onErrorListener(new Error(this, item['code'] is String ? int.parse(item['code']) : item['code'], "${item['message']}"));
              }

              if (this._onCompleteListener != null) {
                this._onCompleteListener();
              }
            }


          }).timeout(timeoutDuration, onTimeout: () {
            this._onErrorListener(new Error(this,199,'Time Out'));
            _handleResponseError(
                null, null, _method, _parameter, _onSuccessListener);
          });
        } else {
          _errCode++;
          _errMessage = 'No Akses';
        }
      }
    } on SocketException catch (_) {
      _errCode++;
      _errMessage = 'No Internet';
    } catch (e) {
      _errCode++;
      _errMessage = 'No Internet';
    }

    if (_errCode > 0) {
      try {
        throw new Exception(_errMessage);
      } catch (ex) {
        this._onExceptionListener(ex);
      }
    }
  }


  Map<String, String> get headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer 344f105788186775ae6755a0e91d2a3a961e272ac5fc262f83460b2ac085fd82",
  };

  Future<String> executeFuture(String _method,bool isGet, Parameter _parameter,
      OnSuccessListener _onSuccessListener) async {
    // var request = http.post(Uri.parse(_getUrl(_method)),headers: {HttpHeaders.authorizationHeader: "Bearer e233df41ffb1bf15236d40f2a524bd5596913449924c8476903182c49a83c7c5"},body: jsonEncode(_parameter));
    //
    // String token = Constant.token;
    // if (token == null) {
    //   token = 'MZ5ALEkb24JY76njnVlY7FJhr8b6kIdOV6ReYr8w9QqR9AbWf6s';
    // }
    if (isGet){

      var requestParams = "";
      var index = 0;

      _parameter.data.forEach((key, val) {
        index++;
        requestParams += "$key=$val${index == _parameter.data.length ? '' : '&'}";
      });
      // if(Config.environment == Env.development){
      //   print("Request ${Config.baseUrl}$_method?$requestParams");
      // }
      // print(request.fields);

      final http.Response response = await http.get('${_getUrl(_method)}?$requestParams',headers: <String,String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        // "Accept": "application/json",
        // // 'Authorization': 'Bearer $token',
        // 'Authorization': 'Bearer ${Config.bearer}',
      });

      Map item = jsonDecode(response.body);

      if (response != null) {
        if (response.statusCode == 200) {
          if (response.body != null) {
            return response.body;
          }
        }
        else {


          this._onErrorListener(new Error(this, response.statusCode, "${item['message']}"));
          _handleResponseError(response.statusCode.toString(), item['message'],
              _method, _parameter, _onSuccessListener);
        }

      }
      else {
        this._onErrorListener(new Error(this, response.statusCode, "${item['message']}"));
        _handleResponseError(response.statusCode.toString(), item['message'],
            _method, _parameter, _onSuccessListener);
      }

    }else{

      var request = http.MultipartRequest("POST", Uri.parse(_getUrl(_method)));
      request.headers.addAll(<String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        // "Accept": "application/json",
        // // 'Authorization': 'Bearer $token',
        // 'Authorization': 'Bearer ${Config.bearer}',
      });
      _parameter.data.forEach((k, v) async {
        if (v is File) {
          File file = v as File;
          if (file.existsSync()) {
            String pathh = file.path;
            String basename = path.basename(
                pathh.substring(0, pathh.lastIndexOf(".") + 1) +
                    getMimeType(pathh));
            var stream =
            new http.ByteStream(DelegatingStream.typed(file.openRead()));
            var length = file.lengthSync();
            http.MultipartFile multipartFile =
            new http.MultipartFile("$k", stream, length, filename: basename);
            request.files.add(multipartFile);
          }
        } else {
          if (v != null) {
            request.fields[k] = '$v';
          }
        }
      });


      try {
        var response = await request.send().timeout(timeoutDuration, onTimeout: (){
          _handleResponseError(
              null, null, _method, _parameter, _onSuccessListener);
          return;
        });

        String body = await response.stream.bytesToString();

        Map item = jsonDecode(body);

        if (response != null) {
          if (response.statusCode == 200) {
            if (body != null) {
              return body;
            }
          }
          else {
            this._onErrorListener(new Error(this, response.statusCode, "${item['message']}"));
            _handleResponseError(response.statusCode.toString(), item['message'],
                _method, _parameter, _onSuccessListener);
          }
        }
        else {
          this._onErrorListener(new Error(this, response.statusCode, "${item['message']}"));
          _handleResponseError(response.statusCode.toString(), item['message'],
              _method, _parameter, _onSuccessListener);
        }

      } catch (exp) {
        if (_onExceptionListener != null && exp is Exception) {
          _onExceptionListener(exp);
        }
      }

    }
  }

  void _showAlert(String error) {
    Widget _button() {
      return new FlatButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(_context).pop(); // Dismiss alert dialog
        },
      );
    }

    showDialog(
      context: _context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Platform.isAndroid
            ? AlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            error,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            _button(),
          ],
        )
            : CupertinoAlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            error ?? '',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            _button(),
          ],
        );
      },
    );
  }

  String getMimeType(String path) {
    String extension = path.substring(path.lastIndexOf(".") + 1);
    return extension.toLowerCase();
  }

  void _handleResponseError(String code, String message, String _method,
      Parameter _parameter, OnSuccessListener _onSuccessListener) {
    if (_loader.isLoading()) {
      _loader.dismisLoader();
    }

    String errCode = "";
    String errMessage = "";

    if (!Config.isProduction) {
      errCode = ". " +
          (errCode + " ") +
          (code != null && code.isNotEmpty ? code : " 0");
    }



    if (code != null && code.isNotEmpty) {
      if(!Config.isProduction){
        errMessage = message + errCode;
      }else{
        errMessage = message;
      }
    } else {
      errMessage = 'No Internet Akses' + errCode;
    }

    if (this._isShowDialog) {
      // Ui(context).errorAlert(title: 'Oops', message: errMessage);
      // Ui(context).showToast(errMessage, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // Ui(context).alertPopUp(message: errMessage,isSuccess: false,color: Colors.red);
    } else {
      if (code == null || code.isEmpty) {
        code = "0";
      }
      this._onErrorListener(new Error(this, int.parse(code), errMessage));
    }
  }

  List<Widget> _actionButton(
      BuildContext dialogContext,
      String _response,
      String _method,
      bool isGet,
      Parameter _parameter,
      OnSuccessListener _onSuccessListener) {
    return [
      new FlatButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(dialogContext).pop(); // Dismiss alert dialog
        },
      ),
      new FlatButton(
        child: Text(
          'Reload',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(dialogContext).pop(); // Dismiss alert dialog
          execute(_method,isGet, _parameter, _onSuccessListener);
        },
      ),
      if (!Config.isProduction)
        new FlatButton(
          child: Text(
            'View Error',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(dialogContext).pop();
            _showAlert(_response);
          },
        ),
    ];
  }

  Widget _bodyError(String message) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Center(
              //     child: Image.asset(
              //       Assets.img_error,
              //       height: 150,
              //     )),
              Container(
                height: 10,
              ),
              Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _showPopupDialog(String message, String _response, String _method,bool isGet,
      Parameter _parameter, OnSuccessListener _onSuccessListener) {
    showDialog(
      context: _context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: _bodyError(message),
          actions: _actionButton(dialogContext, _response, _method,isGet, _parameter,
              _onSuccessListener),
        );
      },
    );
  }
}

typedef OnSuccessListener = void Function(Success response);

typedef OnSuccessListListener = void Function(SuccessAsList response);
typedef OnSuccessStringListener = void Function(SuccessAsString response);

typedef OnErrorListener = void Function(Error error);

typedef OnExceptionListener = void Function(Exception ex);

typedef OnCompleteListener = void Function();
typedef OnCreateDefaultParams2Listener = void Function(Parameter parameter);
typedef OnCreateDefaultParamsListener = void Function(Parameter parameter);
