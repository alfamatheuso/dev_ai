import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/requirement_model.dart';

class RequirementRepository {
  static const String storageKey = 'requirements';

  Future<void> saveRequirement(RequirementModel requirement) async {
    final prefs = await SharedPreferences.getInstance();
    final requirements = await getRequirements();
    requirements.add(requirement);
    final jsonList = requirements.map((r) => r.toJson()).toList();
    await prefs.setString(storageKey, jsonEncode(jsonList));
  }

  Future<List<RequirementModel>> getRequirements() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storageKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => RequirementModel.fromJson(json)).toList();
  }

  Future<void> updateRequirement(RequirementModel updated) async {
    final prefs = await SharedPreferences.getInstance();
    final requirements = await getRequirements();
    final index = requirements.indexWhere((r) => r.id == updated.id);
    if (index >= 0) {
      requirements[index] = updated;
      await prefs.setString(storageKey, jsonEncode(requirements));
    }
  }

  Future<void> deleteRequirement(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final requirements = await getRequirements();
    requirements.removeWhere((r) => r.id == id);
    await prefs.setString(storageKey, jsonEncode(requirements));
  }
}