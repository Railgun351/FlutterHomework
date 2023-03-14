import 'package:flutter/cupertino.dart';

class ResultController with ChangeNotifier {
  String _resultText = "0";
  bool isFirst = true;
  bool canAddDot = true;

  String get resultText => _resultText;

  void changeTo(String str){
    _resultText = str;
    notifyListeners();
  }

  void cal() {
    var str = _resultText.split("");
    var temp = "";
    var calSym = "";
    var result = 0.0;
    var firstNum = true;
    for (int i = 0; i < str.length; i++) {
      if (isDouble(str[i]) || str[i] == ".") {
        temp = "$temp${str[i]}";
      } else {
        if (calSym == "") {
          calSym = str[i];
          if (firstNum) {
            result = double.parse(temp);
            !firstNum;
          }
        } else {
          switch (calSym) {
            case "+":
              result = result + double.parse(temp);
              break;
            case "-":
              result -= double.parse(temp);
              break;
            case "x":
              result *= double.parse(temp);
              break;
            case "÷":
              result /= double.parse(temp);
              break;
          }
          calSym = str[i];
        }
        temp = "";
      }
      // alert("${str[i]}/$calSym", "$temp/$result");
    }
    switch (calSym) {
      case "+":
        result += double.parse(temp);
        break;
      case "-":
        result -= double.parse(temp);
        break;
      case "x":
        result *= double.parse(temp);
        break;
      case "÷":
        result /= double.parse(temp);
        break;
    }
    changeTo(result.toString());
    isFirst = true;
  }

  void calTest() {
    String lastWord =
    _resultText.substring(_resultText.length - 1, _resultText.length);
    String firstWord = _resultText.substring(0, 1);
    if (lastWord != "+" &&
        lastWord != "-" &&
        lastWord != "x" &&
        lastWord != "÷" &&
        firstWord != "+" &&
        firstWord != "-" &&
        firstWord != "x" &&
        firstWord != "÷") {
      if (_resultText.contains("+") ||
          _resultText.contains("-") ||
          _resultText.contains("x") ||
          _resultText.contains("÷")) {
        cal();
      } else {
        changeTo("연산기호가 없습니다.");
        isFirst = true;
        canAddDot = true;
      }
    } else {
      changeTo("식이 올바르지 않습니다.");
      isFirst = true;
      canAddDot = true;
    }
  }

  void calPercent(){
    if(isDouble(_resultText)){
      var temp = double.parse(_resultText);
      String str = (temp*100.0).toString();
      changeTo("$str%");
    }
  }

  void callback(String str) {
    switch (str) {
      case "0":
        if (_resultText == "0") {
          changeTo("0");
        } else if(isFirst){
          changeTo("0");
        } else{
          changeTo(_resultText+str);
        }
        break;
      case ".":
        if (canAddDot) {
          changeTo(_resultText+str);
          isFirst = false;
          canAddDot = false;
        }
        break;
      case "C":
        changeTo("0");
        isFirst = true;
        canAddDot = true;
        break;
      case "←":
        if (_resultText.length > 1) {
          changeTo(_resultText.substring(0, _resultText.length - 1));
        } else {
          changeTo("0");
        }
        break;
      case "=":
        calTest();
        canAddDot = true;
        isFirst = true;
        break;
      case "%":
        calPercent();
        canAddDot = true;
        isFirst = true;
        break;
      default:
        if(!isDouble(str)){
          canAddDot = true;
        }
        if (!isFirst) {
          changeTo(_resultText+str);
        } else {
          changeTo(str);
          isFirst = false;
        }
        break;
    }
  }

  bool isDouble(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}