import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/home/components/home_component_graphics.dart';
import 'package:flutter_responsive_dashboard/utilities/responsives.dart';
import 'package:flutter_responsive_dashboard/utilities/style.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';

import 'pages/data/data.dart';
import 'pages/data/echarts_data.dart';

class HomeComponent extends StatelessWidget {
  HomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row1(),
          Row2(),
        SizedBox(height: 200,
        child: HomeComponentGraphics().chart4,),
          Placeholder(fallbackHeight: 200),
          Placeholder(fallbackHeight: 200)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Row1 extends StatelessWidget {
  Row1({Key? key}) : super(key: key);

  List<Widget> widgetList = <Widget>[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: SizedBox(
                height: 75,
                child: ListTile(
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      CircleAvatar(
                          backgroundColor: Colors.green[50],
                          child: Icon(Icons.payments, color: Colors.green))
                    ]),
                    title: Text("오늘의 총 수입", style: MyStyle().myListTileTitleStyle),
                    subtitle: Text("120,000 원", style: MyStyle().myListTileSubTitleStyle))))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: SizedBox(
                height: 75,
                child: ListTile(
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      CircleAvatar(
                          backgroundColor: Colors.blue[50],
                          child: Icon(Icons.person, color: Colors.blue))
                    ]),
                    title: Text("신규 고객 유입 현황", style: MyStyle().myListTileTitleStyle),
                    subtitle: Text("24 명", style: MyStyle().myListTileSubTitleStyle))))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: SizedBox(
                height: 75,
                child: ListTile(
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      CircleAvatar(
                          backgroundColor: Colors.orange[50],
                          child: Icon(Icons.remove_red_eye, color: Colors.orange))
                    ]),
                    title: Text("오늘의 조회수", style: MyStyle().myListTileTitleStyle),
                    subtitle: Text("942 번", style: MyStyle().myListTileSubTitleStyle))))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: SizedBox(
                height: 75,
                child: ListTile(
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      CircleAvatar(
                          backgroundColor: Colors.brown[50],
                          child: Icon(Icons.account_balance_wallet, color: Colors.brown))
                    ]),
                    title: Text("통장 잔액", style: MyStyle().myListTileTitleStyle),
                    subtitle: Text("41,534,200 원", style: MyStyle().myListTileSubTitleStyle))))),
  ];

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(
        children: widgetList.map((e) => Flexible(child: e)).toList(),
      );
    } else if (Responsive.isTablet(context)) {
      return Column(
        children: [
          Row(
            children: [
              Flexible(flex: 1, child: widgetList[0]),
              Flexible(flex: 1, child: widgetList[1])
            ],
          ),
          Row(
            children: [
              Flexible(flex: 1, child: widgetList[2]),
              Flexible(flex: 1, child: widgetList[3])
            ],
          )
        ],
      );
    } else {
      return Column(
        children: widgetList,
      );
    }
  }
}

// ignore: must_be_immutable
class Row2 extends StatelessWidget {
  Row2({Key? key}) : super(key: key);

  List<Widget> widgetList = <Widget>[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 250,
                child: Column(children: [
                  Text("line chart"),
                  SizedBox(height: 200, child: HomeComponentGraphics().chart1)
                ])))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 250,
                child: Column(children: [
                  Text("e chart"),
                  Container(
                      height: 200,
                      margin: const EdgeInsets.only(top: 10),
                      child: HomeComponentGraphics().chart2)
                ])))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                height: 250,
                child: Column(children: [
                  Text("spider net chart"),
                  Container(
                      height: 200,
                      margin: const EdgeInsets.only(top: 10),
                      child: HomeComponentGraphics().chart3)
                ]))))
  ];

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Row(children: [
        Flexible(flex: 1, child: widgetList[0]),
        Flexible(flex: 2, child: widgetList[1]),
        Flexible(flex: 1, child: widgetList[2]),
      ]);
    } else if (Responsive.isTablet(context)) {
      return Column(children: [
        Row(children: [
          Flexible(flex: 1, child: widgetList[0]),
          Flexible(flex: 1, child: widgetList[2]),
        ]),
        widgetList[1]
      ]);
    } else {
      return Column(children: [widgetList[0], widgetList[1], widgetList[2]]);
    }
  }
}

final monthDayFormat = DateFormat('MM-dd');
