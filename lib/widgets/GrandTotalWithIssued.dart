import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCounty.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';

import '../Constants.dart';
import '../models/IBean.dart';

class GrandTotalWithIssued<E extends IBean> extends StatelessWidget {
  final E data;
  final IconData icon;

  final List<Color> gradientColors = [
    Colors.cyanAccent,
    Colors.blue,
  ];

  GrandTotalWithIssued(
      {super.key, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    var issued = 0;
    var refused = 0;
    var withdrawn = 0;

    var year = '1990';

    if (data is PermitsNationality) {
      var tmp = data as PermitsNationality;
      issued = tmp.issued ?? 0;
      refused = tmp.refused ?? 0;
      withdrawn = tmp.withdrawn ?? 0;
      year = tmp.year ?? year;
    } else if (data is PermitsCounty) {
      var tmp = data as PermitsCounty;
      issued = tmp.issued ?? 0;
      refused = tmp.refused ?? 0;
      withdrawn = tmp.withdrawn ?? 0;
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
                    'Issued Permits: ${issued.toString()}',
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
            child: showMainData(issued, refused, withdrawn),
          ),
        ),
      ],
    );
  }

  Widget showMainData(int issued, int refused, int withdrawn) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: getBarGroups(issued, refused, withdrawn),
        gridData: const FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
        maxY: issued.toDouble() + 10000,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black54,
          tooltipPadding: const EdgeInsets.all(1),
          tooltipMargin: 5,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: gradientColors[0],
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: gradientColors[1],
      fontSize: 14,
    );

    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Issued';
        break;
      case 1:
        text = 'Refused';
        break;
      case 2:
        text = 'Withdrawn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
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
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: gradientColors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> getBarGroups(int issued, int refused, int withdrawn){
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: issued.toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: refused.toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: withdrawn.toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      )
    ];
  }
}
