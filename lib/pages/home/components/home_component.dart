import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/utilities/responsives.dart';

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
          Placeholder(fallbackHeight: 200),
          Placeholder(fallbackHeight: 200),
          Placeholder(fallbackHeight: 200)
        ],
      ),
    );
  }
}

class Row1 extends StatelessWidget {
  Row1({Key? key}) : super(key: key);

  List<Widget> widgetList = <Widget>[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 200, color: Colors.red))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 200, color: Colors.blue))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 200, color: Colors.orange))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 200, color: Colors.brown))),
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

class Row2 extends StatelessWidget {
  Row2({Key? key}) : super(key: key);

  List<Widget> widgetList = <Widget>[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 400, color: Colors.red))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 400, color: Colors.brown))),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: Container(height: 400, color: Colors.blue))),
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
          Flexible(flex: 1, child: widgetList[1]),
        ]),
        widgetList[2]
      ]);
    } else {
      return Column(children: [widgetList[0], widgetList[1], widgetList[2]]);
    }
  }
}
