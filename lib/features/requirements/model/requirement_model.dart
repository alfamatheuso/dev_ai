import 'package:json_annotation/json_annotation.dart';

enum TipoRequisito {
  @JsonValue('funcional')
  funcional,

  @JsonValue('nao_funcional')
  naoFuncional,

  @JsonValue('regra_negocio')
  regraNegocio,
}
