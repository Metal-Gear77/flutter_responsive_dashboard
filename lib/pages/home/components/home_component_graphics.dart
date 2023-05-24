import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';
import 'pages/data/data.dart';
import 'pages/data/echarts_data.dart';

final monthDayFormat = DateFormat('MM-dd');

class HomeComponentGraphics {
  Widget chart1 = Chart(
    data: timeSeriesSales,
    variables: {
      'time': Variable(
        accessor: (TimeSeriesSales datum) => datum.time,
        scale: TimeScale(
          formatter: (time) => monthDayFormat.format(time),
        ),
      ),
      'sales': Variable(
        accessor: (TimeSeriesSales datum) => datum.sales,
      )
    },
    marks: [
      LineMark(shape: ShapeEncode(value: BasicLineShape(dash: [5, 2])), selected: {
        'touchMove': {1}
      })
    ],
    coord: RectCoord(color: const Color(0xffdddddd)),
    axes: [
      Defaults.horizontalAxis,
      Defaults.verticalAxis,
    ],
    selections: {
      'touchMove': PointSelection(
        on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
        dim: Dim.x,
      )
    },
    tooltip: TooltipGuide(
      followPointer: [false, true],
      align: Alignment.topLeft,
      offset: const Offset(-20, -20),
    ),
    crosshair: CrosshairGuide(followPointer: [false, true]),
  );
  Widget chart2 = Chart(
    data: zip(lineSectionsData).toList(),
    variables: {
      'time': Variable(
        accessor: (List datum) => datum[0] as String,
        scale: OrdinalScale(inflate: true, tickCount: 6),
      ),
      'value': Variable(
        accessor: (List datum) => datum[1] as num,
        scale: LinearScale(
          max: 800,
          min: 0,
          formatter: (v) => '${v.toInt()} W',
        ),
      ),
    },
    marks: [
      LineMark(
        shape: ShapeEncode(value: BasicLineShape(smooth: true)),
      )
    ],
    axes: [
      Defaults.horizontalAxis,
      Defaults.verticalAxis,
    ],
    selections: {
      'tooltipMouse': PointSelection(on: {
        GestureType.hover,
      }, devices: {
        PointerDeviceKind.mouse
      }, dim: Dim.x),
      'tooltipTouch': PointSelection(
          on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
          devices: {PointerDeviceKind.touch},
          dim: Dim.x),
    },
    tooltip: TooltipGuide(
      followPointer: [true, true],
      align: Alignment.topLeft,
    ),
    crosshair: CrosshairGuide(
      followPointer: [false, true],
    ),
    annotations: [
      RegionAnnotation(
        values: ['07:30', '10:00'],
        color: const Color.fromARGB(120, 255, 173, 177),
      ),
      RegionAnnotation(
        values: ['17:30', '21:15'],
        color: const Color.fromARGB(120, 255, 173, 177),
      ),
    ],
  );
  Widget chart3 = Chart(
      data: adjustData,
      variables: {
        'index': Variable(
          accessor: (Map map) => map['index'].toString(),
        ),
        'type': Variable(
          accessor: (Map map) => map['type'] as String,
        ),
        'value': Variable(
          accessor: (Map map) => map['value'] as num,
        ),
      },
      marks: [
        LineMark(
          position: Varset('index') * Varset('value') / Varset('type'),
          shape: ShapeEncode(value: BasicLineShape(loop: true)),
          color: ColorEncode(variable: 'type', values: Defaults.colors10),
        )
      ],
      coord: PolarCoord(),
      axes: [
        Defaults.circularAxis,
        Defaults.radialAxis,
      ],
      selections: {
        'touchMove': PointSelection(
          on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
          dim: Dim.x,
          variable: 'index',
        )
      },
      tooltip: TooltipGuide(
        anchor: (_) => Offset.zero,
        align: Alignment.bottomRight,
        multiTuples: true,
        variables: ['type', 'value'],
      ),
      crosshair: CrosshairGuide(followPointer: [false, true]));

  Widget chart4 = PieChartSample2();
  Widget chart5 = BarChartSample();
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.yellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.purple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.blue,
              value: 45,
              title: '45%',
              radius: radius,
              titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
        case 1:
          return PieChartSectionData(
              color: Colors.yellow,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
        case 2:
          return PieChartSectionData(
              color: Colors.purple,
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
        case 3:
          return PieChartSectionData(
              color: Colors.green,
              value: 10,
              title: '10%',
              radius: radius,
              titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class BarChartSample extends StatelessWidget {
  BarChartSample();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("bar chart"),
        Expanded(
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData,
              borderData: borderData,
              barGroups: barGroups,
              gridData: FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
            ),
          ),
        ),
      ],
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
