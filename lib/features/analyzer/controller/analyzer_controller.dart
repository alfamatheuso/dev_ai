import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/process_run.dart';

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

    if (!(await File('$projectPath/pubspec.yaml').exists())) {
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

  Future<void> _runCommand(String executable, List<String> arguments, {String? workingDir}) async {
    logs.add('Executando: $executable ${arguments.join(' ')}');
    final shell = Shell(workingDirectory: workingDir);
    await shell.runExecutableArguments(executable, arguments).then((result) {
      for (var line in result.outLines) {
        logs.add(line);
      }
      for (var line in result.errLines) {
        logs.add('Erro: $line');
      }
    }).catchError((e) {
      logs.add('Falha ao executar comando: $e');
    });
  }
}