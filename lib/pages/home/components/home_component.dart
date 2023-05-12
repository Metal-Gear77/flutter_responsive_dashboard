import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/utilities/responsives.dart';

class HomeComponent extends StatelessWidget {
  HomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (Responsive.isDesktop(context))
          Row(
            children: [
              Flexible(flex: 1, child: widgetList[0]),
              Flexible(
                flex: 2,
                child: widgetList[1],
              ),
              Flexible(
                flex: 1,
                child: widgetList[2],
              ),
            ],
          )
        else if (Responsive.isTablet(context))
          Column(
            children: [
              Row(
                children: [
                  Flexible(flex: 1, child: widgetList[0]),
                  Flexible(flex: 1, child: widgetList[1]),
                ],
              ),
              widgetList[2],
            ],
          )
        else
          Column(children: [widgetList[0],widgetList[1],widgetList[2]],),

        Placeholder(
          fallbackHeight: 200,
        ),
        Placeholder(
          fallbackHeight: 200,
        ),
        Placeholder(
          fallbackHeight: 200,
        )
      ],
    );
  }

  List<Widget> widgetList = <Widget>[
    Container(height: 200, color: Colors.red),
    Container(height: 200, color: Colors.blue),
    Container(height: 200, color: Colors.orange),
    Container(height: 200, color: Colors.brown),
    Container(height: 200, color: Colors.green)
  ];
}
