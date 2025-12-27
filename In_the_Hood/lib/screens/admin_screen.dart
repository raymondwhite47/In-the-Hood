import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:in_the_hood/services/database_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: FutureBuilder<Map<String, int>>(
        future: _databaseService.getAnalytics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No analytics data available.'));
          }

          final analytics = snapshot.data!;
          final totalUsers = analytics['users'] ?? 0;
          final totalListings = analytics['listings'] ?? 0;
          final totalTransactions = analytics['transactions'] ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Analytics',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAnalyticsCard(context, 'Total Users', totalUsers, Icons.people, Colors.blue),
                    _buildAnalyticsCard(context, 'Total Listings', totalListings, Icons.list_alt, Colors.green),
                    _buildAnalyticsCard(context, 'Transactions', totalTransactions, Icons.receipt_long, Colors.orange),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Activity Chart',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: (totalUsers + totalListings + totalTransactions) * 1.2,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.blueGrey,
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                String weekDay;
                                switch (group.x.toInt()) {
                                  case 0:
                                    weekDay = 'Users';
                                    break;
                                  case 1:
                                    weekDay = 'Listings';
                                    break;
                                  case 2:
                                    weekDay = 'Transactions';
                                    break;
                                  default:
                                    throw Error();
                                }
                                return BarTooltipItem(
                                  '$weekDay\n',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: (rod.toY - 1).toString(),
                                      style: const TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  const style = TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  );
                                  Widget text;
                                  switch (value.toInt()) {
                                    case 0:
                                      text = const Text('Users', style: style);
                                      break;
                                    case 1:
                                      text = const Text('Listings', style: style);
                                      break;
                                    case 2:
                                      text = const Text('Trans', style: style);
                                      break;
                                    default:
                                      text = const Text('', style: style);
                                      break;
                                  }
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 4,
                                    child: text,
                                  );
                                },
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
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: [
                            _makeGroupData(0, totalUsers.toDouble(), barColor: Colors.blue),
                            _makeGroupData(1, totalListings.toDouble(), barColor: Colors.green),
                            _makeGroupData(2, totalTransactions.toDouble(), barColor: Colors.orange),
                          ],
                          gridData: const FlGridData(show: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnalyticsCard(BuildContext context, String title, int value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 10),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, {
    Color barColor = Colors.white,
    double width = 22,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y + 1,
          color: barColor,
          width: width,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: (y * 1.2).ceilToDouble(),
            color: barColor.withAlpha(51),
          ),
        ),
      ],
    );
  }
}
