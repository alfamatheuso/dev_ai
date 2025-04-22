class AnalyzerForm extends StatelessWidget {
  final TextEditingController projectController;
  final TextEditingController repositoryController;
  final TextEditingController analysisTypeController;
  final TextEditingController apiKeyController;
  final VoidCallback onSubmit;

  const AnalyzerForm({
    required this.projectController,
    required this.repositoryController,
    required this.analysisTypeController,
    required this.apiKeyController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: projectController,
          decoration: InputDecoration(labelText: 'Nome do Projeto'),
        ),
        TextFormField(
          controller: repositoryController,
          decoration: InputDecoration(labelText: 'Link do Repositório Git'),
        ),
        TextFormField(
          controller: analysisTypeController,
          decoration: InputDecoration(labelText: 'Tipo de Análise'),
        ),
        TextFormField(
          controller: apiKeyController,
          decoration: InputDecoration(labelText: 'Chave da API (opcional)'),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          icon: Icon(Icons.cloud_upload),
          label: Text('Analisar'),
          onPressed: onSubmit,
        ),
      ],
    );
  }
}