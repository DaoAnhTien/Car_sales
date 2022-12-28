import 'package:flutter/material.dart';

urlEncode({
  @required String? text
}) {
  String? output = text;

  var detectHash = text!.contains('#');
  var detectAnd = text.contains('&');
  var detectSlash = text.contains('/');
  var detectPlus= text.contains('+');

  if (detectHash == true) {
    output = output!.replaceAll('#', '%23');
  }

  if (detectAnd == true) {
    output = output!.replaceAll('#', '%26');
  }

  if (detectSlash == true) {
    output = output!.replaceAll('#', '%2F');
  }

  if(detectPlus ==true) {

    output = output!.replaceAll('+', '%2B');
  }
  return output;
}