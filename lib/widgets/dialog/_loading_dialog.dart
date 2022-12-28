import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oke_car_flutter/widgets/loading_animation.dart';

class DialogCustom {
  Future showLoading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => LoadingCircle(
              radius: 16,
              dotRadius: 12,
            ));
  }

  void showAlertDialog(BuildContext context, String message,
      {String? title, GestureTapCallback? onPress}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title ?? "notification"),
              content: Text(message),
              // actions: <Widget>[
              //   FlatButton(child: TextNormal("ok"), onPressed: (){
              //     if(onPress != null){
              //       pop(context);
              //       onPress();
              //     }else{
              //       pop(context);
              //     }
              //   } ,)
              // ],
            ));
  }
}
