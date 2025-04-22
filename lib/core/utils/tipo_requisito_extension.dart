extension TipoRequisitoExtension on TipoRequisito {
  String get descricao {
    switch (this) {
      case TipoRequisito.funcional:
        return 'Funcional';
      case TipoRequisito.naoFuncional:
        return 'Não Funcional';
      case TipoRequisito.regraNegocio:
        return 'Regra de Negócio';
    }
  }
}
