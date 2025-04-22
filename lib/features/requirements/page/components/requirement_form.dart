DropdownButtonFormField<TipoRequisito>(
  value: tipoSelecionado,
  decoration: const InputDecoration(
    labelText: 'Tipo de Requisito',
    prefixIcon: Icon(Icons.category),
  ),
  items: TipoRequisito.values
      .map((tipo) => DropdownMenuItem(
            value: tipo,
            child: Text(tipo.descricao),
          ))
      .toList(),
  onChanged: (tipo) => setState(() => tipoSelecionado = tipo!),
),
