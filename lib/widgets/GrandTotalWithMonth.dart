import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';
import 'package:irelandstatistics/models/workpermit/PermitsSector.dart';

class GrandTotalWithMonth<E extends IBean> extends StatelessWidget {
  final E data;
  final IconData icon;

  final List<Color> gradientColors = [
    Colors.cyanAccent,
    Colors.blue,
  ];

  GrandTotalWithMonth({super.key, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    var count = 0;
    var year = '1990';

    if (data is PermitsCompany) {
      var tmp = data as PermitsCompany;
      count = tmp.count ?? 0;
      year = tmp.year ?? year;
    } else if (data is PermitsSector) {
      var tmp = data as PermitsSector;
      count = tmp.count ?? 0;
      year = tmp.year ?? year;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 2,
                  offset: Offset(2, 4),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Constants.field_grand_total} - $year',
                    style:
                        const TextStyle(color: Colors.cyanAccent, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total Permits: ${count.toString()}',
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 2.0,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 15,
              bottom: 10,
            ),
            child: showMainData(data),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;
    switch (value.toInt()) {
      case 1:
        text = '1K';
        break;
      case 3:
        text = '3k';
        break;
      case 5:
        text = '5k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> getData(List<int> monthCount) {
    return [
      FlSpot(0, monthCount[0].toDouble() / 1000.00),
      FlSpot(1, monthCount[1].toDouble() / 1000.00),
      FlSpot(2, monthCount[2].toDouble() / 1000.00),
      FlSpot(3, monthCount[3].toDouble() / 1000.00),
      FlSpot(4, monthCount[4].toDouble() / 1000.00),
      FlSpot(5, monthCount[5].toDouble() / 1000.00),
      FlSpot(6, monthCount[6].toDouble() / 1000.00),
      FlSpot(7, monthCount[7].toDouble() / 1000.00),
      FlSpot(8, monthCount[8].toDouble() / 1000.00),
      FlSpot(9, monthCount[9].toDouble() / 1000.00),
      FlSpot(10, monthCount[10].toDouble() / 1000.00),
      FlSpot(11, monthCount[11].toDouble() / 1000.00)
    ];
  }

  Widget showMainData(E bean) {
    List<int> data = [];
    if (bean is PermitsCompany) {
      data = bean.monthCount!;
    } else if (bean is PermitsSector) {
      data = bean.monthCount!;
    }

    return LineChart(LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.deepPurpleAccent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.deepPurpleAccent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.deepPurpleAccent),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: getData(data),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    ));
  }
}
