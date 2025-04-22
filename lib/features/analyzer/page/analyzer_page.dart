class AnalyzerPage extends StatelessWidget {
  final controller = AnalyzerController();
  final projectController = TextEditingController();
  final repositoryController = TextEditingController();
  final analysisTypeController = TextEditingController();
  final apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 200,
            color: AppColors.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.analytics, color: Colors.white, size: 48),
                SizedBox(height: 10),
                Text('Software Analyzer', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  AnalyzerForm(
                    projectController: projectController,
                    repositoryController: repositoryController,
                    analysisTypeController: analysisTypeController,
                    apiKeyController: apiKeyController,
                    onSubmit: () => controller.analyzeProject(
                      projectController.text,
                      repositoryController.text,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Observer(
                      builder: (_) => Container(
                        padding: EdgeInsets.all(12),
                        color: Colors.black.withOpacity(0.05),
                        child: ListView(
                          children: controller.logs.map((log) => Text(log)).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}