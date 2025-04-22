DropdownButtonFormField<RequirementType>(
  value: selectedType,
  decoration: const InputDecoration(
    labelText: 'Tipo de Requisito',
    prefixIcon: Icon(Icons.category),
  ),
  items: RequirementType.values
      .map((type) => DropdownMenuItem(
            value: type,
            child: Text(type.label),
          ))
      .toList(),
  onChanged: (type) => setState(() => selectedType = type!),
),