import 'dart:convert';
import 'dart:io';

import 'package:todo_app/data_source/todo_data_source.dart';

class TodoDataSourceImpl implements TodoDataSource {
  final String _path;

  final String backUpPath = 'data/backup.dat';

  const TodoDataSourceImpl({String path = 'data/todos.json'}) : _path = path;

  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    File file = File(_path);

    if (!await file.exists()) {
      file = await File(
        _path,
      ).writeAsString(await File(backUpPath).readAsString());
    }

    String fileDataString = await file.readAsString();
    List fileDataList = jsonDecode(fileDataString);
    return fileDataList.map((items) => items as Map<String, dynamic>).toList();
  }

  @override
  Future<void> writeTodos(List<Map<String, dynamic>> todos) async {
    File file = File(_path);
    File backFile = await File(backUpPath).copy('backup2.dat');

    List<Map<String, dynamic>> getFileReadTodo = await readTodos();

    String encodeJson = jsonEncode(getFileReadTodo..addAll(todos));

    await file.writeAsString(encodeJson);
    await backFile.writeAsString(encodeJson);
  }
}
