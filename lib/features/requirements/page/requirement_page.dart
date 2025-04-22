class RequirementPage extends StatelessWidget {
  final RequirementController controller;

  RequirementPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestão de Requisitos')),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: RequirementForm(controller: controller),
          ),
          Expanded(
            flex: 5,
            child: Observer(builder: (_) {
              if (controller.isLoading) return CircularProgressIndicator();
              return ListView(
                children: controller.requirements
                    .map((req) => ListTile(
                          title: Text(req.title),
                          subtitle: Text(req.type.toString()),
                        ))
                    .toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}