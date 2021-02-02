import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/myRouter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

import 'color.dart';
import 'defaultText.dart';


class Ui {

  BuildContext context;

  Ui(this.context);

  static Ui of(BuildContext context) {
    return Ui(context);
  }

  static Widget shimmer({
    double height = 48,
    double width = 48,
    double borderRadius = 0,
    Color baseColor,
    Color highlightColor,
    EdgeInsets margin = const EdgeInsets.all(0),
    ShimmerDirection direction = ShimmerDirection.ltr,
  }){
    return Padding(
      padding: margin,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[200],
        highlightColor: highlightColor ?? Colors.grey[300],
        direction: direction,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }
  static Widget appBar({Color color, String title}) {
    return AppBar(
      backgroundColor: color,
      title: DefaultText(
        textLabel: title,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

    successAlert({String title = '', String message = '', int duration = 3}){
    _alert(title: title, message: message, duration: duration);
  }

  errorAlert({String title = '', String message = '', int duration = 3}){
    _alert(title: title, message: message, duration: duration, isSuccess: false);
  }

  static Widget snackbar(context, String content, String label, Function action) {

    return SnackBar(
      content: DefaultText(textLabel: content,),
      action: SnackBarAction(
        label: label,
        onPressed: () => action
      ),
    );
  }

  _alert({String title = '', String message = '', int duration = 3, bool isSuccess = true}){
    Flushbar(
      title: title,
      messageText: Text(message,
        maxLines: 10,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      duration: Duration(seconds: duration),
      backgroundColor: isSuccess ? Colors.orange : Color(0xFF303030),
      flushbarPosition: isSuccess ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    )..show(context);
  }

  alertPopUp({String message,bool isSuccess, Color color}){
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          backgroundColor: color,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                      color: ColorsState.white,
                    ),
                    padding: EdgeInsets.all(25),
                    child: Text(message)),
                GestureDetector(
                  onTap: (){
                    myRouter.pop(context);
                    if (isSuccess) {
                      myRouter.pop(context);
                    }
                  },
                  child: DefaultText(
                    padding: EdgeInsets.all(20),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    textLabel: isSuccess ? "Ok" : "Close",
                    colorsText: Colors.white,
                    colorbackground: color,
                  ),
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(20),
        ));

  }

  dialogPopUp({String title,String buttonText,String content,Function onTap,bool isSuccess}){

    Color color = isSuccess ? Colors.greenAccent : ColorsState.colorPrimaryRed;

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height:60,
                  width: 60,
                  margin: EdgeInsets.only(top: 40),
                  child: Icon(isSuccess ? Icons.check : Icons.warning_amber_outlined),
                ),
                DefaultText(
                 textLabel: title,
                 margin: EdgeInsets.only(top: 8),
                 alignment: Alignment.center,
                 width: MediaQuery.of(context).size.width,
                  colorsText: color,
                  fontWeight: FontWeight.bold,
                  sizeText: 16,
                ),
                DefaultText(
                  textLabel: content,
                  margin: EdgeInsets.only(top: 8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  colorsText: Colors.grey,
                  sizeText: 14,
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: RaisedButton(onPressed: onTap,
                    color: color,
                    child: DefaultText(
                      textLabel: buttonText == null ? 'Ok' : buttonText,
                      colorsText: Colors.white,
                    ),
                  ),
                ),

                // Container(
                //     alignment: Alignment.center,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                //       color: ColorsState.white,
                //     ),
                //     padding: EdgeInsets.all(25),
                //     child: Text(message)),

                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: onOke,
                //         child: DefaultText(
                //           padding: EdgeInsets.all(20),
                //           border: Border.all(color: !isNext ? Colors.black  : ColorsState.colorPrimaryBlue,width: 0.5) ,
                //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                //           alignment: Alignment.center,
                //           width: MediaQuery.of(context).size.width,
                //           textLabel: "Yes",
                //           colorsText: isNext ? Colors.white : Colors.black,
                //           colorbackground: isNext ? ColorsState.colorPrimaryBlue : Colors.white,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: onCancel,
                //         child: DefaultText(
                //           padding: EdgeInsets.all(20),
                //           border:  Border.all(color: isNext ? Colors.black : Colors.red,width: 0.5) ,
                //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
                //           alignment: Alignment.center,
                //           width: MediaQuery.of(context).size.width,
                //           textLabel: "No",
                //           colorsText: !isNext ? Colors.black : Colors.black,
                //           colorbackground: !isNext ? Colors.red : Colors.white,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(20),
        ));
  }



}

