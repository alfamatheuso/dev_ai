import 'package:json_annotation/json_annotation.dart';

enum RequirementType {
  @JsonValue('funcional')
  funcional,
  
  @JsonValue('nao_funcional')
  naoFuncional,
  
  @JsonValue('regra_negocio')
  regraNegocio,
}