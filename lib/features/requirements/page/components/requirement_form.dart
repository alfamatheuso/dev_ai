class RequirementForm extends StatelessWidget {
  final RequirementController controller;

  RequirementForm({required this.controller});

  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final justificationCtrl = TextEditingController();
  RequirementType selectedType = RequirementType.functional;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Título')),
        DropdownButtonFormField<RequirementType>(
          value: selectedType,
          items: RequirementType.values
              .map((type) => DropdownMenuItem(value: type, child: Text(type.toString().split('.').last)))
              .toList(),
          onChanged: (type) => selectedType = type!,
        ),
        TextFormField(controller: descriptionCtrl, decoration: InputDecoration(labelText: 'Descrição')),
        TextFormField(controller: justificationCtrl, decoration: InputDecoration(labelText: 'Justificativa')),
        ElevatedButton(
          onPressed: () {
            final req = RequirementModel(
              title: titleCtrl.text,
              type: selectedType,
              description: descriptionCtrl.text,
              justification: justificationCtrl.text,
            );
            controller.saveRequirement(req);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}