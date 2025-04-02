import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/data_source/todo_data_source_impl.dart';

void main() async {
  const String filePath = 'data/todos.json';

  Future<List<Map<String, dynamic>>> readFile({required String path}) async {
    List readFileList = jsonDecode(await File(path).readAsString());
    List<Map<String, dynamic>> readFileData =
        readFileList.map((items) => items as Map<String, dynamic>).toList();

    return readFileData;
  }

  test("1. 파일 미존재 시 – 자동 파일 생성 및 백업 사용", () async {
    TodoDataSource todoDataSource = TodoDataSourceImpl(path: filePath);
    List<Map<String, dynamic>> getDataSource = await todoDataSource.readTodos();

    if (!await File(filePath).exists()) {
      await todoDataSource.readTodos();
      expect(getDataSource, equals(await readFile(path: 'data/backup.dat')));
    }
    if (await File(filePath).exists()) {
      expect(getDataSource, equals(await readFile(path: 'data/backup.dat')));
    }
  });

  test("2. readTodos() – 정상 파일에서 데이터 읽기", () async {
    TodoDataSource todoDataSource = TodoDataSourceImpl(path: filePath);
    List<Map<String, dynamic>> getDataSource = await todoDataSource.readTodos();
    expect(getDataSource, equals(await readFile(path: 'data/todos.json')));
  });

  test("3. writeTodos() – 데이터 파일에 쓰기", () async {
    TodoDataSource todoDataSource = TodoDataSourceImpl(path: filePath);
    List<Map<String, dynamic>> readData = await todoDataSource.readTodos();
    List<Map<String, dynamic>> mockData = [
      {
        "userId": 1,
        "id": 1,
        "title": "생존코딩 유튜브 구독하기",
        "completed": false,
        "createdAt": "2025-03-29T10:15:00Z",
      },
      {
        "userId": 1,
        "id": 2,
        "title": "PR 제출하기",
        "completed": false,
        "createdAt": "2025-03-30T08:30:00Z",
      },
      {
        "userId": 1,
        "id": 3,
        "title": "다른 사람 코드 리뷰하기",
        "completed": false,
        "createdAt": "2025-03-31T14:00:00Z",
      },
    ];

    File testFile = File('data/todos2.json');

    await testFile.writeAsString(jsonEncode([...readData, ...mockData]));

    expect(
      await readFile(path: 'data/todos2.json'),
      equals([...readData, ...mockData]),
    );

    await testFile.delete();
  });
}
