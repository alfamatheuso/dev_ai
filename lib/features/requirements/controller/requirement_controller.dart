import 'package:mobx/mobx.dart';

part 'requirement_controller.g.dart';

class RequirementController = _RequirementControllerBase with _$RequirementController;

abstract class _RequirementControllerBase with Store {
  final RequirementRepository repository;

  _RequirementControllerBase(this.repository);

  @observable
  ObservableList<RequirementModel> requirements = ObservableList();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadRequirements() async {
    isLoading = true;
    final data = await repository.getRequirements();
    requirements = ObservableList.of(data);
    isLoading = false;
  }

  @action
  Future<void> saveRequirement(RequirementModel requirement) async {
    await repository.saveRequirement(requirement);
    requirements.add(requirement);
  }
}