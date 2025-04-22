void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software Analyzer',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnalyzerPage(),
    );
  }
}