class AnalyzerPage extends StatelessWidget {
  final AnalyzerController controller = AnalyzerController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController repositoryController = TextEditingController();
  final TextEditingController analysisTypeController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 220,
            decoration: BoxDecoration(
              color: AppColors.primary,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.analytics, color: Colors.white, size: 60),
                SizedBox(height: 15),
                Text(
                  'Software Analyzer',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Analisador de Projeto Flutter',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: projectController,
                              decoration: inputDecoration('Nome do Projeto', Icons.folder_open),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: repositoryController,
                              decoration: inputDecoration('Link do Repositório Git', Icons.link),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: analysisTypeController,
                              decoration: inputDecoration('Tipo de Análise', Icons.settings),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: apiKeyController,
                              decoration: inputDecoration('Chave da API (Opcional)', Icons.vpn_key),
                            ),
                            SizedBox(height: 25),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                              ),
                              icon: Icon(Icons.cloud_upload, size: 24),
                              label: Text('Analisar', style: TextStyle(fontSize: 18)),
                              onPressed: () => controller.analyzeProject(
                                projectController.text,
                                repositoryController.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Status da Análise',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Observer(builder: (_) {
                        return ListView.builder(
                          itemCount: controller.logs.length,
                          itemBuilder: (_, index) => Text(
                            controller.logs[index],
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        );
                      }),
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

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.secondary),
      filled: true,
      fillColor: Colors.grey.shade100,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }
}