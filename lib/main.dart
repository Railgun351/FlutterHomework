import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_practice/PageIndexController.dart';
import 'package:simple_practice/ResultController.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ResultController()),
      ChangeNotifierProvider(create: (_) => PageIndexController())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Dummy(),
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {



  @override
  Widget build(BuildContext context) {
    final writeResultController = context.read<ResultController>();
    final readResultController = context.watch<ResultController>();
    final writePageController = context.read<PageIndexController>();
    final readPageController = context.watch<PageIndexController>();
    final deW = MediaQuery.of(context).size.width;
    final deH = MediaQuery.of(context).size.height;
    final btnW = deW / 4;
    final btnH = deH / 6;
    final textSize = 0.5 * (btnH > btnW ? btnW : btnH);

    List _items = [
      buildSafeArea(readResultController, textSize, writeResultController, btnH, btnW),
      SafeArea(child: Container(
        color: Colors.green,
        width: deW,
        height: deH,
        alignment: Alignment.center,
        child: const Text("미구현 >_<", style: TextStyle(fontSize: 150),),
      )),
      SafeArea(child: Container(
        color: Colors.red,
        width: deW,
        height: deH,
        alignment: Alignment.center,
        child: const Text("미구현 >_<", style: TextStyle(fontSize: 150),),
      )),SafeArea(child: Container(
        color: Colors.blue,
        width: deW,
        height: deH,
        alignment: Alignment.center,
        child: const Text("미구현 >_<", style: TextStyle(fontSize: 150),),
      )),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: readPageController.newIndex,
        onTap: (index) => writePageController.changeTo(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "일반계산기"),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: "공학용계산기"),
          BottomNavigationBarItem(icon: Icon(Icons.square_foot), label: "단위변환"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "날짜계산"),
        ],
      ),
      // body: buildSafeArea(readResultController, textSize, writeResultController, btnH, btnW),
      body: _items[readPageController.newIndex],
    );
  }



  SafeArea buildSafeArea(ResultController readResultController, double textSize, ResultController writeResultController, double btnH, double btnW) {
    return SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            alignment: Alignment.centerRight,
            child: Text(
              readResultController.resultText,
              style: TextStyle(fontSize: textSize),
              textAlign: TextAlign.right,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "C", Colors.cyan),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "←", Colors.cyan),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "%", Colors.cyan),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "÷", Colors.cyan),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "7", Colors.white70),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "8", Colors.black12),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "9", Colors.white70),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "x", Colors.cyan),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "4", Colors.black12),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "5", Colors.white70),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "6", Colors.black12),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "-", Colors.cyan),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "1", Colors.white70),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "2", Colors.black12),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "3", Colors.white70),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "+", Colors.cyan),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(btnH)),
                      minimumSize: Size(btnW, btnH)),
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: textSize),
                  )),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, "0", Colors.white70),
              _buildCalcNumButton(
                  writeResultController, btnH, btnW, textSize, ".", Colors.black12),
              _buildCalcButton(
                  writeResultController, btnH, btnW, textSize, "=", Colors.cyan),
            ],
          )
        ],
      )),
    );
  }

  ElevatedButton _buildCalcButton(ResultController writeResultController,
      double btnH, double btnW, double textSize, String text, Color c) {
    return ElevatedButton(
        onPressed: () => writeResultController.callback(text),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnH)),
            minimumSize: Size(btnW, btnH),
            backgroundColor: c),
        child: Text(
          text,
          style: TextStyle(fontSize: textSize),
        ));
  }

  OutlinedButton _buildCalcNumButton(ResultController writeResultController,
      double btnH, double btnW, double textSize, String text, Color c) {
    return OutlinedButton(
        onPressed: () => writeResultController.callback(text),
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnH)),
            minimumSize: Size(btnW, btnH),
            backgroundColor: c),
        child: Text(
          text,
          style: TextStyle(fontSize: textSize),
        ));
  }
}
