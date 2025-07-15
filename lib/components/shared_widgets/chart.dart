import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final String title;

  const SimpleBarChart({
    super.key,
    required this.values,
    required this.labels,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= labels.length)
                            return const SizedBox();
                          return Text(
                            labels[idx],
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    values.length,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          color: Theme.of(context).colorScheme.primary,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimplePieChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final String title;

  const SimplePieChart({
    super.key,
    required this.values,
    required this.labels,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final total = values.fold<double>(0, (sum, v) => sum + v);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: List.generate(
                    values.length,
                    (i) => PieChartSectionData(
                      value: values[i],
                      color: Colors.primaries[i % Colors.primaries.length],
                      title:
                          '${((values[i] / total) * 100).toStringAsFixed(1)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              children: List.generate(
                labels.length,
                (i) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: Colors.primaries[i % Colors.primaries.length],
                    ),
                    const SizedBox(width: 4),
                    Text(labels[i], style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
