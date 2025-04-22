import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:software_requirements_analyzer/core/config/app_theme.dart';
import 'package:software_requirements_analyzer/features/requirements/controller/requirement_controller.dart';
import 'package:software_requirements_analyzer/features/requirements/page/requirement_page.dart';
import 'package:software_requirements_analyzer/features/requirements/repository/requirement_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'requirements.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE requirements (
            id TEXT PRIMARY KEY,
            title TEXT,
            type TEXT,
            description TEXT,
            justification TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: _initDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final requirementRepository = RequirementRepository(snapshot.data!);
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

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}