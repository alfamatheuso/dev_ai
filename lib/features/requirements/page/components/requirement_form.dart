class RequirementForm extends StatefulWidget {
  final RequirementController controller;

  const RequirementForm({super.key, required this.controller});

  @override
  State<RequirementForm> createState() => _RequirementFormState();
}

class _RequirementFormState extends State<RequirementForm> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final justificationCtrl = TextEditingController();
  RequirementType selectedType = RequirementType.functional;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Cadastrar Requisito', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Informe um título válido' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<RequirementType>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Requisito',
                      prefixIcon: Icon(Icons.category),
                    ),
                    items: RequirementType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.toString().split('.').last.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (type) => setState(() => selectedType = type!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionCtrl,
                    maxLines: isWideScreen ? 5 : 3,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Informe uma descrição válida' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: justificationCtrl,
                    maxLines: isWideScreen ? 4 : 2,
                    decoration: const InputDecoration(
                      labelText: 'Justificativa',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.format_quote),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Informe uma justificativa válida' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Salvar Requisito', style: TextStyle(fontSize: 16)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final req = RequirementModel(
                          title: titleCtrl.text,
                          type: selectedType,
                          description: descriptionCtrl.text,
                          justification: justificationCtrl.text,
                        );
                        widget.controller.saveRequirement(req);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Requisito salvo com sucesso!')),
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}