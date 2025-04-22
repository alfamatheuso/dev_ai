class RequirementRepository {
  final Database db;

  RequirementRepository(this.db);

  Future<void> saveRequirement(RequirementModel requirement) async {
    await db.insert('requirements', requirement.toJson());
  }

  Future<List<RequirementModel>> getRequirements() async {
    final result = await db.query('requirements');
    return result.map((json) => RequirementModel.fromJson(json)).toList();
  }

  Future<void> updateRequirement(RequirementModel requirement) async {
    await db.update('requirements', requirement.toJson(), where: 'id = ?', whereArgs: [requirement.id]);
  }

  Future<void> deleteRequirement(String id) async {
    await db.delete('requirements', where: 'id = ?', whereArgs: [id]);
  }
}