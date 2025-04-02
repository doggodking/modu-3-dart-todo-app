import 'dart:convert';
import 'dart:io';

import 'package:todo_app/data_source/todo_data_source.dart';

class TodoDataSourceImpl implements TodoDataSource {
  final String _path;

  String backUpPath = 'data/backup.dat';

  TodoDataSourceImpl({String path = 'data/todos.json'}) : _path = path;

  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    File file = File(_path);
    String fileDataString = '';
    List fileDataList = [];

    if (!await file.exists()) {
      //File newFile = await File(_path).create().then((File file) async {
      // return file.writeAsString(await File(backUpPath).readAsString());
      //});

      File newFile = await File(
        _path,
      ).writeAsString(await File(backUpPath).readAsString());

      fileDataString = await newFile.readAsString();
    } else {
      fileDataString = await file.readAsString();
    }

    fileDataList = jsonDecode(fileDataString);

    return fileDataList.map((items) => items as Map<String, dynamic>).toList();
  }

  @override
  Future<void> writeTodos(List<Map<String, dynamic>> todos) async {
    File file = File(_path);
    File backFile = File(backUpPath);
    File newBackFile = File(backUpPath);

    if (!await backFile.exists()) {
      newBackFile = await File('data/backup.dat').copy(backUpPath);
    }

    List<Map<String, dynamic>> getFileReadTodo = await readTodos();

    String encodeJson = jsonEncode(getFileReadTodo..addAll(todos));

    await file.writeAsString(encodeJson);
    await newBackFile.writeAsString(encodeJson);
  }
}
