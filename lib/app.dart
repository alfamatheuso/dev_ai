import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_requirements_analyzer/core/config/app_theme.dart';
import 'package:software_requirements_analyzer/features/requirements/controller/requirement_controller.dart';
import 'package:software_requirements_analyzer/features/requirements/page/requirement_page.dart';
import 'package:software_requirements_analyzer/features/requirements/repository/requirement_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final requirementRepository = RequirementRepository();
    final requirementController = RequirementController(requirementRepository)..loadRequirements();

    return MultiProvider(
      providers: [
        Provider<RequirementController>.value(value: requirementController),
      ],
      child: MaterialApp(
        title: 'Software Requirements Analyzer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: RequirementPage(controller: requirementController),
      ),
    );
  }
}