import 'package:mobx/mobx.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

part 'analyzer_controller.g.dart';

class AnalyzerController = _AnalyzerControllerBase with _$AnalyzerController;

abstract class _AnalyzerControllerBase with Store {
  @observable
  ObservableList<String> logs = ObservableList<String>();

  @observable
  bool isAnalyzing = false;

  @action
  Future<void> analyzeProject(String projectName, String repositoryLink) async {
    isAnalyzing = true;
    logs.clear();
    final tempDir = await getTemporaryDirectory();
    final projectPath = '${tempDir.path}/$projectName';

    await _runCommand('git', ['clone', repositoryLink, projectPath]);

    if (!File('$projectPath/pubspec.yaml').existsSync()) {
      await _runCommand('flutter', ['create', projectPath]);
    }

    await _runFlutterCommands(projectPath);
    isAnalyzing = false;
  }

  Future<void> _runFlutterCommands(String path) async {
    await _runCommand('flutter', ['clean'], workingDir: path);
    await _runCommand('flutter', ['pub', 'get'], workingDir: path);
    await _runCommand(
      'flutter',
      ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDir: path,
    );
  }

  Future<void> _runCommand(String cmd, List<String> args, {String? workingDir}) async {
    final process = await Process.start(cmd, args, workingDirectory: workingDir);
    process.stdout.transform(utf8.decoder).listen((data) => logs.add(data));
    process.stderr.transform(utf8.decoder).listen((data) => logs.add('Error: $data'));
    await process.exitCode;
  }
}