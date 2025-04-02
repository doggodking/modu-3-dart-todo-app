import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';

void main() async {
  File backUpfile = File('data/backup.dat');
  List backUpList = jsonDecode(await backUpfile.readAsString());
  List<Map<String, dynamic>> backUpMapList =
      backUpList.map((e) => e as Map<String, dynamic>).toList();

  test("1: 파일이 존재하지 않는 경우 자동 생성 및 초기화", () async {
    TodoDataSource todoDataSource = TodoDataSourceImpl(path: "data/todos.json");
    List<Map<String, dynamic>> toDoList = await todoDataSource.readTodos();

    expect(toDoList, equals(backUpMapList));
  });
}
