class RequirementPage extends StatelessWidget {
  final RequirementController controller;

  const RequirementPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Software Requirements Analyzer'),
        centerTitle: true,
      ),
      body: isWideScreen
          ? Row(
              children: [
                Expanded(flex: 4, child: RequirementForm(controller: controller)),
                Expanded(
                  flex: 6,
                  child: Observer(builder: (_) {
                    if (controller.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.requirements.isEmpty) {
                      return const Center(child: Text('Nenhum requisito cadastrado ainda.'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: controller.requirements.length,
                      itemBuilder: (context, index) {
                        final req = controller.requirements[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(req.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(req.type.toString().split('.').last.toUpperCase()),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            )
          : RequirementForm(controller: controller),
    );
  }
}