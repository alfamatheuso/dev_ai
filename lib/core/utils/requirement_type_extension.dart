extension RequirementTypeExtension on RequirementType {
  String get label {
    switch (this) {
      case RequirementType.funcional:
        return 'Funcional';
      case RequirementType.naoFuncional:
        return 'Não Funcional';
      case RequirementType.regraNegocio:
        return 'Regra de Negócio';
      default:
        return '';
    }
  }
}