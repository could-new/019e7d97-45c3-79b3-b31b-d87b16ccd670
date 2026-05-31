import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const ArchitectApp());
}

class ArchitectApp extends StatelessWidget {
  const ArchitectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketing AI Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainShell(),
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AnalyticsDashboardScreen(),
    const CampaignServiceScreen(),
    const AIEngineScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          body: isMobile
              ? _screens[_selectedIndex]
              : Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.dashboard_outlined),
                          selectedIcon: Icon(Icons.dashboard),
                          label: Text('Analytics'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.campaign_outlined),
                          selectedIcon: Icon(Icons.campaign),
                          label: Text('Campaigns'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.auto_awesome_outlined),
                          selectedIcon: Icon(Icons.auto_awesome),
                          label: Text('AI Engine'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: _screens[_selectedIndex]),
                  ],
                ),
          bottomNavigationBar: isMobile
              ? NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: 'Analytics',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.campaign_outlined),
                      selectedIcon: Icon(Icons.campaign),
                      label: 'Campaigns',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.auto_awesome_outlined),
                      selectedIcon: Icon(Icons.auto_awesome),
                      label: 'AI Engine',
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform Overview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: crossAxisCount == 1 ? 3 : 1.5,
                  children: const [
                    MetricCard(title: 'Active Users', value: '124,592', trend: '+12%'),
                    MetricCard(title: 'Campaign Conversions', value: '45,231', trend: '+8%'),
                    MetricCard(title: 'AI Tokens Used', value: '2.4M', trend: '+45%'),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Engagement Chart',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const SizedBox(
              height: 300,
              child: EngagementLineChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              trend,
              style: TextStyle(
                color: trend.startsWith('+') ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EngagementLineChart extends StatelessWidget {
  const EngagementLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    if (value >= 0 && value < days.length) {
                      return Text(days[value.toInt()]);
                    }
                    return const Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 3),
                  FlSpot(1, 1),
                  FlSpot(2, 4),
                  FlSpot(3, 7),
                  FlSpot(4, 5),
                  FlSpot(5, 8),
                  FlSpot(6, 12),
                ],
                isCurved: true,
                color: Theme.of(context).colorScheme.primary,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CampaignServiceScreen extends StatelessWidget {
  const CampaignServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign Service'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            tooltip: 'New Campaign',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          final statuses = ['Active', 'Draft', 'Completed', 'Active', 'Paused'];
          final names = [
            'Q3 Product Launch',
            'Summer Sale Retargeting',
            'New User Onboarding Series',
            'Win-back Email Sequence',
            'Holiday Promotion'
          ];
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: statuses[index] == 'Active' 
                    ? Colors.green.withAlpha(50) 
                    : Colors.grey.withAlpha(50),
                child: Icon(
                  Icons.campaign,
                  color: statuses[index] == 'Active' ? Colors.green : Colors.grey,
                ),
              ),
              title: Text(names[index]),
              subtitle: Text('Status: ${statuses[index]}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class AIEngineScreen extends StatelessWidget {
  const AIEngineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Engine Configurations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.memory, size: 32),
                        const SizedBox(width: 16),
                        Text(
                          'Model Status: Online',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(value: 0.7),
                    const SizedBox(height: 8),
                    const Text('Compute Resource Utilization: 70%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Active Tasks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Generating Campaign Copy'),
                    subtitle: Text('Target: Q3 Product Launch'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Audience Segmentation Analysis'),
                    subtitle: Text('Completed 12 mins ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Predictive Churn Model Update'),
                    subtitle: Text('Completed 2 hours ago'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
